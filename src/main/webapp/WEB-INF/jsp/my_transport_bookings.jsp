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
    <title>My Transport Bookings - PearlTrails</title>
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

        /* Page Headings */
        .page-heading {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 2rem;
            color: var(--ocean-blue);
        }

        /* Transport Booking Card */
        .booking-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.08);
            border-left: 5px solid var(--transport-green);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .booking-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.12);
        }

        /* Buttons (Gold & Custom Theme) */
        .btn-custom-browse {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            border-radius: 999px;
            padding: 0.5rem 1.25rem;
            transition: transform 0.15s ease, background 0.15s ease;
            box-shadow: 0 8px 18px -8px rgba(201, 151, 63, 0.6);
        }
        .btn-custom-browse:hover {
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
                <a href="/transports" class="btn btn-custom-browse fw-bold me-2"><i class="fa-solid fa-car me-1"></i> Browse Transports</a>
                <a href="/" class="text-white text-decoration-none small fw-bold me-3">Home</a>
                <a href="/logout" class="btn btn-outline-danger btn-sm px-3" style="width: auto !important;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4 mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="page-heading mb-1">My Transport Bookings</h2>
                <p class="text-muted mb-0">View and track your reserved vehicle trips and transportation schedules.</p>
            </div>
        </div>

        <div class="row">
            <c:forEach var="booking" items="${bookings}">
                <div class="col-md-4 mb-4">
                    <div class="card booking-card h-100 d-flex flex-column p-3">
                        <div class="card-body d-flex flex-column flex-grow-1">
                            <h5 class="card-title fw-bold mb-2" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);"><i class="fa-solid fa-taxi me-2 text-warning"></i>${booking.transport.vehicleType}</h5>
                            <h6 class="card-subtitle mb-3 text-muted small"><i class="fa-solid fa-route text-success me-1"></i> Route: ${booking.transport.route}</h6>
                            <p class="card-text mb-1 small text-secondary"><strong>Travel Date:</strong> ${booking.travelDate}</p>
                            <p class="card-text mb-3 small text-secondary"><strong>Status:</strong> <span class="badge bg-success px-3 py-1.5 rounded-pill fw-bold"><i class="fa-solid fa-circle-check me-1"></i> ${booking.status}</span></p>

                            <div class="mt-auto pt-3 border-top d-flex justify-content-between align-items-center">
                                <span class="text-muted small">Total Amount:</span>
                                <h4 class="fw-bold mb-0" style="color: var(--transport-green);">$${booking.totalAmount}</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty bookings}">
                <div class="col-12 text-center py-5">
                    <div class="card border-0 shadow-sm p-5 bg-white rounded-4" style="border: 1.5px solid var(--border-soft) !important;">
                        <h4 class="text-muted mb-3 font-monospace">You haven't booked any transport services yet.</h4>
                        <div>
                            <a href="/transports" class="btn btn-custom-browse px-4 py-2 fw-bold">Explore Available Transports</a>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>