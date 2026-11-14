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
    <title>Forgot Password - PearlTrails</title>
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

        html, body {
            height: 100%;
        }
        body {
            background-color: var(--bg);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
            font-size: 1.05rem;
            line-height: 1.6;
            display: flex;
            flex-direction: column;
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

        .auth-wrap {
            flex: 1;
            display: flex;
            align-items: center;
            padding: 2rem 0;
        }

        .page-eyebrow {
            font-size: 0.85rem;
            font-weight: 700;
            letter-spacing: 0.14em;
            text-transform: uppercase;
            color: var(--gold);
            margin-bottom: 0.35rem;
        }

        /* Auth Card */
        .auth-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.1);
        }
        .auth-card-header {
            background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep));
            padding: 2rem;
            position: relative;
        }
        .auth-card-header::after {
            content: "";
            position: absolute;
            left: 2rem;
            bottom: -1px;
            width: 42px;
            height: 3px;
            background: var(--gold);
            border-radius: 2px;
        }
        .auth-card-header h3 {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            color: #ffffff;
            margin: 0 0 0.4rem 0;
            font-size: 1.6rem;
        }
        .auth-card-header p {
            color: rgba(255,255,255,0.78);
            font-size: 0.95rem;
            margin: 0;
        }
        .auth-card-body {
            padding: 2.5rem;
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
        }
        .form-control:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(201, 151, 63, 0.18);
        }

        .alert-pearltrails-error {
            background: #fbeceb;
            border: 1px solid #f0c9c6;
            color: #a3382e;
            border-radius: 12px;
            padding: 0.85rem 1rem;
            font-size: 0.92rem;
        }
        .alert-pearltrails-success {
            background: #e6f6ec;
            border: 1px solid #bfe6cd;
            color: #1f7a45;
            border-radius: 12px;
            padding: 0.85rem 1rem;
            font-size: 0.92rem;
        }

        /* Buttons (Gold Theme) */
        .btn-pearltrails {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            font-size: 1.05rem;
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

        .back-link {
            color: var(--ocean-blue);
            font-weight: 600;
            font-size: 0.95rem;
            text-decoration: none;
        }
        .back-link:hover {
            color: var(--gold);
            text-decoration: underline;
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
                <a href="/login" class="text-white text-decoration-none small fw-bold me-3">Login</a>
                <a href="/register" class="text-white text-decoration-none small fw-bold">Sign Up</a>
            </div>
        </div>
    </nav>

    <div class="auth-wrap">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-7 col-lg-5">

                    <div class="page-eyebrow text-center">Account Security</div>

                    <div class="card auth-card">
                        <div class="auth-card-header">
                            <h3>Reset Password</h3>
                            <p>Enter your registered email and set a new password.</p>
                        </div>
                        <div class="auth-card-body">
                            <form action="/forgot-password" method="post">
                                <div class="mb-3">
                                    <label class="form-label">Email Address</label>
                                    <input type="email" name="email" class="form-control" placeholder="you@example.com" required>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label">New Password</label>
                                    <input type="password" name="newPassword" class="form-control" placeholder="••••••••" required>
                                </div>

                                <c:if test="${not empty error}">
                                    <div class="alert-pearltrails-error mb-3"><i class="fa-solid fa-circle-exclamation me-1"></i>${error}</div>
                                </c:if>
                                <c:if test="${not empty success}">
                                    <div class="alert-pearltrails-success mb-3"><i class="fa-solid fa-circle-check me-1"></i>${success}</div>
                                </c:if>

                                <button type="submit" class="btn-pearltrails w-100 mb-3 py-2">Reset Password</button>
                                <div class="text-center pt-2">
                                    <a href="/login" class="back-link">&larr; Back to Login</a>
                                </div>
                            </form>
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