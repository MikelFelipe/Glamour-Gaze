            // SIDEBAR JS START

let arrow = document.querySelectorAll(".arrow");
for (var i = 0; i < arrow.length; i++) {
    arrow[i].addEventListener("click", (e) => {
        let arrowParent = e.target.parentElement.parentElement;
        arrowParent.classList.toggle("showMenu");
    });
}

let sidebar = document.querySelector(".sidebar");
let sidebarBtn = document.querySelector(".bx-menu");
sidebarBtn.addEventListener("click", () => {
    sidebar.classList.toggle("close");
});

document.addEventListener('DOMContentLoaded', function() {
    const navLinks = document.querySelectorAll('.nav-links > li > a'); // Main links
    const subMenuLinks = document.querySelectorAll('.nav-links li .sub-menu a'); // Submenu links
    const titleText = document.querySelector('.home-section .home-content .text');
    const contentArea = document.getElementById('content-area'); // Get content area

    // Function to update the title text
    function updateTitleText(text) {
        titleText.textContent = text;
    }

    // Add click event listeners for main nav links
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            // Update the title text with the main link name
            updateTitleText(this.querySelector('.link_name').textContent);
            // Call switchContent with the data-content attribute
            switchContent(this.getAttribute('data-content'));
        });
    });

    // Add click event listeners for submenu links
    subMenuLinks.forEach(link => {
        link.addEventListener('click', function(event) {
            event.stopPropagation(); // Prevent the click from bubbling up to the parent nav link
            // Update the title text with the submenu link name
            updateTitleText(this.textContent); // Update with the text of the submenu link
            // Call switchContent with the data-content attribute
            switchContent(this.getAttribute('data-content'));
        });
    });
});

            // SIDEBAR JS END

            // FOR SWITCHING TAB IN SIDEBAR START           

function switchContent(contentId) {
    const contentMap = {
        dashboardContent: `
        <div class="dashboardContent">
            <div class="todo-list">
                <h2>To Do List</h2>
                <p>Things you need to do</p>
                <div class="todo-container">
                    <div class="todo-item">
                        <span class="number">5</span>
                        <a href="#" class="todo-link">Unpaid</a>
                    </div>
                    <div class="todo-item">
                        <span class="number">2</span>
                        <a href="#" class="todo-link">Pending Pickup</a>
                    </div>
                    <div class="todo-item">
                        <span class="number">10</span>
                        <a href="#" class="todo-link">Pending Cancellation</a>
                    </div>
                    <div class="todo-item">
                        <span class="number">3</span>
                        <a href="#" class="todo-link">Sold-out Products</a>
                    </div>
                </div>
            </div>

            <div class="insights-sales-group">
                <div class="insights-group">
                    <h2>Insights</h2>
                    <p>Metrics Overview</p>
                    <canvas id="insightsChart" style="max-width: 600px;"></canvas>
                </div>
                <div class="sales-group">
                    <h2>Sales</h2>
                    <p>Sales Overview</p>
                </div>
            </div>
        </div>
        `,
        myOrdersContent: `
            <div class="content-container">
                <div class="order-container">
                    <div class="order-navigation">
                        <button class="nav-button active" data-filter="all">All</button>
                        <button class="nav-button" data-filter="toShip">To Ship</button>
                        <button class="nav-button" data-filter="completed">Completed</button>
                        <button class="nav-button" data-filter="cancellation">Cancellation</button>
                    </div>

                    <div class="order-search">
                        <input type="text" class="search-input" placeholder="Search orders...">
                        <select class="category-dropdown">
                            <option value="" disabled selected hidden>Select a Category</option>
                            <option value="electronics">Skincare Products</option>
                            <option value="fashion">Haircare Solutions</option>
                            <option value="makeup">Makeup & Cosmetics</option>
                            <option value="appliances">Personal Care Appliances</option>
                            <option value="grooming">Men's Grooming</option>
                            <option value="health">Health Supplements</option>
                        </select>
                    </div>
                </div>

                <div id="order-details">
                    <!-- This is where the default All Orders content will be loaded -->
                </div>
            </div>
        `,


        cancellationContent: "<h2>Cancellation</h2><p>Manage your cancellations here.</p>",
        handoverContent: `
            <div class="handover-content-container">
                <p>Pickup</p>

                <div class="order-search">
                    <input type="text" class="search-input" placeholder="Search orders...">
                    <select class="category-dropdown">
                        <option value="" disabled selected hidden>Select a Category</option>
                        <option value="electronics">Skincare Products</option>
                        <option value="fashion">Haircare Solutions</option>
                        <option value="makeup">Makeup & Cosmetics</option>
                        <option value="appliances">Personal Care Appliances</option>
                        <option value="grooming">Men's Grooming</option>
                        <option value="health">Health Supplements</option>
                    </select>
                </div>

                <div id="handover-details">
                    <table class="handover-details">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Order Total</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Moisturizing Cream</td>
                                <td>$35.00</td>
                                <td>
                                    <button class="pickup-btn">
                                        <i class="fas fa-box"></i> Pickup
                                    </button>
                                    <button class="details-btn">
                                        <i class="fas fa-info-circle"></i> Details
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        `,


        myProductsContent: `
        <div class="myProductContent">
            <div class="product-filters">
                <div class="filter-buttons">
                    <button class="filter-btn active" data-filter="all">All</button>
                    <button class="filter-btn" data-filter="listed">Listed</button>
                    <button class="filter-btn" data-filter="unlisted">Unlisted</button>
                </div>
                <div class="action-buttons">
                    <button class="action-btn add-btn">
                        <i class="fas fa-plus"></i>
                    </button>
                    <button class="action-btn edit-btn">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="action-btn remove-btn">
                        <i class="fas fa-minus"></i> <!-- Changed to minus icon -->
                    </button>
                </div>
            </div>

            <div class="order-search">
                    <input type="text" class="search-input" placeholder="Search orders...">
                    <select class="category-dropdown">
                        <option value="" disabled selected hidden>Select a Category</option>
                        <option value="electronics">Skincare Products</option>
                        <option value="fashion">Haircare Solutions</option>
                        <option value="makeup">Makeup & Cosmetics</option>
                        <option value="appliances">Personal Care Appliances</option>
                        <option value="grooming">Men's Grooming</option>
                        <option value="health">Health Supplements</option>
                    </select>
                </div>

            <div id="product-list">
                <table class="product-details">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Sales</th>
                            <th>Price</th>
                            <th>Stocks</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="all listed">
                            <td>Facial Cleanser</td>
                            <td>150</td>
                            <td>$15.00</td>
                            <td>100</td>
                            <td>
                                <button class="action-btn edit-btn">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="action-btn remove-btn">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </td>
                        </tr>
                        <tr class="all unlisted">
                            <td>Shampoo</td>
                            <td>200</td>
                            <td>$12.00</td>
                            <td>50</td>
                            <td>
                                <button class="action-btn edit-btn">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="action-btn remove-btn">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </td>

                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        `,

        addProductContent: `
        <div class = "addProductContent">
            <div class="add-product-container">
                <div class="header-container">
                    <p>Basic Information</p>
                    <p>Sales Information</p>
                </div>
            </div>

            <div class="form-section">
                <h3>Basic Information</h3>
                <div class="basic-info">
                    <div class="form-group">
                        <label for="product-images">Product Images</label>
                        <input type="file" id="product-images" multiple>
                    </div>

                    <div class="form-group">
                        <label for="product-name">Product Name</label>
                        <input type="text" id="product-name" placeholder="Enter product name...">
                    </div>

                    <div class="form-group">
                        <label for="product-category">Category</label>
                        <select id="product-category">
                            <option value="" disabled selected hidden>Select category</option>
                            <option value="electronics">Skincare Products</option>
                            <option value="fashion">Haircare Solutions</option>
                            <option value="makeup">Makeup & Cosmetics</option>
                            <option value="appliances">Personal Care Appliances</option>
                            <option value="grooming">Men's Grooming</option>
                            <option value="health">Health Supplements</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="product-description">Description</label>
                        <textarea id="product-description" placeholder="Enter product description..."></textarea>
                    </div>
                </div>
            </div>



            <div class="form-section">
                <h3>Sales Information</h3>
                <div class="sales-info">
                    <label for="product-price">Price</label>
                    <input type="number" id="product-price" placeholder="Enter price">

                    <label for="product-stock">Stock Quantity</label>
                    <input type="number" id="product-stock" placeholder="Enter stock quantity">

                </div>
            </div>

            
        </div>`,



        salesIncomeContent: `
        <div class = "finance-container">
            <h2>Finance Overview</h2>
            <div id="finance-overview">
                <div id="totalIncomeContainer" class="income-container">
                    <h3>
                        <span class="icon-container total-income-icon">
                            <i class="fas fa-dollar-sign income-icon"></i>
                        </span>
                        Total Income
                    </h3>
                    <div class="trend-info">
                        <span class="total-number">$12,000</span>
                        <div class="trend-details">
                            <i class="fas fa-arrow-up trend-icon" style="color: green;"></i>
                            <span class="percentage" style="color: green;">+8%</span>
                        </div>
                    </div>
                    <canvas id="totalIncomeChart" class="chart"></canvas>
                </div>

                <div id="weeklyIncomeContainer" class="income-container">
                    <h3>
                        <span class="icon-container weekly-income-icon">
                            <i class="fas fa-calendar-week income-icon"></i>
                        </span>
                        Total Income This Week
                        <button class="show-details-btn" onclick="toggleChart('weeklyIncomeChart', 'lastWeekIncomeChart')">Show Last Week</button>
                    </h3>
                    <div class="trend-info">
                        <span class="total-number">$3,200</span>
                        <div class="trend-details">
                            <i class="fas fa-arrow-down trend-icon" style="color: red;"></i>
                            <span class="percentage" style="color: red;">-5%</span>
                        </div>
                    </div>
                    <canvas id="weeklyIncomeChart" class="chart"></canvas>
                    <canvas id="lastWeekIncomeChart" class="chart" style="display: none;"></canvas>
                </div>

                <div id="dailyIncomeContainer" class="income-container">
                    <h3>
                        <span class="icon-container daily-income-icon">
                            <i class="fas fa-calendar-day income-icon"></i>
                        </span>
                        Total Income Today
                        <button class="show-details-btn" onclick="toggleChart('dailyIncomeChart', 'yesterdayIncomeChart')">Show Yesterday</button>
                    </h3>
                    <div class="trend-info">
                        <span class="total-number">$800</span>
                        <div class="trend-details">
                            <i class="fas fa-arrow-up trend-icon" style="color: green;"></i>
                            <span class="percentage" style="color: green;">+2%</span>
                        </div>
                    </div>
                    <canvas id="dailyIncomeChart" class="chart"></canvas>
                    <canvas id="yesterdayIncomeChart" class="chart" style="display: none;"></canvas>
                </div>
            </div>

            <!-- Sales Report Section -->
            <div class="sales-report-container">
                <h2>Sales Report
                    <button class="export-btn" onclick="exportReport()">Export</button>
                </h2>
                <!-- Sales Report Table -->
                <table class="sales-report-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Date of Sale</th>
                            <th>Quantity</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Product A</td>
                            <td>2024-10-13</td>
                            <td>5</td>
                            <td>$100</td>
                        </tr>
                        <tr>
                            <td>Product B</td>
                            <td>2024-10-12</td>
                            <td>3</td>
                            <td>$75</td>
                        </tr>
                        <!-- Add more rows as needed -->
                    </tbody>
                </table>
            </div>
        </div>
`


    };

    // Load content based on the content ID
    const contentArea = document.getElementById('content-area');
    contentArea.innerHTML = contentMap[contentId] || "";

    // After loading dashboard content, initialize the chart
    if (contentId === 'dashboardContent') {
        createBarChart();
    }

    // Initialize order navigation buttons and open the "All Orders" tab by default
    if (contentId === 'myOrdersContent') {
        initializeOrderNavButtons();

        // Automatically open the "All Orders" content
        document.querySelector('.nav-button[data-filter="all"]').click();
    }
    // Call these functions when loading the sales income content
    if (contentId === 'salesIncomeContent') {
        createTotalIncomeChart();
        createWeeklyIncomeChart();
        createLastWeekIncomeChart();
        createDailyIncomeChart();
        createYesterdayIncomeChart();
    }
    
}

            // FOR SWITCHING TAB IN SIDEBAR END




function toggleChart(chartId, comparisonChartId) {
    const mainChart = document.getElementById(chartId);
    const comparisonChart = document.getElementById(comparisonChartId);

    // Toggle visibility
    if (comparisonChart.style.display === "none") {
        mainChart.style.display = "none";
        comparisonChart.style.display = "block";
    } else {
        mainChart.style.display = "block";
        comparisonChart.style.display = "none";
    }
}

function createTotalIncomeChart() {
    const ctx = document.getElementById('totalIncomeChart').getContext('2d');

    const data = {
        labels: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'], // Change labels as necessary
        datasets: [
            {
                label: 'Total Income',
                data: [1000, 1200, 1400, 1300, 1500, 1700, 1600], // Sample data for total income
                borderColor: 'rgba(75, 192, 192, 1)',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                fill: true,
                tension: 0.4,
                pointRadius: 3, // Set point radius to show points on hover
                pointHoverRadius: 6 // Increase hover radius for better visibility
            }
        ]
    };

    const options = {
        responsive: true,
        maintainAspectRatio: true, // Prevent overflow
        plugins: {
            legend: {
                display: false, // Hide the legend
            },
            tooltip: {
                enabled: true, // Enable tooltips
                callbacks: {
                    label: function(tooltipItem) {
                        return `Income: $${tooltipItem.raw}`; // Show only income value
                    },
                    title: function() {
                        return ''; // Hide tooltip title
                    }
                },
            }
        },
        scales: {
            x: {
                display: false, // Hide x-axis labels
            },
            y: {
                display: false, // Hide y-axis labels
                beginAtZero: true,
            }
        }
    };

    new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
}

function createWeeklyIncomeChart() {
    const ctx = document.getElementById('weeklyIncomeChart').getContext('2d');

    const data = {
        labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
        datasets: [
            {
                data: [3000, 3200, 3100, 3500, 3300, 3600, 3400],
                borderColor: 'rgba(153, 102, 255, 1)',
                backgroundColor: 'rgba(153, 102, 255, 0.2)',
                fill: true,
                tension: 0.4,
                pointRadius: 3,
                pointHoverRadius: 6
            }
        ]
    };

    const options = {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
            legend: {
                display: false, // Hide the legend
            },
            tooltip: {
                enabled: true, // Enable tooltips
                callbacks: {
                    label: function(tooltipItem) {
                        return '$' + tooltipItem.raw; // Show the value as currency
                    }
                }
            }
        },
        scales: {
            x: {
                display: false, // Hide x-axis labels
            },
            y: {
                display: false, // Hide y-axis labels
                beginAtZero: true,
            }
        }
    };

    new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
}

function createLastWeekIncomeChart() {
    const ctx = document.getElementById('lastWeekIncomeChart').getContext('2d');

    const data = {
        labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
        datasets: [
            {
                data: [2800, 2900, 3000, 3200, 3100, 3400, 3300],
                borderColor: 'rgba(255, 159, 64, 1)',
                backgroundColor: 'rgba(255, 159, 64, 0.2)',
                fill: true,
                tension: 0.4,
                pointRadius: 3,
                pointHoverRadius: 6
            }
        ]
    };

    const options = {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
            legend: {
                display: false, // Hide the legend
            },
            tooltip: {
                enabled: true, // Enable tooltips
                callbacks: {
                    label: function(tooltipItem) {
                        return '$' + tooltipItem.raw; // Show the value as currency
                    }
                }
            }
        },
        scales: {
            x: {
                display: false, // Hide x-axis labels
            },
            y: {
                display: false, // Hide y-axis labels
                beginAtZero: true,
            }
        }
    };

    new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
}

function createDailyIncomeChart() {
    const ctx = document.getElementById('dailyIncomeChart').getContext('2d');

    const data = {
        labels: ['12 AM', '6 AM', '12 PM', '6 PM', '12 AM'],
        datasets: [
            {
                data: [100, 150, 200, 250, 300],
                borderColor: 'rgba(75, 192, 192, 1)',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                fill: true,
                tension: 0.4,
                pointRadius: 3,
                pointHoverRadius: 6
            }
        ]
    };

    const options = {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
            legend: {
                display: false, // Hide the legend
            },
            tooltip: {
                enabled: true, // Enable tooltips
                callbacks: {
                    label: function(tooltipItem) {
                        return '$' + tooltipItem.raw; // Show the value as currency
                    }
                }
            }
        },
        scales: {
            x: {
                display: false, // Hide x-axis labels
            },
            y: {
                display: false, // Hide y-axis labels
                beginAtZero: true,
            }
        }
    };

    new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
}

function createYesterdayIncomeChart() {
    const ctx = document.getElementById('yesterdayIncomeChart').getContext('2d');

    const data = {
        labels: ['12 AM', '6 AM', '12 PM', '6 PM', '12 AM'],
        datasets: [
            {
                data: [80, 120, 150, 220, 260],
                borderColor: 'rgba(255, 99, 132, 1)',
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                fill: true,
                tension: 0.4,
                pointRadius: 3,
                pointHoverRadius: 6
            }
        ]
    };

    const options = {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
            legend: {
                display: false, // Hide the legend
            },
            tooltip: {
                enabled: true, // Enable tooltips
                callbacks: {
                    label: function(tooltipItem) {
                        return '$' + tooltipItem.raw; // Show the value as currency
                    }
                }
            }
        },
        scales: {
            x: {
                display: false, // Hide x-axis labels
            },
            y: {
                display: false, // Hide y-axis labels
                beginAtZero: true,
            }
        }
    };

    new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
}







            
            // FOR SWITCHING NAV IN MY ORDERS START 

function initializeOrderNavButtons() {
    const orderButtons = document.querySelectorAll('.order-navigation .nav-button');
    const orderDetails = document.getElementById('order-details');

    orderButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Remove active class from all buttons
            orderButtons.forEach(btn => btn.classList.remove('active'));
            // Add active class to the clicked button
            this.classList.add('active');

            const filter = this.getAttribute('data-filter');
            switch (filter) {
                case 'all':
                    orderDetails.innerHTML = `
                        <h3>All Orders</h3>
                        <p>Here are all your orders.</p>
                        <table class="order-table">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Order Total</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="product-info">
                                        <div class="buyer-info">
                                            <img src="path_to_image/buyer.jpg" alt="Buyer Image" class="buyer-image" />
                                            <span class="buyer-name">John Doe</span>
                                        </div>
                                        <div class="product-section">
                                            <img src="path_to_image/skincare-set.jpg" alt="Skincare Set" class="product-image" />
                                            <div class="product-details">
                                                <strong>Skincare Set</strong>
                                                <p>A complete skincare set for glowing skin.</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td>$49.99</td>
                                    <td>Completed</td>
                                </tr>
                            </tbody>
                        </table>
                    `;
                    break;
                case 'toShip':
                    orderDetails.innerHTML = "<h3>To Ship</h3><p>Details for orders that are to be shipped.</p>";
                    break;
                case 'completed':
                    orderDetails.innerHTML = "<h3>Completed Orders</h3><p>Details for orders that have been completed.</p>";
                    break;
                case 'cancellation':
                    orderDetails.innerHTML = "<h3>Cancelled Orders</h3><p>Details for orders that have been cancelled.</p>";
                    break;
                default:
                    orderDetails.innerHTML = "<p>Select an order status to view details.</p>";
            }
        });
    });
}

            // FOR SWITCHING NAV IN MY ORDERS END 

            // FOR BAR GRAPH IN DASHBORD START 

function createBarChart() {
    const ctx = document.getElementById('insightsChart').getContext('2d');

    const data = {
        labels: ['Visitors', 'Page Views', 'Orders', 'Income'],
        datasets: [
            {
                label: 'Today',
                data: [200, 1500, 200, 1500], // Today's data values
                backgroundColor: ['#3498db', '#2ecc71', '#f39c12', '#e74c3c'], // Different colors for today's bars
                borderColor: ['#2980b9', '#27ae60', '#e67e22', '#c0392b'],
                borderWidth: 1
            },
            {
                label: 'Yesterday',
                data: [180, 1300, 220, 1400], // Yesterday's data values
                backgroundColor: ['#95a5a6', '#7f8c8d', '#bdc3c7', '#34495e'], // Different colors for yesterday's bars
                borderColor: ['#7f8c8d', '#7f8c8d', '#bdc3c7', '#34495e'],
                borderWidth: 1
            }
        ]
    };

    const options = {
        scales: {
            y: {
                beginAtZero: true
            }
        },
        plugins: {
            legend: {
                display: true, // Display the legend to distinguish Today and Yesterday
                position: 'top'
            }
        }
    };

    const chart = new Chart(ctx, {
        type: 'bar', // Specify bar chart type
        data: data,
        options: options
    });
}

            // FOR BAR GRAPH IN DASHBORD END


            
// Call switchContent to load dashboard content on page load
window.onload = function() {
    switchContent('dashboardContent');
};
