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
    <title>System Reports - PearlTrails Admin</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

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

        /* Sidebar Styling */
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

        /* Main Content */
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

        .report-card {
            background: var(--card-white);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.05);
            border: 1.5px solid var(--border-soft);
        }

        .report-metric-box {
            background: var(--bg-body);
            border: 1.5px solid var(--border-soft);
            border-radius: 16px;
            padding: 1.5rem;
            text-align: center;
        }
        .report-metric-box h2 {
            font-family: 'Fraunces', serif;
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--ocean-blue);
            margin-top: 0.5rem;
            margin-bottom: 0;
        }

        /* Buttons (Gold Theme) */
        .btn-custom-main {
            background-color: var(--gold) !important;
            border: none !important;
            color: #1f2d2c !important;
            border-radius: 999px !important;
            font-weight: 700 !important;
            padding: 0.6rem 1.4rem;
            transition: background 0.15s ease;
        }
        .btn-custom-main:hover { background-color: var(--gold-light) !important; }

        @media print {
            .sidebar, .top-navbar, .no-print { display: none !important; }
            .main-content { margin-left: 0 !important; padding: 0 !important; }
            .report-card { border: none !important; box-shadow: none !important; padding: 0 !important; }
        }
    </style>
</head>
<body>

    <!-- SIDEBAR -->
    <div class="sidebar no-print">
        <a href="/admin" class="sidebar-brand"><span></span> PearlTrails Admin</a>
        <div class="sidebar-category">Navigation</div>
        <ul class="nav flex-column">
            <li class="nav-item"><a href="/admin" class="nav-link"><i class="fa-solid fa-house"></i> Dashboard</a></li>
            <li class="nav-item"><a href="/admin/users" class="nav-link"><i class="fa-solid fa-users"></i> Manage Users</a></li>
            <li class="nav-item"><a href="/admin/listings" class="nav-link"><i class="fa-solid fa-hotel"></i> Approve Listings</a></li>
            <li class="nav-item"><a href="/admin/reviews" class="nav-link"><i class="fa-solid fa-star-half-stroke"></i> Manage Reviews</a></li>
            <li class="nav-item"><a href="/admin/reports" class="nav-link active"><i class="fa-solid fa-chart-line"></i> Generate Reports</a></li>
            <li class="nav-item"><a href="/admin/create-promo" class="nav-link"><i class="fa-solid fa-tags"></i> Create Promo Code</a></li>
            <li class="nav-item mt-4"><a href="/logout" class="nav-link text-danger"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
        </ul>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">

        <div class="top-navbar">
            <h4 class="fw-bold m-0" style="font-family: 'Fraunces', serif; color: var(--ocean-blue); font-size: 1.8rem;">System Performance Report</h4>
            <div class="d-flex align-items-center gap-3 no-print">
                <button onclick="window.print()" class="btn btn-custom-main btn-sm fw-bold px-3 py-2"><i class="fa-solid fa-print me-1"></i> Print Report</button>
                <a href="/admin/export-report" class="btn btn-sm btn-outline-success fw-bold px-3 py-2 rounded-pill"><i class="fa-solid fa-file-excel me-1"></i> Export CSV</a>
            </div>
        </div>

        <!-- Report Summary Section -->
        <div class="report-card">
            <div class="text-center mb-5 pb-3 border-bottom">
                <h3 class="fw-bold" style="font-family: 'Fraunces', serif; color: var(--ocean-blue); font-size: 2.2rem;">PearlTrails Tourism Platform</h3>
                <p class="text-muted mb-0">Official System Activity and Statistics Summary Report</p>
            </div>

            <div class="row g-4 mb-5">
                <div class="col-md-3">
                    <div class="report-metric-box">
                        <small class="text-muted fw-bold d-block">Total Registered Users</small>
                        <h2>${totalUsers}</h2>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="report-metric-box">
                        <small class="text-muted fw-bold d-block">Total Stays / Listings</small>
                        <h2>${totalListings}</h2>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="report-metric-box">
                        <small class="text-muted fw-bold d-block">Total Transports</small>
                        <h2>${totalTransports}</h2>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="report-metric-box">
                        <small class="text-muted fw-bold d-block">Total Travel Packages</small>
                        <h2>${totalPackages}</h2>
                    </div>
                </div>
            </div>

            <div class="table-responsive mt-4">
                <h5 class="fw-bold mb-3" style="font-family: 'Fraunces', serif; color: var(--ocean-blue); font-size: 1.4rem;">System Entities Overview</h5>
                <table class="table table-bordered align-middle">
                    <thead style="background-color: var(--ocean-blue); color: #ffffff;">
                        <tr>
                            <th class="py-3 px-3">Category</th>
                            <th class="py-3 px-3">Active Count in System</th>
                            <th class="py-3 px-3">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="py-3 px-3">Registered Users (Tourists, Providers, Agents, Admins)</td>
                            <td class="py-3 px-3"><span class="fw-bold">${totalUsers}</span></td>
                            <td class="py-3 px-3"><span class="badge bg-success">Operational</span></td>
                        </tr>
                        <tr>
                            <td class="py-3 px-3">Hotels, Villas & Attractions (Listings)</td>
                            <td class="py-3 px-3"><span class="fw-bold">${totalListings}</span></td>
                            <td class="py-3 px-3"><span class="badge bg-success">Operational</span></td>
                        </tr>
                        <tr>
                            <td class="py-3 px-3">Vehicle & Transport Services</td>
                            <td class="py-3 px-3"><span class="fw-bold">${totalTransports}</span></td>
                            <td class="py-3 px-3"><span class="badge bg-success">Operational</span></td>
                        </tr>
                        <tr>
                            <td class="py-3 px-3">Curated Travel Packages</td>
                            <td class="py-3 px-3"><span class="fw-bold">${totalPackages}</span></td>
                            <td class="py-3 px-3"><span class="badge bg-success">Operational</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="mt-5 pt-3 border-top text-muted small d-flex justify-content-between">
                <span>PearlTrails Automated Reporting System</span>
                <span>Confidential - For Admin Use Only</span>
            </div>
        </div>

    </div>

</body>
</html>