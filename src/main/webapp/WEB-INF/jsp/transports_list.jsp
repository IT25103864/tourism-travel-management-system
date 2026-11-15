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
    <title>Available Transports - PearlTrails</title>
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

        /* Transport Card Styling */
        .transport-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.08);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .transport-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.12);
        }

        /* Search Form */
        .search-container {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 999px;
            padding: 0.4rem;
            box-shadow: 0 10px 25px rgba(27, 58, 75, 0.05);
        }
        .search-input {
            border: none;
            background: transparent;
            padding-left: 1rem;
            font-size: 1rem;
        }
        .search-input:focus {
            box-shadow: none;
            background: transparent;
        }

        /* Buttons (Gold Theme) */
        .btn-custom-search {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            border-radius: 999px;
            padding: 0.6rem 1.75rem;
            transition: transform 0.15s ease, background 0.15s ease;
        }
        .btn-custom-search:hover {
            background: var(--gold-light);
            color: #1f2d2c;
        }
        .btn-custom-book {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            border-radius: 999px;
            padding: 0.6rem;
            width: 100%;
            transition: transform 0.15s ease, background 0.15s ease;
            box-shadow: 0 8px 18px -8px rgba(201, 151, 63, 0.6);
        }
        .btn-custom-book:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
        }
        .btn-outline-custom {
            border: 1.5px solid var(--ocean-blue);
            color: var(--ocean-blue);
            background: transparent;
            font-weight: 600;
            border-radius: 999px;
            padding: 0.5rem 1.25rem;
            transition: all 0.15s ease;
        }
        .btn-outline-custom:hover {
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
                <a href="/my-transport-bookings" class="btn btn-outline-light btn-sm fw-semibold me-2 px-3">My Transport Bookings</a>
                <a href="/" class="text-white text-decoration-none small fw-bold me-3">Home</a>
                <a href="/logout" class="btn btn-outline-danger btn-sm px-3" style="width: auto !important;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4 mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="page-heading mb-1">Available Transport Services</h2>
                <p class="text-muted mb-0">Browse and book verified vehicles for your travel routes across Sri Lanka.</p>
            </div>
        </div>

        <!-- Search Transport Form -->
        <div class="row justify-content-center mb-5">
            <div class="col-md-8 col-lg-6">
                <form action="/transports" method="get" class="search-container d-flex align-items-center">
                    <input type="text" name="route" class="form-control search-input"
                           placeholder="Search by route (e.g., Colombo to Kandy)..."
                           value="${route}">
                    <button type="submit" class="btn btn-custom-search me-1">Search</button>
                    <a href="/transports" class="btn btn-outline-secondary rounded-pill px-3 py-2 text-decoration-none small fw-semibold">Clear</a>
                </form>
            </div>
        </div>

        <div class="row g-4">
            <c:forEach var="transport" items="${transports}">
                <div class="col-md-4">
                    <div class="card transport-card h-100 d-flex flex-column p-3">
                        <div class="card-body d-flex flex-column flex-grow-1 p-2">
                            <h5 class="card-title fw-bold mb-2" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);"><i class="fa-solid fa-car me-2 text-warning"></i>${transport.vehicleType}</h5>
                            <h6 class="card-subtitle mb-3 text-muted small"><i class="fa-solid fa-route text-success me-1"></i> Route: ${transport.route}</h6>
                            <p class="card-text small text-secondary flex-grow-1 mb-3">${transport.description}</p>

                            <div class="d-flex justify-content-between align-items-center pt-2 mb-3 border-top" style="border-color: var(--border-soft) !important;">
                                <span class="text-muted small">Daily Rate:</span>
                                <h4 class="fw-bold mb-0" style="color: var(--transport-green);">$${transport.price}</h4>
                            </div>
                        </div>

                        <div class="card-footer bg-white border-0 p-2 pt-0">
                            <!-- Booking Form with Date Picker -->
                            <form action="/book-transport" method="post">
                                <input type="hidden" name="transportId" value="${transport.transportId}">
                                <div class="mb-3">
                                    <label class="form-label small fw-semibold text-secondary mb-1">Select Travel Date:</label>
                                    <input type="date" name="travelDate" class="form-control form-control-sm rounded-3 py-2" required>
                                </div>
                                <button type="submit" class="btn btn-custom-book shadow-sm">Book Transport</button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty transports}">
                <div class="col-12 text-center py-5">
                    <div class="card border-0 shadow-sm p-5 bg-white rounded-4" style="border: 1.5px solid var(--border-soft) !important;">
                        <h4 class="text-muted mb-2 font-monospace">No transport services available matching your search.</h4>
                        <p class="text-muted small mb-0">Try searching for a different route or clearing your search filters.</p>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>