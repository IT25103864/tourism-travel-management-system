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
    <title>Book Package - PearlTrails</title>
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
            --package-orange: #d97706;
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

        /* Page Heading */
        .page-eyebrow {
            font-size: 0.85rem;
            font-weight: 700;
            letter-spacing: 0.14em;
            text-transform: uppercase;
            color: var(--package-orange);
            margin-bottom: 0.35rem;
        }
        .page-subtext {
            color: var(--text-muted);
            font-size: 1.02rem;
        }

        /* Card Styling */
        .booking-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.1);
        }
        .booking-card-header {
            background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep));
            padding: 1.75rem 2rem 1.5rem;
            position: relative;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .booking-card-header::after {
            content: "";
            position: absolute;
            left: 2rem;
            bottom: -1px;
            width: 42px;
            height: 3px;
            background: var(--gold);
            border-radius: 2px;
        }
        .package-icon-badge {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: rgba(201, 151, 63, 0.2);
            border: 1.5px solid var(--gold);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 1.2rem;
            color: #ffffff;
        }
        .booking-card-header h4 {
            font-family: 'Fraunces', serif;
            font-weight: 600;
            color: #ffffff;
            margin: 0;
            font-size: 1.4rem;
        }
        .booking-card-header p {
            color: rgba(255,255,255,0.78);
            font-size: 0.9rem;
            margin: 0.2rem 0 0;
        }
        .booking-card-body {
            padding: 2.2rem;
        }

        /* Form Elements */
        .form-label {
            font-weight: 600;
            font-size: 0.92rem;
            color: var(--ocean-blue);
        }
        .form-control {
            border: 1.5px solid var(--border-soft);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 0.98rem;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }
        .form-control:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(201, 151, 63, 0.18);
        }

        /* Buttons (Gold Theme) */
        .btn-pearltrails {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            font-size: 1.02rem;
            border-radius: 999px;
            padding: 0.85rem 1.5rem;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 10px 22px -10px rgba(201, 151, 63, 0.6);
        }
        .btn-pearltrails:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
            box-shadow: 0 14px 26px -10px rgba(201, 151, 63, 0.7);
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-pearltrails navbar-expand-lg sticky-top shadow-sm">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="/">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="PearlTrails Logo">
                <span>Pearl<span style="color: var(--gold);">Trails</span></span>
            </a>
            <div class="d-flex align-items-center">
                <a href="/" class="text-white text-decoration-none small fw-bold me-3">Home</a>
                <a href="/packages-list" class="text-white text-decoration-none small fw-bold">All Packages</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">

                <div class="page-eyebrow">Travel Package Booking</div>
                <h2 class="fw-bold mb-1" style="font-family: 'Fraunces', serif; color: var(--ocean-blue); font-size: 2.2rem;">Book Travel Package</h2>
                <p class="page-subtext mb-4">Secure your itinerary and members count for <strong>${travelPackage.packageName}</strong>.</p>

                <div class="card booking-card">
                    <div class="booking-card-header">
                        <div class="package-icon-badge"><i class="fa-solid fa-route"></i></div>
                        <div>
                            <h4>${travelPackage.packageName}</h4>
                            <p>Review your package specifications.</p>
                        </div>
                    </div>
                    <div class="booking-card-body">
                        <div class="alert alert-success py-3 px-4 mb-4 rounded-3 d-flex justify-content-between align-items-center" style="background-color: rgba(47, 174, 102, 0.1); border: 1px solid rgba(47, 174, 102, 0.2); color: #163c37;">
                            <span>Base Package Price:</span>
                            <strong class="fs-5">$${travelPackage.totalPrice}</strong>
                        </div>

                        <form action="/confirm-package-booking" method="post">
                            <input type="hidden" name="packageId" value="${travelPackage.packageId}">

                            <div class="mb-3">
                                <label class="form-label">Number of Members</label>
                                <input type="number" name="membersCount" class="form-control" min="1" value="1" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Check-in Date</label>
                                <input type="date" name="checkInDate" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Check-out Date</label>
                                <input type="date" name="checkOutDate" class="form-control" required>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                                <a href="/packages-list" class="btn btn-outline-secondary rounded-pill px-4 py-2 fw-semibold">Cancel</a>
                                <button type="submit" class="btn btn-pearltrails shadow-sm py-2 px-4">Confirm Booking & Pay</button>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>