<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - PearlTrails</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600;9..144,700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            --sidebar-width: 270px;
            --ocean-blue: #1b3a4b;
            --teal-deep: #163c37;
            --gold: #c9973f;
            --gold-light: #e0b866;
            --bg-body: #f8faf9;
            --card-white: #ffffff;
            --border-soft: #e3e9e8;
            --text-dark: #1f2d2c;
            --text-muted: #64777a;
        }

        body {
            background-color: var(--bg-body);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
            font-size: 1.05rem;
            line-height: 1.6;
        }

        /* Sidebar Styling (Deep Teal / Modern Gradient) */
        .sidebar {
            width: var(--sidebar-width);
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            background: #ffffff;
            border-right: 1.5px solid var(--border-soft);
            padding: 2rem 1.25rem;
            z-index: 100;
            box-shadow: 4px 0 20px rgba(27, 58, 75, 0.03);
        }
        .sidebar-brand {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 1.4rem;
            color: var(--ocean-blue);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 2.5rem;
        }
        .sidebar-brand span {
            width: 10px;
            height: 10px;
            background: var(--gold);
            border-radius: 50%;
            display: inline-block;
        }

        .sidebar-category {
            font-size: 0.75rem;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: var(--text-muted);
            font-weight: 700;
            margin-bottom: 0.75rem;
            padding-left: 0.75rem;
        }

        .nav-link {
            color: var(--text-muted);
            font-weight: 600;
            font-size: 1rem;
            padding: 0.85rem 1rem;
            border-radius: 12px;
            margin-bottom: 0.4rem;
            display: flex;
            align-items: center;
            gap: 0.85rem;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        .nav-link:hover {
            background: rgba(27, 58, 75, 0.08);
            color: var(--ocean-blue);
        }
        .nav-link.active {
            background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep));
            color: #ffffff !important;
            box-shadow: 0 4px 15px rgba(27, 58, 75, 0.2);
        }

        /* Main Content Layout */
        .main-content { margin-left: var(--sidebar-width); padding: 2.5rem; }

        .top-navbar {
            background: var(--card-white);
            border-radius: 20px;
            padding: 1.25rem 2rem;
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.05);
            border: 1.5px solid var(--border-soft);
            margin-bottom: 2.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Stat Cards */
        .stat-card {
            background: var(--card-white);
            border-radius: 20px;
            padding: 1.75rem;
            border: 1.5px solid var(--border-soft);
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.05);
            height: 100%;
            transition: transform 0.2s ease;
        }
        .stat-card:hover { transform: translateY(-3px); }
        .stat-card h3 { font-family: 'Fraunces', serif; font-size: 2.2rem; font-weight: 700; color: var(--ocean-blue); margin: 0.5rem 0 0 0; }

        /* Chart Cards */
        .chart-card {
            background: var(--card-white);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.05);
            border: 1.5px solid var(--border-soft);
            margin-bottom: 1.5rem;
        }
        .chart-card h5 {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            color: var(--ocean-blue);
            font-size: 1.35rem;
        }

        /* Buttons (Gold Theme) */
        .btn-custom-main {
            background-color: var(--gold) !important;
            border: none !important;
            color: #1f2d2c !important;
            border-radius: 999px !important;
            font-weight: 700 !important;
            padding: 0.5rem 1.25rem;
            transition: background 0.15s ease;
        }
        .btn-custom-main:hover { background-color: var(--gold-light) !important; }
    </style>
</head>
<body>

    <!-- SIDEBAR -->
    <div class="sidebar">
        <a href="/admin" class="sidebar-brand"><span></span> PearlTrails Admin</a>
        <div class="sidebar-category">Navigation</div>
        <ul class="nav flex-column">
            <li class="nav-item"><a href="/admin" class="nav-link active"><i class="fa-solid fa-house"></i> Dashboard</a></li>
            <li class="nav-item"><a href="/admin/users" class="nav-link"><i class="fa-solid fa-users"></i> Manage Users</a></li>
            <li class="nav-item"><a href="/admin/listings" class="nav-link"><i class="fa-solid fa-hotel"></i> Approve Listings</a></li>
            <li class="nav-item"><a href="/admin/reviews" class="nav-link"><i class="fa-solid fa-star-half-stroke"></i> Manage Reviews</a></li>
            <li class="nav-item"><a href="/admin/reports" class="nav-link"><i class="fa-solid fa-chart-line"></i> Generate Reports</a></li>
            <li class="nav-item"><a href="/admin/create-promo" class="nav-link"><i class="fa-solid fa-tags"></i> Create Promo Code</a></li>
            <li class="nav-item mt-4"><a href="/logout" class="nav-link text-danger"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
        </ul>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">

        <!-- Top Navbar -->
        <div class="top-navbar">
            <h4 class="fw-bold m-0" style="font-family: 'Fraunces', serif; color: var(--ocean-blue); font-size: 1.8rem;">Admin Dashboard</h4>
            <div class="d-flex align-items-center gap-3">
                <a href="/admin/export-report" class="btn btn-sm btn-outline-success fw-bold px-3 py-2 rounded-pill"><i class="fa-solid fa-file-excel me-1"></i> Export CSV Report</a>
                <span class="fw-semibold small">👤 Administrator</span>
            </div>
        </div>

        <!-- Real System Metrics Cards -->
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="stat-card">
                    <span class="text-muted small fw-bold"><i class="fa-solid fa-users text-primary me-1"></i> Total Registered Users</span>
                    <h3>${totalUsers}</h3>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <span class="text-muted small fw-bold"><i class="fa-solid fa-hotel text-warning me-1"></i> Total Stays / Listings</span>
                    <h3>${totalListings}</h3>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <span class="text-muted small fw-bold"><i class="fa-solid fa-box text-success me-1"></i> Total Travel Packages</span>
                    <h3>${totalPackages}</h3>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <span class="text-muted small fw-bold"><i class="fa-solid fa-car text-info me-1"></i> Total Transports</span>
                    <h3>${totalTransports}</h3>
                </div>
            </div>
        </div>

        <!-- Pending Reviews Shortcut Card -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="stat-card border-start border-warning border-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="text-muted small fw-bold"><i class="fa-solid fa-star text-warning me-1"></i> Pending Reviews</span>
                        <a href="/admin/reviews" class="btn btn-sm btn-warning fw-bold px-3 py-1 rounded-pill" style="font-size: 0.8rem;">View All</a>
                    </div>
                    <h3>${pendingReviews}</h3>
                </div>
            </div>
        </div>

        <!-- Charts Row -->
        <div class="row g-4 mb-4">
            <div class="col-lg-8">
                <div class="chart-card">
                    <h5 class="fw-bold mb-3">Platform Activity Overview</h5>
                    <canvas id="salesChart" height="130"></canvas>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="chart-card">
                    <h5 class="fw-bold mb-3">System Distribution</h5>
                    <canvas id="performanceChart" height="260"></canvas>
                </div>
            </div>
        </div>

    </div>

    <script>
        const ctxSales = document.getElementById('salesChart').getContext('2d');
        new Chart(ctxSales, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
                datasets: [{
                    label: 'Platform Activity',
                    data: [10, 25, 40, 30, 55, 70, 85],
                    borderColor: '#1b3a4b',
                    backgroundColor: 'rgba(27, 58, 75, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: { responsive: true }
        });

        const ctxPerf = document.getElementById('performanceChart').getContext('2d');
        new Chart(ctxPerf, {
            type: 'bar',
            data: {
                labels: ['Users', 'Listings', 'Packages', 'Transports'],
                datasets: [{
                    label: 'Count',
                    data: [${totalUsers}, ${totalListings}, ${totalPackages}, ${totalTransports}],
                    backgroundColor: ['#1b3a4b', '#c9973f', '#2fae66', '#0dcaf0'],
                    borderRadius: 6
                }]
            },
            options: { responsive: true, plugins: { legend: { display: false } } }
        });
    </script>
</body>
</html>