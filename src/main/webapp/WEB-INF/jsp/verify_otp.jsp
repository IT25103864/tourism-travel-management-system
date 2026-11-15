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
    <title>Verify OTP - PearlTrails</title>
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

        /* Card Styling */
        .otp-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.08);
            overflow: hidden;
        }

        .form-control {
            border: 1.5px solid var(--border-soft);
            border-radius: 12px;
            padding: 0.85rem 1rem;
            font-size: 1.25rem;
            letter-spacing: 0.3em;
            text-align: center;
        }
        .form-control:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(201, 151, 63, 0.18);
        }

        /* Submit Button */
        .btn-custom-verify {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            font-size: 1.1rem;
            border-radius: 999px;
            padding: 0.9rem;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 10px 22px -10px rgba(201, 151, 63, 0.6);
        }
        .btn-custom-verify:hover {
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
            </div>
        </div>
    </nav>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="otp-card p-4 p-md-5 text-center">
                    <div class="mb-3">
                        <span class="fa-stack fa-2x" style="color: var(--gold);">
                            <i class="fa-solid fa-circle fa-stack-2x text-opacity-10" style="color: var(--gold);"></i>
                            <i class="fa-solid fa-shield-halved fa-stack-1x"></i>
                        </span>
                    </div>
                    <h3 class="fw-bold mb-2" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);">Security Verification</h3>
                    <p class="text-muted small mb-4">A simulated 4-digit OTP has been sent to your mobile number: <br><strong class="text-dark">${phone}</strong></p>

                    <!-- Error Alert if OTP is invalid -->
                    <c:if test="${param.error == 'invalid'}">
                        <div class="alert alert-danger py-2 small rounded-3 mb-4" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-1"></i> Invalid OTP! Please enter <strong>1234</strong>.
                        </div>
                    </c:if>

                    <!-- Form to confirm OTP -->
                    <form action="/confirm-payment-otp" method="post">
                        <div class="mb-4">
                            <label class="form-label fw-semibold small text-uppercase text-secondary mb-2">Enter 4-Digit OTP</label>
                            <input type="text" name="enteredOtp" class="form-control" placeholder="••••" required maxlength="4" autocomplete="off">
                            <div class="form-text mt-2 text-muted" style="font-size: 0.85rem;">For demo/presentation purposes, use code: <strong class="text-success">1234</strong></div>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-custom-verify shadow-sm"><i class="fa-solid fa-check-double me-2"></i> Verify &amp; Complete Payment</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>