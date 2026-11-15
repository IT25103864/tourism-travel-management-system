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
    <title>Payment Successful - PearlTrails</title>
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
            --success-green: #2fae66;
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

        /* Card Styling */
        .success-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.08);
            overflow: hidden;
        }

        /* Buttons (Gold & Outline Themes) */
        .btn-custom-download {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            font-size: 1.05rem;
            border-radius: 999px;
            padding: 0.85rem;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 10px 22px -10px rgba(201, 151, 63, 0.6);
        }
        .btn-custom-download:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
            box-shadow: 0 14px 26px -10px rgba(201, 151, 63, 0.7);
        }
        .btn-outline-home {
            border: 1.5px solid var(--ocean-blue);
            color: var(--ocean-blue);
            background: transparent;
            font-weight: 600;
            border-radius: 999px;
            padding: 0.75rem;
            transition: all 0.15s ease;
        }
        .btn-outline-home:hover {
            background: var(--ocean-blue);
            color: #ffffff;
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
                    <a href="/my-bookings" class="text-white text-decoration-none small fw-bold">My Bookings</a>
                </c:if>
            </div>
        </div>
    </nav>

    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-7 col-lg-6">
                <div class="success-card p-4 p-md-5 text-center">
                    <div class="card-body p-0">
                        <div class="mb-4">
                            <span class="fa-stack fa-2x" style="color: var(--success-green);">
                                <i class="fa-solid fa-circle fa-stack-2x text-opacity-10" style="color: var(--success-green);"></i>
                                <i class="fa-solid fa-circle-check fa-stack-1x"></i>
                            </span>
                        </div>
                        <h2 class="fw-bold mb-2" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);">Payment Successful!</h2>
                        <p class="text-muted mb-4">Thank you for your payment. Your booking/package has been confirmed successfully.</p>

                        <div class="p-4 rounded-4 text-start mb-4" style="border: 1.5px solid var(--border-soft); background: var(--bg);">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted small">Payment ID:</span>
                                <span class="fw-bold font-monospace" style="color: var(--ocean-blue);">#PT-${payment.paymentId}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted small">Total Paid:</span>
                                <span class="fw-bold text-success fs-5">$${payment.finalAmount}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted small">Promo Applied:</span>
                                <span class="fw-semibold">${empty payment.promoCodeUsed ? 'None' : payment.promoCodeUsed}</span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center pt-2 border-top" style="border-color: var(--border-soft) !important;">
                                <span class="text-muted small">Status:</span>
                                <span class="badge bg-success px-3 py-1.5 rounded-pill fw-bold"><i class="fa-solid fa-circle-check me-1"></i> ${payment.paymentStatus}</span>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-grid gap-3">
                            <a href="/download-invoice?paymentId=${payment.paymentId}" class="btn btn-custom-download shadow-sm"><i class="fa-solid fa-file-arrow-down me-2"></i> Download Invoice (PDF)</a>
                            <a href="/" class="btn btn-outline-home fw-semibold">Back to Home</a>
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