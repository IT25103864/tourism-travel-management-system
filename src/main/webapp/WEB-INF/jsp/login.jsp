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
    <title>Login - PearlTrails</title>
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
            color: var(--text-dark);
            font-family: 'Inter', sans-serif;
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
            height: 65px; /* Navbar logo size updated */
            width: auto;
            object-fit: contain;
        }

        .auth-wrap {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2.5rem 0;
        }

        .card-custom {
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.1);
            overflow: hidden;
            background: var(--card-bg);
        }
        .card-header-custom {
            background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep));
            color: #ffffff;
            text-align: center; /* Centered Header */
            padding: 2.2rem 2rem;
            position: relative;
        }
        .card-header-custom::after {
            content: "";
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            bottom: 0;
            width: 60px;
            height: 3px;
            background: var(--gold);
            border-radius: 2px;
        }
        .card-header-custom .login-logo {
            height: 65px; /* Login Card logo size increased to 65px */
            width: auto;
            object-fit: contain;
            margin-bottom: 0.75rem;
        }
        .card-header-custom h3 {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 1.75rem;
            margin-bottom: 0.4rem;
        }
        .card-header-custom p {
            color: rgba(255, 255, 255, 0.78);
            font-size: 0.95rem;
            margin: 0;
        }

        /* Form Elements */
        .form-label {
            font-weight: 600;
            font-size: 0.92rem;
            color: var(--ocean-blue);
        }
        .form-control {
            border-radius: 12px;
            padding: 0.75rem 1rem;
            border: 1.5px solid var(--border-soft);
            font-size: 0.98rem;
        }
        .form-control:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(201, 151, 63, 0.18);
        }

        /* Button (Gold Theme) */
        .btn-custom-main {
            background-color: var(--gold);
            border: none;
            color: #1f2d2c;
            border-radius: 999px;
            padding: 0.85rem;
            font-weight: 700;
            font-size: 1.05rem;
            width: 100%;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 10px 22px -10px rgba(201, 151, 63, 0.6);
        }
        .btn-custom-main:hover {
            background-color: var(--gold-light);
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
                <a href="/register" class="text-white text-decoration-none small fw-bold">Sign Up</a>
            </div>
        </div>
    </nav>

    <div class="auth-wrap">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-7 col-lg-5">
                    <div class="card card-custom">
                        <div class="card-header-custom">
                            <!-- Logo Image Added Inside Card Header -->
                            <img src="${pageContext.request.contextPath}/images/logo.png" alt="PearlTrails Logo" class="login-logo">
                            <h3 class="mb-0">Welcome Back</h3>
                            <p>Sign in to continue exploring PearlTrails</p>
                        </div>
                        <div class="card-body p-4 p-md-5">

                            <!-- Display Error Message if Login Fails -->
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger py-2 px-3 rounded-3 small mb-4" role="alert">
                                    <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                                </div>
                            </c:if>

                            <!-- Show success message if coming from logout -->
                            <c:if test="${param.logout != null}">
                                <div class="alert alert-success py-2 px-3 rounded-3 small mb-4" role="alert">
                                    <i class="fa-solid fa-circle-check me-1"></i> You have successfully logged out.
                                </div>
                            </c:if>

                            <!-- Show success message if coming from registration -->
                            <c:if test="${param.registered != null}">
                                <div class="alert alert-success py-2 px-3 rounded-3 small mb-4" role="alert">
                                    <i class="fa-solid fa-circle-check me-1"></i> Registration successful! Please login to continue.
                                </div>
                            </c:if>

                            <!-- Login Form -->
                            <form action="/login" method="post">
                                <div class="mb-3">
                                    <label class="form-label">Email Address</label>
                                    <input type="email" name="email" class="form-control" required placeholder="you@example.com">
                                </div>

                                <div class="mb-3">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <label class="form-label mb-0">Password</label>
                                        <a href="/forgot-password" class="text-decoration-none small fw-bold" style="color: var(--ocean-blue);">Forgot Password?</a>
                                    </div>
                                    <input type="password" name="password" class="form-control mt-1" required placeholder="••••••••">
                                </div>

                                <button type="submit" class="btn btn-custom-main mt-3 py-2.5">Login</button>
                            </form>
                        </div>
                        <div class="card-footer text-center bg-white border-top-0 pb-4 pt-0">
                            <small class="text-muted">Don't have an account? <a href="/register" class="fw-bold text-decoration-none" style="color: var(--gold);">Sign Up here</a></small>
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