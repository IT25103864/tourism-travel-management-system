<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
    :root {
        --ocean-blue: #1b3a4b;
        --teal-deep: #163c37;
        --gold: #c9973f;
        --gold-light: #e0b866;
    }

    .navbar-pearltrails-admin {
        background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep)) !important;
        padding: 1rem 1.5rem;
        box-shadow: 0 10px 30px rgba(27, 58, 75, 0.15);
    }
    .navbar-pearltrails-admin .navbar-brand {
        font-family: 'Fraunces', serif;
        font-weight: 700;
        font-size: 1.4rem;
        color: var(--gold) !important;
        letter-spacing: 0.02em;
        display: flex;
        align-items: center;
        gap: 0.6rem;
        text-decoration: none;
    }
    .navbar-pearltrails-admin .navbar-brand .brand-dot {
        width: 10px;
        height: 10px;
        border-radius: 50%;
        background: var(--gold);
        display: inline-block;
    }
    .navbar-pearltrails-admin .navbar-brand .admin-tag {
        font-family: 'Inter', sans-serif;
        font-size: 0.7rem;
        font-weight: 700;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        color: #ffffff;
        background: rgba(201, 151, 63, 0.25);
        border: 1px solid rgba(201, 151, 63, 0.4);
        border-radius: 999px;
        padding: 0.2rem 0.6rem;
        margin-left: 0.4rem;
    }
    .navbar-pearltrails-admin .nav-link {
        font-family: 'Inter', sans-serif;
        font-weight: 600;
        font-size: 1.02rem !important;
        color: rgba(255, 255, 255, 0.85) !important;
        padding: 0.6rem 1.1rem !important;
        border-radius: 12px;
        transition: all 0.2s ease;
    }
    .navbar-pearltrails-admin .nav-link:hover {
        background: rgba(255, 255, 255, 0.12);
        color: var(--gold) !important;
    }
    .navbar-pearltrails-admin .nav-link.logout-link {
        color: #fca5a5 !important;
        font-weight: 700;
    }
    .navbar-pearltrails-admin .nav-link.logout-link:hover {
        background: rgba(239, 68, 68, 0.2);
        color: #ffffff !important;
    }
    .navbar-pearltrails-admin .navbar-toggler {
        border-color: rgba(255, 255, 255, 0.4);
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-pearltrails-admin mb-4 shadow-sm sticky-top">
    <div class="container-fluid px-4">
        <!-- System Name / Logo -->
        <a class="navbar-brand" href="/admin">
            <span class="brand-dot"></span> PearlTrails <span class="admin-tag">Admin</span>
        </a>

        <!-- Mobile Toggle Button -->
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav align-items-center gap-1">
                <li class="nav-item">
                    <a class="nav-link" href="/admin">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/users">Manage Users</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/listings">Pending Listings</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/reviews">Pending Reviews</a>
                </li>
                <li class="nav-item ms-lg-3">
                    <a class="nav-link logout-link" href="/logout"><i class="fa-solid fa-right-from-bracket me-1"></i> Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>