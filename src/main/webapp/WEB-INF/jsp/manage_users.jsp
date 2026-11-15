<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // Prevent browser caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - PearlTrails Admin</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
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

        /* Admin Navbar Style */
        .navbar-pearltrails-admin {
            background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep)) !important;
            padding: 1rem 1.5rem;
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.15);
        }
        .navbar-pearltrails-admin .navbar-brand {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 1.4rem;
            color: var(--gold) !important;
            letter-spacing: 0.02em;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            text-decoration: none;
        }
        .navbar-pearltrails-admin .navbar-brand .brand-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: var(--gold);
            display: inline-block;
        }
        .navbar-pearltrails-admin .navbar-brand .admin-tag {
            font-family: 'Inter', sans-serif;
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            color: #ffffff;
            background: rgba(201, 151, 63, 0.25);
            border: 1px solid rgba(201, 151, 63, 0.4);
            border-radius: 999px;
            padding: 0.2rem 0.6rem;
            margin-left: 0.4rem;
        }
        .navbar-pearltrails-admin .nav-link {
            font-family: 'Inter', sans-serif;
            font-weight: 600;
            font-size: 1.02rem !important;
            color: rgba(255, 255, 255, 0.85) !important;
            padding: 0.6rem 1.1rem !important;
            border-radius: 12px;
            transition: all 0.2s ease;
        }
        .navbar-pearltrails-admin .nav-link:hover {
            background: rgba(255, 255, 255, 0.12);
            color: var(--gold) !important;
        }
        .navbar-pearltrails-admin .nav-link.logout-link {
            color: #fca5a5 !important;
            font-weight: 700;
        }
        .navbar-pearltrails-admin .nav-link.logout-link:hover {
            background: rgba(239, 68, 68, 0.2);
            color: #ffffff !important;
        }
        .navbar-pearltrails-admin .navbar-toggler {
            border-color: rgba(255, 255, 255, 0.4);
        }

        /* Page Heading */
        .page-heading {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 2rem;
            color: var(--ocean-blue);
        }

        /* Card & Table Styling */
        .admin-card {
            background: var(--card-white);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.05);
            overflow: hidden;
        }
        .table-custom {
            margin-bottom: 0;
            vertical-align: middle;
        }
        .table-custom th {
            background-color: var(--ocean-blue);
            color: #ffffff;
            font-family: 'Fraunces', serif;
            font-weight: 600;
            font-size: 1.05rem;
            padding: 1rem 1.25rem;
            border: none;
        }
        .table-custom td {
            padding: 1rem 1.25rem;
            color: var(--text-dark);
            border-bottom: 1px solid var(--border-soft);
        }
        .table-custom tbody tr:hover {
            background-color: rgba(27, 58, 75, 0.02);
        }

        /* Buttons & Badges */
        .btn-block-custom {
            background-color: #ef4444;
            border: none;
            color: #ffffff;
            border-radius: 999px;
            font-weight: 600;
            padding: 0.4rem 1.25rem;
            transition: opacity 0.15s ease;
        }
        .btn-block-custom:hover { opacity: 0.9; color: #ffffff; }

        .btn-back {
            border: 1.5px solid var(--border-soft);
            color: var(--ocean-blue);
            background: var(--card-white);
            font-weight: 600;
            border-radius: 999px;
            padding: 0.6rem 1.5rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.15s ease;
        }
        .btn-back:hover {
            background: var(--ocean-blue);
            color: #ffffff;
            border-color: var(--ocean-blue);
        }
    </style>
</head>
<body>

    <!-- Include the dedicated Admin Navbar -->
    <jsp:include page="admin_navbar.jsp" />

    <div class="container mt-4 mb-5">
        <h2 class="page-heading mb-1">Manage Users</h2>
        <p class="text-muted mb-4">View all registered users and manage their account statuses.</p>

        <!-- Bootstrap Table inside Card -->
        <div class="card admin-card mb-4">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom align-middle">
                        <thead>
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th class="text-center pe-4">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Loop through the 'users' list sent from the Controller -->
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td class="ps-4 fw-bold">#${user.userId}</td>
                                    <td class="fw-semibold" style="color: var(--ocean-blue);">${user.fullName}</td>
                                    <td class="text-secondary">${user.email}</td>
                                    <td>
                                        <span class="badge bg-info text-dark px-3 py-1.5 rounded-pill fw-bold">${user.role}</span>
                                    </td>
                                    <td>
                                        <!-- If condition to show different colors based on status -->
                                        <c:choose>
                                            <c:when test="${user.accountStatus == 'Active'}">
                                                <span class="badge bg-success px-3 py-1.5 rounded-pill fw-bold"><i class="fa-solid fa-circle-check me-1"></i> Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger px-3 py-1.5 rounded-pill fw-bold"><i class="fa-solid fa-ban me-1"></i> Blocked</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center pe-4">
                                        <!-- Form to send the specific user's ID to the backend when 'Block' is clicked -->
                                        <form action="/admin/users/block" method="post" style="display:inline;">
                                            <!-- Hidden input to secretly pass the userId -->
                                            <input type="hidden" name="userId" value="${user.userId}">

                                            <!-- Disable button if already blocked -->
                                            <c:choose>
                                                <c:when test="${user.accountStatus == 'Active'}">
                                                    <button type="submit" class="btn btn-sm btn-block-custom fw-bold px-3 shadow-sm"><i class="fa-solid fa-user-slash me-1"></i> Block</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button" class="btn btn-sm btn-secondary fw-bold px-3 rounded-pill" disabled>Blocked</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty users}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-5 fst-italic">No users found in the system.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Back to Dashboard button -->
        <a href="/admin" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>