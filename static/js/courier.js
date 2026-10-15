// ===============================
// Initialization & Event Listeners
// ===============================
document.addEventListener('DOMContentLoaded', function() {
    // Profile dropdown logic
    const profileBtn = document.getElementById('profile-btn');
    if (profileBtn) {
        const dropdown = profileBtn.querySelector('.profile-dropdown');
        profileBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            profileBtn.classList.toggle('open');
        });
        document.addEventListener('click', function(e) {
            if (!profileBtn.contains(e.target)) {
                profileBtn.classList.remove('open');
            }
        });
    }

    // Tab and filter event listeners
    const deliveriesTab = document.querySelector('a[onclick*="deliveries"]');
    if (deliveriesTab) deliveriesTab.addEventListener('click', loadMyDeliveries);

    const availableTab = document.querySelector('a[onclick*="available"]');
    if (availableTab) availableTab.addEventListener('click', loadAvailableDeliveries);

    const earningsTab = document.querySelector('a[onclick*="earnings"]');
    if (earningsTab) earningsTab.addEventListener('click', loadEarningsDeliveries);

    const statusFilter = document.getElementById('delivery-status-filter');
    if (statusFilter) statusFilter.addEventListener('change', filterDeliveriesByStatus);

    // Chat sample data
    const chatList = document.getElementById('chat-list');
    if (chatList) {
        const sampleUsers = [
            { name: "Maria Santos", lastMessage: "When will my package arrive?", unread: 2 },
            { name: "Juan Dela Cruz", lastMessage: "Thank you for the delivery!", unread: 0 },
            { name: "Ana Reyes", lastMessage: "Please call me when you arrive", unread: 1 }
        ];
        sampleUsers.forEach(user => {
            const li = document.createElement('li');
            li.innerHTML = `
                <div class="username-container">
                    <div class="username">${user.name}</div>
                    ${user.unread ? `<span class="unread-badge">${user.unread}</span>` : ''}
                </div>
                <div class="last-message">${user.lastMessage}</div>
            `;
            li.addEventListener('click', function() {
                document.getElementById('business-name').textContent = user.name;
            });
            chatList.appendChild(li);
        });
    }

    // Chat send button
    const sendBtn = document.getElementById('send-message-btn');
    const messageInput = document.getElementById('message-input');
    if (sendBtn && messageInput) {
        sendBtn.addEventListener('click', function() {
            const message = messageInput.value.trim();
            if (message) {
                const messagesContainer = document.getElementById('chat-messages');
                const messageElement = document.createElement('div');
                messageElement.classList.add('chat-message', 'sent');
                messageElement.textContent = message;
                messagesContainer.appendChild(messageElement);
                messageInput.value = '';
                messagesContainer.scrollTop = messagesContainer.scrollHeight;
            }
        });
        messageInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendBtn.click();
            }
        });
    }

    // Initial tab and dashboard data
    openTab('infoDashboard', 'Dashboard');
    loadCourierDashboardData();
});

// ===============================
// Dashboard Data Loader
// ===============================
function loadCourierDashboardData() {
    fetch('/courier_dashboard_data')
        .then(response => response.json())
        .then(data => {
            document.getElementById('todays-delivery-count').textContent = data.todays_delivery;
            document.getElementById('completed-delivery-count').textContent = data.completed_today;
            document.getElementById('in-progress-count').textContent = data.in_progress;
            document.getElementById('todays-earnings-amount').textContent = `₱${Number(data.todays_earnings).toLocaleString(undefined, {minimumFractionDigits:2})}`;
            document.getElementById('earnings-week').textContent = `₱${Number(data.earnings_week || 0).toLocaleString(undefined, {minimumFractionDigits:2})}`;
            document.getElementById('earnings-month').textContent = `₱${Number(data.earnings_month || 0).toLocaleString(undefined, {minimumFractionDigits:2})}`;
            document.getElementById('earnings-alltime').textContent = `₱${Number(data.earnings_all || 0).toLocaleString(undefined, {minimumFractionDigits:2})}`;
        });
}

// ===============================
// Tab Navigation
// ===============================
function openTab(tabName, tabDisplayName) {
    // Hide all content divs
    const contents = document.querySelectorAll('.content');
    contents.forEach(content => {
        content.style.display = 'none';
    });

    // Show the selected tab content
    const currentTab = document.getElementById(tabName);
    if (currentTab) {
        currentTab.style.display = 'block';
        setTimeout(() => {
            currentTab.classList.add('active');
        }, 10);
    }

    // Update the current tab title in the navbar
    const currentTabElement = document.getElementById('current-tab');
    if (currentTabElement) {
        currentTabElement.textContent = tabDisplayName || tabName;
    }

    // Update active class on sidebar menu items
    const menuLinks = document.querySelectorAll('.sidebar .menu a');
    menuLinks.forEach(link => {
        link.classList.remove('active');
    });
    const clickedLink = document.querySelector(`.sidebar .menu a[onclick*="'${tabName}'"]`);
    if (clickedLink) {
        clickedLink.classList.add('active');
    }
}

// ===============================
// Data Variables
// ===============================
let allDeliveries = [];
let allAvailableDeliveries = [];
let allEarningsDeliveries = [];

let deliveriesCurrentPage = 1;
let availableCurrentPage = 1;
let earningsCurrentPage = 1;
const PAGE_SIZE = 10;

// ===============================
// Pagination Helpers
// ===============================
function paginate(array, page_size, page_number) {
    return array.slice((page_number - 1) * page_size, page_number * page_size);
}

function renderPaginationControls(containerId, totalItems, currentPage, onPageChange) {
    const pageSize = PAGE_SIZE;
    const totalPages = Math.ceil(totalItems / pageSize);
    const container = document.getElementById(containerId);
    if (!container) return;
    container.innerHTML = '';

    if (totalPages <= 1) return;

    for (let i = 1; i <= totalPages; i++) {
        const btn = document.createElement('button');
        btn.textContent = i;
        btn.className = 'pagination-btn' + (i === currentPage ? ' active' : '');
        btn.onclick = () => onPageChange(i);
        container.appendChild(btn);
    }
}

// ===============================
// My Deliveries Operations & Filtering
// ===============================
function loadMyDeliveries() {
    fetch('/courier/my_deliveries')
        .then(response => response.json())
        .then(data => {
            allDeliveries = data.deliveries || [];
            deliveriesCurrentPage = 1;
            showCourierOrderContent('all');
        });
}

function renderDeliveriesTable(deliveries, page = 1, filteredMode = false) {
    const tbody = document.querySelector('#deliveries .delivery-table tbody');
    tbody.innerHTML = '';
    let filtered = deliveries;

    // Exclude "Completed" from "All" tab in My Deliveries
    if (filteredMode) {
        const activeBtn = document.querySelector('.order-nav button.active');
        const isAllTab = activeBtn && activeBtn.textContent.trim().toLowerCase() === 'all';
        if (isAllTab) {
            filtered = deliveries.filter(delivery => delivery.status !== 'Completed');
        }
    }

    if (!filteredMode) {
        const filter = document.getElementById('delivery-status-filter') ? document.getElementById('delivery-status-filter').value : 'all';
        if (filter !== 'all') {
            filtered = deliveries.filter(delivery => delivery.status === filter);
        }
    }
    const pageData = paginate(filtered, PAGE_SIZE, page);
    if (pageData.length > 0) {
        pageData.forEach(delivery => {
            const customOrderId = `GGZ-#${delivery.order_id}`;
            // Use product_image from orders table
            let imageSrc = delivery.product_image ? `/static/upload_images/${delivery.product_image}` : '';
            // Show Proof of Delivery button if status is "To Receive", show View Proof if Completed, otherwise show View button
            let actions = '';
            if (delivery.status === 'To Receive') {
                actions = `<button class="action-btn btn-primary btn-sm" onclick="openProofUploadModal('${encodeURIComponent(JSON.stringify(delivery))}')">Proof</button>`;
            } else if (delivery.status === 'Delivered' && delivery.proof_of_delivery) {
                actions = `<button class="action-btn btn-primary btn-sm" onclick="openProofViewModal('${encodeURIComponent(JSON.stringify(delivery))}')">View</button>`;
            } else if (delivery.status === 'Completed' && delivery.proof_of_delivery) {
                actions = `<button class="action-btn btn-primary btn-sm" onclick="openProofViewModal('${encodeURIComponent(JSON.stringify(delivery))}')">View</button>`;
            } else {
                actions = `<button class="action-btn btn-secondary btn-sm" onclick="viewDelivery('${encodeURIComponent(JSON.stringify(delivery))}')">View</button>`;
            }

            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${customOrderId}</td>
                <td>
                    ${imageSrc ? `<img src="${imageSrc}" alt="Product Image" style="width:50px;height:50px;object-fit:cover;border-radius:6px;">` : ''}
                </td>
                <td>${delivery.customer_name}</td>
                <td>${delivery.productName || ''}</td>
                <td>${delivery.pickup_location}</td>
                <td>${delivery.status}</td>
                <td>₱${Number(delivery.productPrice).toFixed(2)}</td>
                <td>₱${Number(delivery.delivery_fee).toFixed(2)}</td>
                <td>
                    ${actions}
                </td>
            `;
            tbody.appendChild(tr);
        });
    } else {
        const tr = document.createElement('tr');
        tr.innerHTML = `<td colspan="9" style="text-align:center;">No deliveries found.</td>`;
        tbody.appendChild(tr);
    }
    renderPaginationControls('deliveries-pagination', filtered.length, page, (newPage) => {
        deliveriesCurrentPage = newPage;
        renderDeliveriesTable(filtered, newPage, filteredMode);
    });
}



// Filtering via order-nav buttons
function showCourierOrderContent(status) {
    document.querySelectorAll('.order-nav button').forEach(btn => btn.classList.remove('active'));
    const btn = Array.from(document.querySelectorAll('.order-nav button')).find(b => 
        b.getAttribute('onclick') && b.getAttribute('onclick').includes(`'${status}'`)
    );
    if (btn) btn.classList.add('active');

    document.querySelectorAll('.order-content-section').forEach(sec => sec.classList.remove('active-content'));
    document.getElementById('courier-order-content-all').classList.add('active-content');

    let filtered;
    if (status === 'all') {
        filtered = allDeliveries;
    } else if (status === 'to-ship') {
        filtered = allDeliveries.filter(d => d.status === 'To Ship');
    } else if (status === 'to-receive') {
        filtered = allDeliveries.filter(d => d.status === 'To Receive');
    } else if (status === 'delivered') {
        filtered = allDeliveries.filter(d => d.status === 'Delivered');
    } else if (status === 'completed') {
        filtered = allDeliveries.filter(d => d.status === 'Completed');
    } else if (status === 'cancelled') {
        filtered = allDeliveries.filter(d => d.status === 'Cancelled');
    } else {
        filtered = allDeliveries;
    }
    deliveriesCurrentPage = 1;
    renderDeliveriesTable(filtered, deliveriesCurrentPage, true);
}

// Filtering via dropdown (if present)
function filterDeliveriesByStatus() {
    deliveriesCurrentPage = 1;
    renderDeliveriesTable(allDeliveries, deliveriesCurrentPage);
}

// ===============================
// Available Deliveries Operations
// ===============================
function loadAvailableDeliveries() {
    fetch('/courier/available_deliveries')
        .then(response => response.json())
        .then(data => {
            allAvailableDeliveries = data.deliveries || [];
            availableCurrentPage = 1;
            renderAvailableTable(allAvailableDeliveries, availableCurrentPage);
        });
}

function viewAvailableDelivery(deliveryJson) {
    const delivery = JSON.parse(decodeURIComponent(deliveryJson));
    let html = `
        <div class="proof-modal-columns">
            <div class="proof-modal-column">
                <h4>Delivery Info</h4>
                <div class="proof-modal-field"><span class="field-label">Order ID:</span><span class="field-value">${delivery.order_id || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Customer:</span><span class="field-value">${delivery.customer_name || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Seller Name:</span><span class="field-value">${delivery.seller_name || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Product Name:</span><span class="field-value">${delivery.productName || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Pickup Location:</span><span class="field-value">${delivery.pickup_location || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Delivery Location:</span><span class="field-value">${delivery.delivery_location || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Status:</span><span class="field-value">${delivery.status || 'Waiting for Courier'}</span></div>
                <div class="proof-modal-field"><span class="field-label">Product Price:</span><span class="field-value">₱${Number(delivery.productPrice).toFixed(2)}</span></div>
                <div class="proof-modal-field"><span class="field-label">Delivery Fee:</span><span class="field-value">₱${Number(delivery.delivery_fee).toFixed(2)}</span></div>
            </div>
        </div>
    `;
    document.getElementById('proof-modal-body').innerHTML = html;
    document.getElementById('proof-modal').style.display = 'flex';
}

// Update renderAvailableTable to use this function for the View button:

function renderAvailableTable(deliveries, page = 1) {
    const tbody = document.querySelector('#available .delivery-table tbody');
    tbody.innerHTML = '';
    const pageData = paginate(deliveries, PAGE_SIZE, page);
    if (pageData.length > 0) {
        pageData.forEach(delivery => {
            let imageSrc = delivery.product_image ? `/static/upload_images/${delivery.product_image}` : '';
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>GGZ-#${delivery.order_id}</td>
                <td>
                    ${imageSrc ? `<img src="${imageSrc}" alt="Product Image" style="width:50px;height:50px;object-fit:cover;border-radius:6px;">` : ''}
                </td>
                <td>${delivery.customer_name}</td>
                <td>${delivery.productName || ''}</td>
                <td>${delivery.pickup_location}</td>
                <td>${delivery.status || 'Waiting for Courier'}</td>
                <td>₱${Number(delivery.productPrice).toFixed(2)}</td>
                <td>₱${Number(delivery.delivery_fee).toFixed(2)}</td>
                <td>
                    <button class="action-btn btn-primary btn-sm" onclick="acceptDelivery(${delivery.order_id})">Accept</button>
                    <button class="action-btn btn-secondary btn-sm" onclick="viewAvailableDelivery('${encodeURIComponent(JSON.stringify(delivery))}')">View</button>
                </td>
            `;
            tbody.appendChild(tr);
        });
    } else {
        const tr = document.createElement('tr');
        tr.innerHTML = `<td colspan="9" style="text-align:center;">No available deliveries.</td>`;
        tbody.appendChild(tr);
    }
    renderPaginationControls('available-pagination', deliveries.length, page, (newPage) => {
        availableCurrentPage = newPage;
        renderAvailableTable(allAvailableDeliveries, newPage);
    });
}


function acceptDelivery(order_id) {
    fetch(`/accept_delivery/${order_id}`, { method: 'POST' })
        .then(response => response.json())
        .then(data => {
            alert(data.message || 'Delivery accepted!');
            loadAvailableDeliveries();
            loadMyDeliveries();
        });
}

// ===============================
// Earnings Operations
// ===============================
function loadEarningsDeliveries() {
    fetch('/courier/my_deliveries')
        .then(response => response.json())
        .then(data => {
            // Filter for completed deliveries and sort by delivered_at DESC (most recent first)
            let filtered = (data.deliveries || []).filter(delivery =>
                delivery.status === 'Completed'
            );
            filtered.sort((a, b) => {
                if (a.delivered_at && b.delivered_at) {
                    return new Date(b.delivered_at) - new Date(a.delivered_at);
                }
                return (b.order_id || 0) - (a.order_id || 0);
            });
            allEarningsDeliveries = filtered;
            earningsCurrentPage = 1;
            renderEarningsTable(allEarningsDeliveries, earningsCurrentPage);
        });
}

function renderEarningsTable(deliveries, page = 1) {
    const tbody = document.querySelector('#earnings .delivery-table tbody');
    tbody.innerHTML = '';
    const pageData = paginate(deliveries, PAGE_SIZE, page);
    if (pageData.length > 0) {
        pageData.forEach(delivery => {
            const customOrderId = `GGZ-#${delivery.order_id}`;
            let imageSrc = delivery.product_image ? `/static/upload_images/${delivery.product_image}` : '';
            let actions = '';
            if (delivery.proof_of_delivery) {
                actions = `<button class="action-btn btn-primary btn-sm" onclick="openProofViewModal('${encodeURIComponent(JSON.stringify(delivery))}')">View</button>`;
            } else {
                actions = `<button class="action-btn btn-secondary btn-sm" onclick="viewDelivery('${encodeURIComponent(JSON.stringify(delivery))}')">View</button>`;
            }
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${customOrderId}</td>
                <td>
                    ${imageSrc ? `<img src="${imageSrc}" alt="Product Image" style="width:50px;height:50px;object-fit:cover;border-radius:6px;">` : ''}
                </td>
                <td>${delivery.customer_name}</td>
                <td>${delivery.productName || ''}</td>
                <td>${delivery.pickup_location}</td>
                <td>${delivery.status}</td>
                <td>₱${Number(delivery.productPrice).toFixed(2)}</td>
                <td>₱${Number(delivery.delivery_fee).toFixed(2)}</td>
                <td>
                    ${actions}
                </td>
            `;
            tbody.appendChild(tr);
        });
    } else {
        const tr = document.createElement('tr');
        tr.innerHTML = `<td colspan="9" style="text-align:center;">No completed deliveries found.</td>`;
        tbody.appendChild(tr);
    }
    renderPaginationControls('earnings-pagination', deliveries.length, page, (newPage) => {
        earningsCurrentPage = newPage;
        renderEarningsTable(allEarningsDeliveries, newPage);
    });
}

// ===============================
// Modal: View Delivery Details
// ===============================
function viewDelivery(deliveryJson) {
    const delivery = JSON.parse(decodeURIComponent(deliveryJson));
    let html = '';
    const fields = [
        { label: 'Order ID', key: 'order_id' },
        { label: 'Customer Name', key: 'customer_name' },
        { label: 'Product Name', key: 'productName' },
        { label: 'Delivery Location', key: 'delivery_location' },
        { label: 'Seller Name', key: 'seller_name' },
        { label: 'Pickup Location', key: 'pickup_location' },
        { label: 'Status', key: 'status', default: 'Waiting for Courier' },
        { label: 'Product Price', key: 'productPrice', format: v => `₱${Number(v).toFixed(2)}` },
        { label: 'Delivery Fee', key: 'delivery_fee', format: v => `₱${Number(v).toFixed(2)}` }
    ];
    fields.forEach(f => {
        let value = delivery[f.key];
        if (f.format) value = f.format(value);
        if (f.key === 'status' && !value) value = f.default;
        html += `<div class="delivery-modal-row"><span class="delivery-modal-label">${f.label}:</span><span class="delivery-modal-value">${value ?? ''}</span></div>`;
    });
    for (const key in delivery) {
        if (!fields.map(f => f.key).includes(key)) {
            html += `<div class="delivery-modal-row"><span class="delivery-modal-label">${key.replace(/_/g, ' ')}:</span><span class="delivery-modal-value">${delivery[key]}</span></div>`;
        }
    }

    // Proof of Delivery Upload Section (only for "To Receive")
    if (delivery.status === 'To Receive') {
        html += `
        <div id="proof-upload-section" style="margin-top: 15px;">
            <label for="proof-files">Upload Proof of Delivery (images):</label>
            <input type="file" id="proof-files" name="proof_files" accept="image/*" multiple>
            <button onclick="submitProofOfDelivery('${delivery.order_id}')">Submit Proof</button>
        </div>
        `;
    }

    document.getElementById('delivery-modal-content').innerHTML = html;
    document.getElementById('delivery-modal').style.display = 'flex';
}

function submitProofOfDelivery(orderId) {
    const files = document.getElementById('proof-files').files;
    if (!files.length) {
        alert('Please select at least one image.');
        return;
    }
    const formData = new FormData();
    for (let i = 0; i < files.length; i++) {
        formData.append('proof_images', files[i]);
    }
    formData.append('order_id', orderId);

    fetch('/courier/upload_proof_of_delivery', {
        method: 'POST',
        body: formData
    })
    .then(res => res.json())
    .then(data => {
        alert(data.message || 'Proof uploaded!');
        closeDeliveryModal();
        loadMyDeliveries();
    });
}

function closeDeliveryModal() {
    document.getElementById('delivery-modal').style.display = 'none';
}

function openProofModal(deliveryJson) {
    const delivery = JSON.parse(decodeURIComponent(deliveryJson));

    // Format date/time if available
    const completedDate = delivery.completed_time ?
        new Date(delivery.completed_time).toISOString().split('T')[0] : '';
    const completedTime = delivery.completed_time ?
        new Date(delivery.completed_time).toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'}) : '';

    // If proof_of_delivery is a string, split by comma for multiple images
    let proofPhotos = [];
    if (delivery.proof_of_delivery) {
        proofPhotos = delivery.proof_of_delivery.split(',').map(f => `/static/upload_images/${f.trim()}`);
    }

    let html = `
        <div class="proof-modal-columns">
            <!-- Left Column -->
            <div class="proof-modal-column">
                <h4>Delivery Info</h4>
                <div class="proof-modal-field"><span class="field-label">Order ID:</span><span class="field-value">${delivery.order_id || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Customer:</span><span class="field-value">${delivery.customer_name || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Seller Name:</span><span class="field-value">${delivery.seller_name || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Pickup Location:</span><span class="field-value">${delivery.pickup_location || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Delivery Location:</span><span class="field-value">${delivery.delivery_location || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Status:</span><span class="field-value">${delivery.status || ''}</span></div>
            </div>
            <!-- Right Column -->
            <div class="proof-modal-column">
                <h4>Proof of Delivery</h4>
                ${
                    delivery.status === 'To Receive'
                    ? `
                        <div class="photos-section">
                            <label for="proof-files" style="font-weight: 600; color: #d37389; display: block; margin-bottom: 0.5em;">
                                Upload Proof of Delivery (images):
                            </label>
                            <input type="file" id="proof-files" name="proof_files" accept="image/*" multiple style="margin-bottom: 1em; width: 100%;" onchange="previewProofImages(event)">
                            <div id="proof-preview" style="display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 1em;"></div>
                            <button 
                                onclick="submitProofOfDelivery('${delivery.order_id}')"
                                style="width: 100%; padding: 10px 0; background: linear-gradient(135deg, #d37389, #dc3545); color: #fff; border: none; border-radius: 8px; font-weight: 600; font-size: 1em; cursor: pointer; transition: background 0.2s;">
                                Upload Proof
                            </button>
                        </div>
                    `
                    : `
                        <div class="photos-section">
                            <h5>Photos</h5>
                            <div class="delivery-photos">
                                ${
                                    proofPhotos.length
                                    ? proofPhotos.map(photo => `<img src="${photo}" class="delivery-photo" alt="Proof photo">`).join('')
                                    : `<div class="photo-placeholder"><div class="placeholder-box">No photos</div></div>`
                                }
                            </div>
                        </div>
                    `
                }
            </div>
        </div>
        <div class="proof-modal-actions">
            <button class="action-button print-button" onclick="window.print()">
                <i class="print-icon">🖨️</i> Print
            </button>
        </div>
    `;
    document.getElementById('proof-modal-body').innerHTML = html;
    document.getElementById('proof-modal').style.display = 'flex';
}

function closeProofModal() {
    document.getElementById('proof-modal').style.display = 'none';
}

function previewProofImages(event) {
    const files = event.target.files;
    const preview = document.getElementById('proof-preview');
    preview.innerHTML = '';
    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const reader = new FileReader();
        reader.onload = function(e) {
            const img = document.createElement('img');
            img.src = e.target.result;
            img.style.width = '90px';
            img.style.height = '90px';
            img.style.objectFit = 'cover';
            img.style.borderRadius = '8px';
            img.style.border = '1.5px solid #d37389';
            preview.appendChild(img);
        };
        reader.readAsDataURL(file);
    }
}
function submitProofOfDelivery(orderId) {
    const files = document.getElementById('proof-files').files;
    if (!files.length) {
        alert('Please select at least one image.');
        return;
    }
    const formData = new FormData();
    for (let i = 0; i < files.length; i++) {
        formData.append('proof_images', files[i]);
    }
    formData.append('order_id', orderId);

    fetch('/courier/upload_proof_of_delivery', {
        method: 'POST',
        body: formData
    })
    .then(res => res.json())
    .then(data => {
        alert(data.message || 'Proof uploaded!');
        closeProofModal();
        loadMyDeliveries();
    });
}

function openProofUploadModal(deliveryJson) {
    const delivery = JSON.parse(decodeURIComponent(deliveryJson));
    let html = `
        <div class="proof-modal-columns">
            <div class="proof-modal-column">
                <h4>Delivery Info</h4>
                <div class="proof-modal-field"><span class="field-label">Order ID:</span><span class="field-value">${delivery.order_id || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Customer:</span><span class="field-value">${delivery.customer_name || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Seller Name:</span><span class="field-value">${delivery.seller_name || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Pickup Location:</span><span class="field-value">${delivery.pickup_location || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Delivery Location:</span><span class="field-value">${delivery.delivery_location || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Status:</span><span class="field-value">${delivery.status || ''}</span></div>
            </div>
            <div class="proof-modal-column">
                <h4>Proof of Delivery</h4>
                <div class="photos-section">
                    <label for="proof-files" style="font-weight: 600; color: #d37389; display: block; margin-bottom: 0.5em;">
                        Upload Proof of Delivery (images):
                    </label>
                    <input type="file" id="proof-files" name="proof_files" accept="image/*" multiple style="margin-bottom: 1em; width: 100%;" onchange="previewProofImages(event)">
                    <div id="proof-preview" style="display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 1em;"></div>
                    <button 
                        onclick="submitProofOfDelivery('${delivery.order_id}')"
                        style="width: 100%; padding: 10px 0; background: linear-gradient(135deg, #d37389, #dc3545); color: #fff; border: none; border-radius: 8px; font-weight: 600; font-size: 1em; cursor: pointer; transition: background 0.2s;">
                        Upload Proof
                    </button>
                </div>
            </div>
        </div>
    `;
    document.getElementById('proof-modal-body').innerHTML = html;
    document.getElementById('proof-modal').style.display = 'flex';
}

function openProofViewModal(deliveryJson) {
    const delivery = JSON.parse(decodeURIComponent(deliveryJson));
    let proofPhotos = [];
    if (delivery.proof_of_delivery) {
        proofPhotos = delivery.proof_of_delivery.split(',').map(f => `/static/upload_images/${f.trim()}`);
    }
    let html = `
        <div class="proof-modal-columns">
            <div class="proof-modal-column">
                <h4>Delivery Info</h4>
                <div class="proof-modal-field"><span class="field-label">Order ID:</span><span class="field-value">${delivery.order_id || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Customer:</span><span class="field-value">${delivery.customer_name || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Seller Name:</span><span class="field-value">${delivery.seller_name || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Pickup Location:</span><span class="field-value">${delivery.pickup_location || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Delivery Location:</span><span class="field-value">${delivery.delivery_location || ''}</span></div>
                <div class="proof-modal-field"><span class="field-label">Status:</span><span class="field-value">${delivery.status || ''}</span></div>
            </div>
            <div class="proof-modal-column">
                <h4>Proof of Delivery</h4>
                <div class="photos-section">
                    <h5>Photos</h5>
                    <div class="delivery-photos">
                        ${
                            proofPhotos.length
                            ? proofPhotos.map(photo => `<img src="${photo}" class="delivery-photo" alt="Proof photo">`).join('')
                            : `<div class="photo-placeholder"><div class="placeholder-box">No photos</div></div>`
                        }
                    </div>
                </div>
            </div>
        </div>
    `;
    document.getElementById('proof-modal-body').innerHTML = html;
    document.getElementById('proof-modal').style.display = 'flex';
}