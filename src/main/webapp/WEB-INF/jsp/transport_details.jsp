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
    <title>${transport.vehicleModel} - PearlTrails</title>
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
            --transport-green: #2fae66;
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

        /* Details Container Card */
        .details-container {
            max-width: 900px;
            margin: 2rem auto 4rem auto;
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.08);
        }
        .listing-img {
            width: 100%;
            height: 420px;
            object-fit: cover;
            border-radius: 16px;
            margin-bottom: 1.5rem;
            border: 1.5px solid var(--border-soft);
        }
        .title-heading {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 2.2rem;
            color: var(--ocean-blue);
        }

        /* Buttons (Gold Theme) */
        .btn-custom-rent {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            font-size: 1.05rem;
            border-radius: 999px;
            padding: 0.75rem 2rem;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 8px 18px -8px rgba(201, 151, 63, 0.6);
        }
        .btn-custom-rent:hover {
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
                    <a href="/my-transport-bookings" class="text-white text-decoration-none small fw-bold">My Transport Bookings</a>
                </c:if>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="my-3 text-start">
            <a href="/" class="btn btn-outline-secondary btn-sm rounded-pill px-4 fw-semibold"><i class="fa-solid fa-arrow-left me-1"></i> Back to Home</a>
        </div>

        <div class="details-container">
            <img src="${empty transport.imageUrl ? 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=800' : transport.imageUrl}" alt="${transport.vehicleModel}" class="listing-img">

            <span class="badge bg-warning text-dark mb-3 px-3 py-2 rounded-pill fw-bold"><i class="fa-solid fa-car me-1"></i> ${transport.vehicleType}</span>
            <h1 class="title-heading mb-2">${transport.vehicleModel}</h1>
            <p class="text-muted mb-3"><i class="fa-solid fa-users text-secondary me-1"></i> Seating Capacity: <b>${transport.seatingCapacity} Passengers</b></p>

            <h4 class="fw-bold mb-4" style="color: var(--transport-green);">$${transport.price} <small class="text-muted fs-6 fw-normal">/ day</small></h4>

            <hr class="my-4" style="border-color: var(--border-soft);">

            <h5 class="fw-bold mb-2" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);">Vehicle Specifications &amp; Details</h5>
            <p class="text-secondary lh-lg mb-0">${empty transport.description ? 'Experience a comfortable and safe journey across Sri Lanka with our well-maintained vehicle. Ideal for city tours, long-distance trips, and family outings.' : transport.description}</p>

            <div class="mt-4 pt-4 border-top d-flex justify-content-between align-items-center" style="border-color: var(--border-soft) !important;">
                <span class="text-muted small">Status: <b class="text-success"><i class="fa-solid fa-circle-check me-1"></i> Available for Rent</b></span>
                <a href="/book-transport?id=${transport.id}" class="btn btn-custom-rent shadow-sm">Rent This Vehicle</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>