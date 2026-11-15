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
    <title>Register - PearlTrails</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --ocean-blue: #1b3a4b;
            --teal-deep: #163c37;
            --gold: #c9973f;
            --gold-light: #e0b866;
            --bg: #f8faf9;
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

        .register-card {
            border: 1.5px solid var(--border-soft);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 20px 40px -15px rgba(27, 58, 75, 0.12);
            background: #ffffff;
        }

        .register-header {
            background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep));
            padding: 2.2rem 2rem;
            text-align: center;
            color: #ffffff;
            position: relative;
        }

        .register-header::after {
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

        .register-logo {
            height: 65px; /* Register Card logo size increased to 65px */
            width: auto;
            object-fit: contain;
            margin-bottom: 0.75rem;
        }

        .register-header h4 {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 1.75rem;
            margin: 0;
            color: #ffffff;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.92rem;
            color: var(--ocean-blue);
        }

        .form-control, .form-select {
            border: 1.5px solid var(--border-soft);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 0.98rem;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(201, 151, 63, 0.18);
        }

        .btn-pearltrails {
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

        .btn-pearltrails:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
            box-shadow: 0 14px 26px -10px rgba(201, 151, 63, 0.7);
        }

        .brand-link {
            color: var(--ocean-blue);
            text-decoration: none;
            font-weight: 600;
        }
        .brand-link:hover {
            color: var(--gold);
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">

                <div class="card register-card">
                    <div class="register-header">
                        <!-- Logo Image Added Here -->
                        <img src="${pageContext.request.contextPath}/images/logo.png" alt="PearlTrails Logo" class="register-logo">
                        <h4>Create an Account</h4>
                        <p class="text-white-50 small mb-0 mt-1">Join our exclusive travel community today</p>
                    </div>
                    <div class="card-body p-4 p-md-5">

                        <!-- Display Error Message if validation fails -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger rounded-4 py-2 px-3 small mb-4" role="alert">
                                <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                            </div>
                        </c:if>

                        <form action="/register" method="post">
                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" name="fullName" class="form-control" required placeholder="John Doe">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email Address</label>
                                <input type="email" name="email" class="form-control" required placeholder="john@example.com">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Phone Number</label>
                                <input type="text" name="phone" class="form-control" required placeholder="+94 77 123 4567">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="password" class="form-control" required placeholder="Create a strong password">
                            </div>

                            <!-- Direct Role Selection for Providers and Tourists -->
                            <div class="mb-4">
                                <label class="form-label">I am a...</label>
                                <select name="role" class="form-select" required>
                                    <option value="">-- Select your role --</option>
                                    <option value="Tourist">Tourist</option>
                                    <option value="Hotel Provider">Hotel / Villa Provider</option>
                                    <option value="Transport Provider">Transport Provider</option>
                                    <option value="Travel Agent">Travel Agent</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-pearltrails w-100 shadow-sm">Sign Up</button>
                        </form>
                    </div>
                    <div class="card-footer text-center bg-white border-top-0 pb-4 pt-0">
                        <small class="text-muted">Already have an account? <a href="/login" class="brand-link">Login here</a></small>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>