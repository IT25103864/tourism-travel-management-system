<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // Prevent browser caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!-- Main Public Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-pearltrails-public mb-4 shadow-sm sticky-top">
    <div class="container-fluid px-4">
        <!-- Logo / Brand -->
        <a class="navbar-brand" href="/">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="PearlTrails Logo" style="height: 65px; width: auto; object-fit: contain;">
            <span>Pearl<span style="color: var(--gold, #c9973f);">Trails</span></span>
        </a>

        <!-- Mobile Toggle Button -->
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#publicNavbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse justify-content-end" id="publicNavbarNav">
            <ul class="navbar-nav align-items-center gap-2">
                <li class="nav-item">
                    <a class="nav-link" href="/">Home</a>
                </li>

                <!-- If User is Logged In -->
                <c:if test="${not empty sessionScope.loggedInUser}">
                    <li class="nav-item">
                        <a class="nav-link" href="/my-bookings">My Bookings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/my-packages">My Packages</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/my-listings">My Listings</a>
                    </li>
                    <li class="nav-item ms-lg-2">
                        <span class="text-white small fw-semibold px-2 py-1 bg-white bg-opacity-10 rounded-pill">
                            <i class="fa-solid fa-user me-1 text-warning"></i> ${sessionScope.loggedInUser.fullName}
                        </span>
                    </li>
                    <li class="nav-item ms-lg-2">
                        <a class="nav-link logout-link px-3" href="/logout">
                            <i class="fa-solid fa-right-from-bracket me-1"></i> Logout
                        </a>
                    </li>
                </c:if>

                <!-- If User is NOT Logged In -->
                <c:if test="${empty sessionScope.loggedInUser}">
                    <li class="nav-item ms-lg-2">
                        <a class="nav-link" href="/login">Login</a>
                    </li>
                    <li class="nav-item ms-lg-1">
                        <a href="/register" class="btn btn-signup-nav px-4 py-2">Sign Up</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<style>
    :root {
        --ocean-blue: #1b3a4b;
        --teal-deep: #163c37;
        --gold: #c9973f;
        --gold-light: #e0b866;
    }

    .navbar-pearltrails-public {
        background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep)) !important;
        padding: 0.9rem 1.5rem;
    }
    .navbar-pearltrails-public .navbar-brand {
        font-family: 'Fraunces', serif;
        font-weight: 700;
        font-size: 1.5rem;
        color: #ffffff !important;
        display: flex;
        align-items: center;
        gap: 0.75rem;
        text-decoration: none;
    }
    .navbar-pearltrails-public .nav-link {
        font-family: 'Inter', sans-serif;
        font-weight: 600;
        font-size: 1.02rem !important;
        color: rgba(255, 255, 255, 0.88) !important;
        padding: 0.6rem 1.1rem !important;
        border-radius: 12px;
        transition: all 0.2s ease;
    }
    .navbar-pearltrails-public .nav-link:hover {
        background: rgba(255, 255, 255, 0.12);
        color: var(--gold) !important;
    }
    .navbar-pearltrails-public .logout-link {
        color: #fca5a5 !important;
        font-weight: 700;
    }
    .navbar-pearltrails-public .logout-link:hover {
        background: rgba(239, 68, 68, 0.2);
        color: #ffffff !important;
    }
    .btn-signup-nav {
        background-color: var(--gold);
        border: none;
        color: #1f2d2c;
        font-weight: 700;
        border-radius: 999px;
        font-size: 0.98rem;
        transition: transform 0.15s ease, background 0.15s ease;
        box-shadow: 0 8px 18px -8px rgba(201, 151, 63, 0.6);
    }
    .btn-signup-nav:hover {
        background-color: var(--gold-light);
        transform: translateY(-1px);
        color: #1f2d2c;
    }
    .navbar-pearltrails-public .navbar-toggler {
        border-color: rgba(255, 255, 255, 0.4);
    }
</style>