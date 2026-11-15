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
    <title>${travelPackage.packageName} - PearlTrails</title>
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

        /* Details Card Styling */
        .details-card {
            background: var(--card-bg);
            border-radius: 20px;
            border: 1.5px solid var(--border-soft);
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.1);
            overflow: hidden;
        }
        .package-img {
            width: 100%;
            height: 420px;
            object-fit: cover;
            border-bottom: 1.5px solid var(--border-soft);
        }

        /* Buttons (Gold Theme) */
        .btn-custom {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            font-size: 1.05rem;
            border-radius: 999px;
            padding: 0.85rem 2.2rem;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 10px 22px -10px rgba(201, 151, 63, 0.6);
        }
        .btn-custom:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
            box-shadow: 0 14px 26px -10px rgba(201, 151, 63, 0.7);
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
                    <a href="/my-packages" class="text-white text-decoration-none small fw-bold">My Packages</a>
                </c:if>
            </div>
        </div>
    </nav>

    <!-- Main Content Container -->
    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-9">
                <div class="details-card">
                    <!-- Package Image -->
                    <img src="${empty travelPackage.imageUrl ? 'https://images.unsplash.com/photo-1546708973-b339540b5162?fm=jpg&w=1200' : travelPackage.imageUrl}" alt="${travelPackage.packageName}" class="package-img">

                    <div class="p-4 p-md-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="badge bg-warning text-dark px-3 py-2 rounded-pill fw-bold"><i class="fa-regular fa-clock me-1"></i> ${travelPackage.durationDays} Days Tour</span>
                            <h3 class="fw-bold mb-0" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);">$${travelPackage.totalPrice}</h3>
                        </div>

                        <h1 class="fw-bold mb-3" style="font-family:'Fraunces', serif; color: var(--ocean-blue);">${travelPackage.packageName}</h1>
                        <p class="text-muted mb-4"><i class="fa-solid fa-route text-danger me-2"></i><strong>Destination / Stops:</strong> ${travelPackage.destination}</p>

                        <hr class="my-4" style="border-color: var(--border-soft);">

                        <h5 class="fw-bold mb-3" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);">Package Description &amp; Itinerary</h5>
                        <p class="text-secondary lh-lg mb-5" style="white-space: pre-line;">${travelPackage.description}</p>

                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-between align-items-center pt-3 border-top" style="border-color: var(--border-soft) !important;">
                            <a href="/" class="btn btn-outline-secondary px-4 rounded-pill fw-semibold py-2">&larr; Back to Home</a>
                            <a href="/book-package?id=${travelPackage.packageId}" class="btn btn-custom shadow-sm">Book This Package Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>