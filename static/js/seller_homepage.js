// ==============================================
// 1. INITIALIZATION & DASHBOARD DATA FETCHING
// ==============================================

// Initialize dashboard on page load
window.onload = function() {
    fetchSellerDashboardData();
};

// Fetch and display seller dashboard data
function fetchSellerDashboardData() {
    let searchValue = document.getElementById('finance-search') ? document.getElementById('finance-search').value.toLowerCase() : '';
    let startDate = document.getElementById('start-date') ? document.getElementById('start-date').value : '';
    let endDate = document.getElementById('end-date') ? document.getElementById('end-date').value : '';

    let searchParams = `search=${encodeURIComponent(searchValue)}`;
    if (startDate) {
        startDate = startDate.replace("T", " ") + ":00";
        searchParams += `&start_date=${encodeURIComponent(startDate)}`;
    }
    if (endDate) {
        endDate = endDate.replace("T", " ") + ":00";
        searchParams += `&end_date=${encodeURIComponent(endDate)}`;
    }

    fetch('/seller_dashboard_data?' + searchParams)
        .then(response => response.json())
        .then(data => {
            updateDashboardMetrics(data);
            updateCompletedOrdersTable(data);
        })
        .catch(error => {
            console.error('Error fetching seller dashboard data:', error);
        });
}

// Update dashboard metrics
function updateDashboardMetrics(data) {
    if (data.cart_count !== undefined && data.low_stock_count !== undefined && 
        data.pending_shipment_count !== undefined && data.total_orders_count !== undefined) {
        document.getElementById('cartCount').innerText = data.cart_count;
        document.getElementById('lowStockCount').innerText = data.low_stock_count;
        document.getElementById('pendingShipment').innerText = data.pending_shipment_count;
        document.getElementById('totalOrders').innerText = data.total_orders_count;
    }
}

// Update completed orders table
function updateCompletedOrdersTable(data) {
    const tableBody = document.getElementById('completedOrdersTable').querySelector('tbody');
    tableBody.innerHTML = '';
    let totalNet = 0;
    
    if (data.completed_orders && data.completed_orders.length > 0) {
        data.completed_orders.forEach(order => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${order.username}</td>
                <td>${order.phoneNumber}</td>
                <td>${order.productName}</td>
                <td>${order.quantity}</td>
                <td>${order.business_name}</td>
                <td>${order.total}</td>
                <td>${order.payment_method}</td>
                <td>${order.created_at}</td>
                <td>${order.total_gross}</td>
                <td>${order.total_net}</td>
            `;
            tableBody.appendChild(row);
            totalNet += parseFloat(order.total_net);
        });
    } else {
        const row = document.createElement('tr');
        row.innerHTML = '<td colspan="10">No matching orders found.</td>';
        tableBody.appendChild(row);
    }
    document.getElementById('totalNet').textContent = totalNet.toFixed(2);
}

// Set up event listeners for dashboard
document.getElementById('finance-search')?.addEventListener('keyup', fetchSellerDashboardData);
document.getElementById('start-date')?.addEventListener('change', fetchSellerDashboardData);
document.getElementById('end-date')?.addEventListener('change', fetchSellerDashboardData);

// Refresh dashboard data every 5 seconds
setInterval(fetchSellerDashboardData, 5000);

// ==============================================
// 2. EXPORT FUNCTIONS (CSV & PDF)
// ==============================================

// Export table data to CSV
function exportToCSV() {
    const table = document.getElementById("completedOrdersTable");
    const rows = table.querySelectorAll("tr");
    let csvContent = "";
    
    rows.forEach(row => {
        const cols = row.querySelectorAll("td, th");
        const rowData = Array.from(cols).map(col => `"${col.textContent}"`).join(",");
        csvContent += rowData + "\n";
    });
    
    const blob = new Blob([csvContent], { type: "text/csv" });
    const link = document.createElement("a");
    link.href = URL.createObjectURL(blob);
    link.download = "completed_orders.csv";
    link.click();
}

// Export table data to PDF
async function exportToPDF() {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();
    const customColor = "#e91e63";
    const rgb = hexToRgb(customColor);
    
    // Add header information
    doc.setFontSize(18);
    doc.setFont("helvetica", "bold");
    doc.setTextColor(rgb.r, rgb.g, rgb.b);
    doc.text("Glamour Gaze", 105, 15, { align: "center" });
    doc.setFontSize(12);
    doc.setFont("helvetica", "normal");
    doc.text("Philippines, Laguna", 105, 25, { align: "center" });
    doc.text("Contact: glamourgaze33@gmail.com | Phone: +63 123 456 7890", 105, 35, { align: "center" });
    doc.text("Website: www.glamourgaze.com", 105, 45, { align: "center" });
    
    // Add export date
    doc.setTextColor(0, 0, 0);
    const currentDate = new Date().toLocaleString("en-PH", { timeZone: "Asia/Manila" });
    doc.text(`Export Date: ${currentDate}`, 10, 65);
    
    // Add table data
    const table = document.getElementById('completedOrdersTable');
    const headers = Array.from(table.querySelectorAll('thead th')).map(th => th.textContent.trim());
    const rows = Array.from(table.querySelectorAll('tbody tr')).map(row =>
        Array.from(row.querySelectorAll('td')).map(td => td.textContent.trim())
    );
    
    doc.autoTable({
        head: [headers],
        body: rows,
        startY: 70,
        margin: { left: 10, right: 10 },
        theme: 'grid',
        headStyles: {
            fillColor: [rgb.r, rgb.g, rgb.b],
            textColor: 255,
            fontStyle: 'bold',
        },
    });
    
    // Add page numbers
    const pageCount = doc.internal.getNumberOfPages();
    for (let i = 1; i <= pageCount; i++) {
        doc.setPage(i);
        const pageHeight = doc.internal.pageSize.height;
        doc.setFontSize(10);
        doc.text(`Page ${i} of ${pageCount}`, 105, pageHeight - 10, { align: "center" });
    }
    
    // Save the PDF
    const formattedDate = new Date().toISOString().split('T')[0];
    const fileName = `Export_${formattedDate}.pdf`;
    doc.save(fileName);
}

// Helper function to convert hex to RGB
function hexToRgb(hex) {
    const bigint = parseInt(hex.replace("#", ""), 16);
    return {
        r: (bigint >> 16) & 255,
        g: (bigint >> 8) & 255,
        b: bigint & 255,
    };
}

// ==============================================
// 3. TAB NAVIGATION & SIDEBAR MANAGEMENT
// ==============================================

// Switch between tabs
function openTab(tabName, tabDisplayName, event) {
    if (event) event.preventDefault();
    
    // Hide all content sections
    var content = document.getElementsByClassName("content");
    for (var i = 0; i < content.length; i++) {
        content[i].style.display = 'none';
    }
    
    // Show selected tab and update active state
    var tab = document.getElementById(tabName);
    if (tab) tab.style.display = 'block';
    if (tabDisplayName) document.getElementById('current-tab').innerText = tabDisplayName;
}

// Set up active state for menu links
const menuLinks = document.querySelectorAll('.menu li a');
menuLinks.forEach(link => {
    link.addEventListener('click', function() {
        menuLinks.forEach(link => link.classList.remove('active'));
        this.classList.add('active');
    });
});

// ==============================================
// 4. ORDER MANAGEMENT FUNCTIONS
// ==============================================

// Ship an order
function shipOrder(element) {
    const orderId = element.closest('td').querySelector('.order-id').value;
    if (!orderId) {
        alert("Order ID is missing.");
        return;
    }
    
    fetch('/ship_order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id: orderId })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert(data.message);
            element.closest('tr').querySelector('td:nth-last-child(2)').textContent = 'To Ship';
        } else {
            alert(data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while shipping the order.');
    });
}

// Switch between order status tabs
function showOrderContent(contentId, btn) {
    // Update active button
    document.querySelectorAll('.order-nav button').forEach(b => b.classList.remove('active'));
    if (btn) btn.classList.add('active');
    
    // Update active content section
    document.querySelectorAll('.order-content-section').forEach(section => section.classList.remove('active-content'));
    const activeSection = document.getElementById(`order-content-${contentId}`);
    if (activeSection) activeSection.classList.add('active-content');
    
    // Fetch relevant orders based on tab
    switch(contentId) {
        case 'to-ship': fetchToShipOrders(); break;
        case 'to-receive': fetchToReceiveOrders(); break;
        case 'completed': fetchCompletedOrders(); break;
        case 'cancelled': fetchCancelledOrders(); break;
        case 'refund': fetchRefundOrders(); break;
    }
}

// ==============================================
// 5. ORDER STATUS FETCHING FUNCTIONS
// ==============================================

// Fetch orders to ship
function fetchToShipOrders() {
    fetch('/to-ship-orders')
        .then(response => response.json())
        .then(data => {
            const tableBody = document.getElementById('to-ship-orders-body');
            tableBody.innerHTML = '';
            
            if (data.to_ship_orders && data.to_ship_orders.length > 0) {
                data.to_ship_orders.forEach(order => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td class="product-details">
                            <div class="username">${order.username}</div>
                            <div class="product-info">
                                <img src="${order.product_image}" alt="${order.productName}" width="50">
                                <span class="product-name">${order.productName}</span>
                            </div>
                        </td>
                        <td>${order.quantity}</td>
                        <td>$${order.total}</td>
                        <td>${order.payment_method}</td>
                        <td>${order.status}</td>
                    `;
                    tableBody.appendChild(row);
                });
            } else {
                tableBody.innerHTML = `<tr><td colspan="6">No orders to ship</td></tr>`;
            }
        })
        .catch(error => console.error('Error fetching To Ship orders:', error));
}

// Fetch orders to receive
function fetchToReceiveOrders() {
    fetch('/to-receive-orders')
        .then(response => response.json())
        .then(data => {
            const tableBody = document.getElementById('to-receive-orders-body');
            tableBody.innerHTML = '';
            
            if (data.to_receive_orders && data.to_receive_orders.length > 0) {
                data.to_receive_orders.forEach(order => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td class="product-details">
                            <div class="username">${order.username}</div>
                            <div class="product-info">
                                <img src="${order.product_image}" alt="${order.productName}" width="50">
                                <span class="product-name">${order.productName}</span>
                            </div>
                        </td>
                        <td>${order.quantity}</td>
                        <td>$${order.total}</td>
                        <td>${order.payment_method}</td>
                        <td>${order.status}</td>
                    `;
                    tableBody.appendChild(row);
                });
            } else {
                tableBody.innerHTML = `<tr><td colspan="8">No orders to receive</td></tr>`;
            }
        })
        .catch(error => console.error('Error fetching To Receive orders:', error));
}

// Fetch completed orders
function fetchCompletedOrders() {
    fetch('/completed-orders')
        .then(response => response.json())
        .then(data => {
            const tableBody = document.getElementById('completed-orders-body');
            tableBody.innerHTML = '';
            
            if (data.completed_orders && data.completed_orders.length > 0) {
                data.completed_orders.forEach(order => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td class="product-details">
                            <div class="username">${order.username}</div>
                            <div class="product-info">
                                <img src="${order.product_image}" alt="${order.productName}" width="50">
                                <span class="product-name">${order.productName}</span>
                            </div>
                        </td>
                        <td>${order.quantity}</td>
                        <td>$${order.total}</td>
                        <td>${order.payment_method}</td>
                        <td style="color: #2ddf00;">${order.status}</td>
                    `;
                    tableBody.appendChild(row);
                });
            } else {
                tableBody.innerHTML = `<tr><td colspan="8">No completed orders available.</td></tr>`;
            }
        })
        .catch(error => console.error('Error fetching completed orders:', error));
}

// Fetch cancelled orders
function fetchCancelledOrders() {
    fetch('/cancelled-orders')
        .then(response => response.json())
        .then(data => {
            const tableBody = document.getElementById('cancelled-orders-body');
            tableBody.innerHTML = '';
            
            if (data.cancelled_orders && data.cancelled_orders.length > 0) {
                data.cancelled_orders.forEach(order => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td class="product-details">
                            <div class="username">${order.username}</div>
                            <div class="product-info">
                                <img src="${order.product_image}" alt="${order.productName}" width="50">
                                <span class="product-name">${order.productName}</span>
                            </div>
                        </td>
                        <td>${order.quantity}</td>
                        <td>$${order.total}</td>
                        <td>${order.payment_method}</td>
                        <td>${order.status}</td>
                    `;
                    tableBody.appendChild(row);
                });
            } else {
                tableBody.innerHTML = `<tr><td colspan="8">No cancelled orders available.</td></tr>`;
            }
        })
        .catch(error => console.error('Error fetching cancelled orders:', error));
}

// Set up periodic fetching for order statuses
setInterval(fetchToShipOrders, 1000);
setInterval(fetchToReceiveOrders, 1000);
setInterval(fetchCompletedOrders, 1000);
setInterval(fetchCancelledOrders, 1000);

// ==============================================
// 6. REFUND MANAGEMENT FUNCTIONS
// ==============================================

// Fetch refund orders
function fetchRefundOrders() {
    fetch('/seller-refund-orders')
        .then(response => response.json())
        .then(data => {
            const tableBody = document.getElementById('refund-orders-body');
            tableBody.innerHTML = '';
            
            if (data.refund_orders && data.refund_orders.length > 0) {
                data.refund_orders.forEach(order => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td class="product-details">
                            <div class="username">${order.business_name}</div>
                            <div class="product-info">
                                <img src="${order.product_image}" alt="${order.productName}" width="50">
                                <span class="product-name">${order.productName}</span>
                            </div>
                        </td>
                        <td>${order.quantity}</td>
                        <td>$${order.total}</td>
                        <td>${order.payment_method}</td>
                        <td>${order.status}</td>
                        <td>
                            <button class="view-reason-btn" data-order-id="${order.id}">View Reason</button>
                            <button class="accept-refund-btn" data-order-id="${order.id}" ${order.status === 'Refund' ? 'disabled' : ''}>Accept Refund</button>
                        </td>
                    `;
                    tableBody.appendChild(row);
                });
                
                // Set up event listeners for refund buttons
                document.querySelectorAll('.accept-refund-btn').forEach(button => {
                    button.addEventListener('click', function() {
                        const orderId = button.getAttribute('data-order-id');
                        acceptRefund(orderId, button);
                    });
                });
                
                document.querySelectorAll('.view-reason-btn').forEach(button => {
                    button.addEventListener('click', function() {
                        const orderId = button.getAttribute('data-order-id');
                        viewReason(orderId);
                    });
                });
            } else {
                tableBody.innerHTML = `<tr><td colspan="7">No refund orders available.</td></tr>`;
            }
        })
        .catch(error => console.error('Error fetching refund orders:', error));
}

// View refund reason
function viewReason(orderId) {
    fetch(`/refund-reason/${orderId}`)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const reasonText = document.getElementById('refund-reason-text');
                const imageContainer = document.getElementById('refund-images');
                
                reasonText.textContent = data.reason;
                imageContainer.innerHTML = '';
                
                data.images.forEach(image => {
                    if (image) {
                        const img = document.createElement('img');
                        img.src = image;
                        img.alt = 'Refund Image';
                        img.classList.add('clickable-image');
                        imageContainer.appendChild(img);
                        
                        img.onclick = () => {
                            const enlargedModal = document.getElementById('enlarged-image-modal');
                            const enlargedImage = document.getElementById('enlarged-image');
                            enlargedImage.src = image;
                            enlargedModal.style.display = 'flex';
                        };
                    }
                });
                
                document.getElementById('view-reason-modal').style.display = 'block';
            } else {
                alert('Unable to fetch refund reason.');
            }
        })
        .catch(error => {
            console.error('Error fetching refund reason:', error);
            alert('An error occurred while fetching the refund reason.');
        });
}

// Accept refund request
function acceptRefund(orderId, button) {
    fetch(`/accept-refund/${orderId}`, { method: 'POST' })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Refund request accepted successfully!');
                button.disabled = true;
                button.textContent = 'Accepted';
                button.classList.add('disabled');
                
                const statusCell = button.closest('tr').querySelector('td:nth-child(5)');
                if (statusCell) statusCell.textContent = 'Refund';
            } else {
                alert('Error accepting refund.');
            }
        })
        .catch(error => {
            console.error('Error updating refund status:', error);
            alert('An error occurred while updating the refund status.');
        });
}

// Set up modal event listeners for refunds
document.addEventListener('DOMContentLoaded', () => {
    const closeBtn = document.querySelector('.close-btn');
    const modal = document.getElementById('view-reason-modal');
    const enlargedModal = document.getElementById('enlarged-image-modal');
    const closeEnlargedBtn = document.querySelector('.close-enlarged-btn');
    
    closeBtn.onclick = () => { modal.style.display = 'none'; };
    closeEnlargedBtn.onclick = () => { enlargedModal.style.display = 'none'; };
    
    window.onclick = (event) => {
        if (event.target === modal) modal.style.display = 'none';
        if (event.target === enlargedModal) enlargedModal.style.display = 'none';
    };
});

// Set up periodic fetching for refund orders
setInterval(fetchRefundOrders, 300000);

// ==============================================
// 7. PRODUCT IMAGE PREVIEW FUNCTIONS
// ==============================================

// Preview image for edit
function previewEditImage(input, previewImageId) {
    const file = input.files[0];
    const previewImage = document.getElementById(previewImageId);
    
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            previewImage.src = e.target.result;
            previewImage.style.display = 'block';
            document.getElementById('editPlaceholderText').style.display = 'none';
        }
        reader.readAsDataURL(file);
    } else {
        previewImage.src = '';
        document.getElementById('editPlaceholderText').style.display = 'block';
    }
}

// Main product image preview
document.getElementById('productImage')?.addEventListener('change', function(event) {
    const file = event.target.files[0];
    const previewImage = document.getElementById('previewImage');
    const placeholderText = document.getElementById('placeholderText');
    
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            previewImage.src = e.target.result;
            previewImage.style.display = 'block';
            placeholderText.style.display = 'none';
        };
        reader.readAsDataURL(file);
    } else {
        previewImage.style.display = 'none';
        placeholderText.style.display = 'block';
    }
});

// Sub-image previews
for (let i = 1; i <= 3; i++) {
    document.getElementById(`subImage${i}`)?.addEventListener('change', function(event) {
        const file = event.target.files[0];
        const subImagePreview = document.getElementById(`subImagePreview${i}`);
        const subPlaceholderText = document.getElementById(`subPlaceholderText${i}`);
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                subImagePreview.src = e.target.result;
                subImagePreview.style.display = 'block';
                subPlaceholderText.style.display = 'none';
            };
            reader.readAsDataURL(file);
        } else {
            subImagePreview.style.display = 'none';
            subPlaceholderText.style.display = 'block';
        }
    });
}

// ==============================================
// 8. PRODUCT FILTERING FUNCTIONS
// ==============================================

// Filter products by status (listed/unlisted)
function filterProducts(status) {
    document.getElementById('product_status').value = status;
    
    if (status === 'listed') {
        document.getElementById('listed-products').style.display = 'block';
        document.getElementById('unlisted-products').style.display = 'none';
    } else if (status === 'unlisted') {
        document.getElementById('listed-products').style.display = 'none';
        document.getElementById('unlisted-products').style.display = 'block';
    }
}

// Initialize product filter on page load
document.addEventListener('DOMContentLoaded', function() {
    filterProducts('listed');
});

// ==============================================
// 9. NOTIFICATION MANAGEMENT
// ==============================================

document.addEventListener('DOMContentLoaded', () => {
    const bellIcon = document.querySelector('.notification');
    const notificationDropdown = document.querySelector('.notification-dropdown');
    const notificationList = document.querySelector('#notification-list');
    const notificationCount = document.getElementById('notification-count');
    
    // Update notification count
    function updateNotificationCount() {
        fetch('/fetch_seller_unread_notification_count')
            .then((response) => response.json())
            .then((data) => {
                if (data.success) {
                    const unreadCount = data.unread_count;
                    notificationCount.textContent = unreadCount;
                    notificationCount.style.display = unreadCount === 0 ? 'none' : 'inline-block';
                } else {
                    notificationCount.style.display = 'none';
                }
            })
            .catch(() => { notificationCount.style.display = 'none'; });
    }
    
    // Initial count update
    updateNotificationCount();
    
    // Toggle notification dropdown
    bellIcon.addEventListener('click', () => {
        notificationDropdown.classList.toggle('visible');
        
        if (notificationDropdown.classList.contains('visible')) {
            fetch('/fetch_seller_notifications')
                .then((response) => response.json())
                .then((data) => {
                    if (data.success) {
                        notificationList.innerHTML = '';
                        
                        data.notifications.forEach((notification) => {
                            const notificationItem = document.createElement('li');
                            notificationItem.className = 'notification-item';
                            notificationItem.innerHTML = `
                                <div class="product-details">
                                    <div class="image-wrapper">
                                        <img src="${notification.product_image}" alt="${notification.product_name}">
                                    </div>
                                    <div>
                                        <div class="product-name">${notification.product_name}</div>
                                        <span class="notification-message">${notification.message}</span>
                                    </div>
                                </div>
                            `;
                            notificationList.appendChild(notificationItem);
                        });
                        
                        // Mark notifications as read
                        fetch('/mark_seller_notifications_read', { method: 'POST' })
                            .then((response) => response.json())
                            .then((data) => {
                                notificationCount.textContent = data.unread_count;
                                notificationCount.style.display = data.unread_count === 0 ? 'none' : 'inline-block';
                            });
                    } else {
                        notificationList.innerHTML = `<li>No notifications available.</li>`;
                    }
                })
                .catch(() => { notificationList.innerHTML = `<li>Error fetching notifications.</li>`; });
        }
    });
    
    // Close dropdown when clicking outside
    document.addEventListener('click', (event) => {
        if (!bellIcon.contains(event.target) && !notificationDropdown.contains(event.target)) {
            notificationDropdown.classList.remove('visible');
        }
    });
});

// ==============================================
// 10. ORDER CANCELLATION FUNCTIONS
// ==============================================

// Open cancel order modal
function openCancelModal(element) {
    var modal = document.querySelector(".cancel-order-modal");
    modal.style.display = "flex";
    var orderId = element.closest('tr').querySelector('.order-id').value;
    document.getElementById('cancel-reason').setAttribute('data-order-id', orderId);
}

// Close cancel order modal
function closeCancelModal() {
    var modal = document.querySelector(".cancel-order-modal");
    modal.style.display = "none";
    var cancelReason = document.getElementById('cancel-reason');
    cancelReason.value = "";
    cancelReason.removeAttribute('data-order-id');
}

// Submit cancel order request
function submitCancel() {
    var orderId = document.getElementById('cancel-reason').getAttribute('data-order-id');
    var cancelReason = document.getElementById('cancel-reason').value;
    
    if (cancelReason.trim() === "") {
        alert("Please provide a cancellation reason.");
        return;
    }
    
    fetch('/request-cancel-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ order_id: orderId, cancel_reason: cancelReason })
    })
    .then(response => response.json())
    .then(data => {
        alert(data.message || "The order could not be cancelled.");
        closeCancelModal();
        const orderRow = document.querySelector(`tr[data-order-id="${orderId}"]`);
        if (orderRow) {
            orderRow.querySelector('.status').innerText = 'Cancelled';
        }
    })
    .catch(() => { alert("There was an error cancelling the order."); });
}

// ==============================================
// 11. SELLER CHAT/MESSAGING SYSTEM
// ==============================================

document.addEventListener('DOMContentLoaded', function() {
    fetch('/seller_get_message', {
        method: 'GET',
        headers: { 'Content-Type': 'application/json' },
    })
    .then(response => response.json())
    .then(data => {
        const chatList = document.getElementById('chat-list');
        const chatMessagesContainer = document.getElementById('chat-messages');
        const messageInput = document.getElementById('message-input');
        const sendMessageBtn = document.getElementById('send-message-btn');
        const businessNameElement = document.getElementById('business-name');
        
        if (data && data.length > 0) renderUsersList(data);
        
        // Display messages for a specific user
        function displayMessages(user_id, data) {
            chatMessagesContainer.innerHTML = '';
            const filteredMessages = data.filter(message => message.user_id === user_id);
            
            filteredMessages.forEach(message => {
                const messageElement = document.createElement('div');
                messageElement.classList.add('chat-message');
                const isSellerMessage = message.sender_type && message.sender_type.toLowerCase() === 'seller';
                
                messageElement.innerHTML = `
                    <div class="message-content">${message.message}</div>
                    <div class="message-time">${message.created_at}</div>
                `;
                
                messageElement.classList.add(isSellerMessage ? 'sent' : 'received');
                chatMessagesContainer.appendChild(messageElement);
            });
        }
        
        // Render list of users with messages
        function renderUsersList(data) {
            const users = new Set();
            const lastMessages = {};
            
            data.forEach(message => {
                if (message.user_id && message.username) {
                    users.add(message.user_id);
                    lastMessages[message.user_id] = message.message;
                }
            });
            
            chatList.innerHTML = '';
            const sortedUsers = [...users];
            
            sortedUsers.forEach(user_id => {
                const user = data.find(message => message.user_id === user_id);
                const username = user ? user.username : 'Unknown User';
                const lastMessage = lastMessages[user_id] || 'No messages yet';
                
                const userItem = document.createElement('li');
                userItem.classList.add('chat-user');
                userItem.textContent = username;
                
                const lastMessageDiv = document.createElement('div');
                lastMessageDiv.classList.add('last-message');
                lastMessageDiv.textContent = lastMessage;
                userItem.appendChild(lastMessageDiv);
                
                userItem.dataset.userId = user_id;
                userItem.dataset.orderId = user ? user.order_id : null;
                chatList.prepend(userItem);
                
                userItem.addEventListener('click', function() {
                    displayMessages(user_id, data);
                    chatList.querySelectorAll('.chat-user').forEach(user => user.classList.remove('selected'));
                    userItem.classList.add('selected');
                    businessNameElement.textContent = username;
                });
            });
        }
        
        // Send message handler
        sendMessageBtn.addEventListener('click', function() {
            const messageText = messageInput.value.trim();
            const activeUser = chatList.querySelector('.chat-user.selected');
            const userId = activeUser ? activeUser.dataset.userId : null;
            const orderId = activeUser ? activeUser.dataset.orderId : null;
            
            if (messageText && userId) {
                fetch('/seller-send-message', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        user_id: userId,
                        order_id: orderId,
                        message: messageText,
                        business_name: 'Your Business',
                        sender_type: 'seller',
                    }),
                })
                .then(response => response.json())
                .then(result => {
                    if (result.success) {
                        const newMessageElement = document.createElement('div');
                        newMessageElement.classList.add('chat-message', 'sent');
                        newMessageElement.innerHTML = `
                            <div class="message-content">${messageText}</div>
                            <div class="message-time">${new Date().toLocaleString()}</div>
                        `;
                        chatMessagesContainer.appendChild(newMessageElement);
                        messageInput.value = '';
                    }
                });
            } else {
                alert('Please select a user and enter a message.');
            }
        });
    });
});

// ==============================================
// 12. SALES ANALYTICS & MOST SOLD PRODUCTS
// ==============================================

document.addEventListener('DOMContentLoaded', function() {
    fetch('/get-orders', {
        method: 'GET',
        headers: { 'Content-Type': 'application/json' },
    })
    .then(response => response.json())
    .then(data => {
        const mostSoldProducts = calculateMostSoldProducts(data);
        displayMostSoldProducts(mostSoldProducts);
    });
    
    // Calculate most sold products
    function calculateMostSoldProducts(orders) {
        const productSales = {};
        
        orders.forEach(order => {
            const productId = order.order_id;
            const quantity = order.total_quantity;
            const productImage = order.product_image;
            const productName = order.productName;
            
            if (productSales[productId]) {
                productSales[productId].quantity += quantity;
            } else {
                productSales[productId] = {
                    quantity: quantity,
                    image: productImage,
                    name: productName,
                };
            }
        });
        
        const sortedProducts = Object.entries(productSales).sort((a, b) => b[1].quantity - a[1].quantity);
        return sortedProducts.slice(0, 5).map(item => ({
            productId: item[0],
            quantity: item[1].quantity,
            image: item[1].image,
            name: item[1].name,
        }));
    }
    
    // Display most sold products
    function displayMostSoldProducts(mostSoldProducts) {
        const mostSoldProductsList = document.getElementById('mostSoldProducts');
        mostSoldProductsList.innerHTML = '';
        
        mostSoldProducts.forEach(product => {
            const productItem = document.createElement('li');
            const maxQuantity = 100;
            const soldPercentage = (product.quantity / maxQuantity) * 100;
            
            productItem.innerHTML = `
                <div class="product-item-container">
                    <div class="product-item">
                        <div class="product-info">
                            <div class="product-text-image">
                                <p class="product-name">${product.name}</p>
                                <img src="${product.image}" alt="Product Image" class="product-image">
                            </div>
                            <div class="progress-container" title="${product.quantity} units sold">
                                <div class="progress-bar" style="width: ${soldPercentage}%;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            `;
            mostSoldProductsList.appendChild(productItem);
        });
    }
});

// ==============================================
// 13. PRODUCT SEARCH & CATEGORY FILTER
// ==============================================

document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('search_query');
    const categorySelect = document.getElementById('selected_category');
    const productStatus = document.getElementById('product_status');
    
    function fetchProducts() {
        const query = searchInput.value;
        const category = categorySelect.value;
        const status = productStatus.value;
        
        const params = new URLSearchParams({
            search_query: query,
            selected_category: category,
            product_status: status
        });
        
        fetch(`/my_products?${params.toString()}`, {
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
        .then(response => response.text())
        .then(html => {
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            const newContent = doc.querySelector('.my_products_content');
            
            if (newContent) {
                document.querySelector('.my_products_content').innerHTML = newContent.innerHTML;
            }
        });
    }
    
    if (searchInput && categorySelect) {
        searchInput.addEventListener('input', fetchProducts);
        categorySelect.addEventListener('change', fetchProducts);
    }
});