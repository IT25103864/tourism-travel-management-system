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
    <title>Browse Travel Packages - PearlTrails</title>
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
            --bg: #f8faf9;
            --card-bg: #ffffff;
            --text-muted: #64777a;
            --border-soft: #e3e9e8;
            --text-dark: #1f2d2c;
        }

        body {
            background-color: var(--bg);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
            font-size: 1.05rem;
            line-height: 1.6;
        }

        /* Navbar Style (Deep Teal) */
        .navbar-pearltrails {
            background-color: var(--teal-deep) !important;
            padding: 0.9rem 2rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        .navbar-pearltrails .navbar-brand {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 1.5rem;
            color: #ffffff !important;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
        }
        .navbar-pearltrails .navbar-brand img {
            height: 42px;
            width: auto;
            object-fit: contain;
        }

        /* Page Headings */
        .page-heading {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 2rem;
            color: var(--ocean-blue);
        }

        /* Package Card Styling */
        .package-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.08);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .package-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.12);
        }

        /* Buttons (Gold Theme) */
        .btn-custom {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            border-radius: 999px;
            padding: 0.5rem 1.5rem;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 8px 18px -8px rgba(201, 151, 63, 0.6);
        }
        .btn-custom:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-pearltrails navbar-expand-lg sticky-top shadow-sm mb-4">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="/">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="PearlTrails Logo">
                <span>Pearl<span style="color: var(--gold);">Trails</span></span>
            </a>
            <div class="d-flex align-items-center">
                <a href="/" class="text-white text-decoration-none small fw-bold me-3">Home</a>
                <c:if test="${not empty sessionScope.loggedInUser}">
                    <a href="/logout" class="btn btn-outline-danger btn-sm px-3" style="width: auto !important;">Logout</a>
                </c:if>
                <c:if test="${empty sessionScope.loggedInUser}">
                    <a href="/login" class="text-white text-decoration-none small fw-bold me-3">Login</a>
                    <a href="/register" class="btn btn-custom btn-sm px-3 py-2" style="width: auto !important;">Sign Up</a>
                </c:if>
            </div>
        </div>
    </nav>

    <div class="container my-4 mb-5">
        <div class="mb-4">
            <span class="text-uppercase text-warning fw-bold small tracking-wide"><i class="fa-solid fa-compass me-1"></i> Explore Itineraries</span>
            <h2 class="page-heading mb-1">Curated Travel Packages</h2>
            <p class="text-muted mb-0">Discover expertly crafted travel plans and book your next vacation.</p>
        </div>

        <div class="row g-4">
            <c:forEach var="pkg" items="${packages}">
                <div class="col-md-4">
                    <div class="package-card p-4 h-100 d-flex flex-column">
                        <div class="d-flex align-items-center mb-3">
                            <div class="fs-3 me-3 text-warning">🎒</div>
                            <div>
                                <h4 class="fw-bold mb-0" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);">${pkg.packageName}</h4>
                                <small class="text-muted"><i class="fa-solid fa-user-tie me-1"></i> Created by Travel Agent</small>
                            </div>
                        </div>

                        <div class="mb-3 flex-grow-1">
                            <p class="text-muted small mb-1"><i class="fa-solid fa-route text-danger me-1"></i> <strong>Destination:</strong> ${pkg.destination}</p>
                            <p class="text-muted small mb-0"><i class="fa-regular fa-clock text-warning me-1"></i> <strong>Duration:</strong> ${pkg.durationDays} Days</p>
                        </div>

                        <div class="mt-auto pt-3 border-top d-flex justify-content-between align-items-center" style="border-color: var(--border-soft) !important;">
                            <div>
                                <small class="text-muted d-block" style="font-size: 0.75rem;">Package Price</small>
                                <span class="fw-bold fs-4" style="color: var(--ocean-blue);">$${pkg.totalPrice}</span>
                            </div>
                            <!-- Book Now Button linking to book-package page -->
                            <a href="/book-package?id=${pkg.packageId}" class="btn btn-custom shadow-sm">Book Now</a>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty packages}">
                <div class="col-12 text-center py-5">
                    <div class="card border-0 shadow-sm p-5 bg-white rounded-4" style="border: 1.5px solid var(--border-soft) !important;">
                        <h4 class="text-muted mb-2 font-monospace">No travel packages available yet.</h4>
                        <p class="text-muted small mb-0">Travel agents have not published any packages at the moment. Please check back later!</p>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>