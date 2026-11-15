<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PearlTrails - Explore Sri Lanka</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600;9..144,700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --ocean-blue: #1b3a4b !important;
            --teal-deep: #163c37 !important; /* Deep Teal Color */
            --gold: #c9973f !important;
            --gold-light: #e0b866 !important;
            --page-bg: #f8faf9 !important;
            --card-white: #ffffff !important;
            --text-dark: #1f2d2c !important;
            --border-soft: #e3e9e8 !important;
        }

        /* 1. Global Typography & Colors */
        body {
            background-color: var(--page-bg);
            color: var(--text-dark);
            font-family: 'Inter', sans-serif;
            font-size: 1.05rem;
            line-height: 1.6;
            scroll-behavior: smooth;
        }

        small, .small, .text-muted { font-size: 0.96rem !important; }
        p, span, li { font-size: 1.02rem !important; }

        /* 2. Navbar Style (Deep Teal Background) */
        .navbar {
            background-color: var(--teal-deep) !important;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 0.9rem 2rem;
        }
        .navbar-brand { font-family: 'Fraunces', serif; font-weight: 700; font-size: 1.5rem; color: #ffffff !important; display: flex; align-items: center; gap: 0.75rem; text-decoration: none; }

        /* ලාංඡනය වටා ඇති සුදු පෙට්ටිය සම්පූර්ණයෙන්ම ඉවත් කර Transparent ලෙස Deep Teal මත පෙන්වීම */
        .navbar-brand img {
            height: 48px;
            width: auto;
            object-fit: contain;
            background: transparent !important;
            box-shadow: none !important;
            border: none !important;
        }

        .nav-link { color: rgba(255, 255, 255, 0.9) !important; font-weight: 600; font-size: 1.02rem !important; padding: 0 1rem !important; }
        .nav-link:hover { color: var(--gold) !important; }

        .hero-banner-container { padding: 2rem 2.5rem 0 2.5rem; }
        .hero-banner {
            position: relative; height: 480px; border-radius: 28px; overflow: hidden;
            background-size: cover; background-position: center; display: flex;
            flex-direction: column; justify-content: center; padding: 3.5rem;
            box-shadow: 0 20px 40px rgba(27, 58, 75, 0.15);
        }
        .hero-banner::before { content: ""; position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: linear-gradient(180deg, rgba(0,0,0,0.2) 20%, rgba(7, 19, 24, 0.8) 100%); }
        .hero-banner-content { position: relative; z-index: 2; color: #fff; max-width: 800px; }
        .hero-big-title { font-family: 'Fraunces', serif; font-size: 3.8rem; font-weight: 700; line-height: 1.15; margin-bottom: 0.8rem; color: #ffffff; }
        .hero-desc { font-size: 1.2rem !important; color: #f7fafc; margin-bottom: 1.5rem; }

        .floating-search-card {
            position: relative; z-index: 10; background: var(--card-white); border-radius: 22px;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.12); border: 1px solid var(--border-soft);
            margin: -55px 4.5rem 2rem 4.5rem; padding: 1.5rem 2rem;
        }

        /* 3. Main CTA Buttons (Gold) */
        .btn-custom-main { background-color: var(--gold) !important; border: none !important; color: #1f2d2c !important; border-radius: 999px; padding: 11px 30px; font-weight: 700; font-size: 1.02rem !important; text-decoration: none; display: inline-block; }
        .btn-custom-main:hover { background-color: var(--gold-light) !important; color: #1f2d2c !important; }

        /* Headings & Titles (Ocean Blue) */
        .section-heading, h2, h3, h5, .text-navy { color: var(--ocean-blue) !important; }

        /* Horizontal Scroll Styles with Arrow Controls */
        .section-header-action { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.2rem; }
        .scroll-buttons-group { display: flex; gap: 0.5rem; }
        .scroll-btn {
            background-color: var(--ocean-blue); color: #fff; border: none; border-radius: 50%;
            width: 38px; height: 38px; display: flex; align-items: center; justify-content: center;
            cursor: pointer; transition: background 0.2s, transform 0.1s;
        }
        .scroll-btn:hover { background-color: var(--gold); color: #1f2d2c; }
        .horizontal-scroll-container { display: flex; flex-wrap: nowrap; overflow-x: auto; scroll-behavior: smooth; gap: 1.5rem; padding-bottom: 1rem; scrollbar-width: none; }
        .horizontal-scroll-container::-webkit-scrollbar { display: none; }
        .horizontal-scroll-item { flex: 0 0 290px; min-width: 290px; max-width: 290px; }

        .section-container { padding: 2.5rem 2.5rem; }
        .section-heading { font-family: 'Fraunces', serif; font-weight: 700; font-size: 2.2rem; }

        /* 4. Cards (White) */
        .booking-card { border-radius: 18px; overflow: hidden; background-color: var(--card-white); border: 1.5px solid var(--border-soft); box-shadow: 0 8px 20px rgba(27, 58, 75, 0.05); height: 100%; display: flex; flex-direction: column; }
        .booking-card img { height: 170px; object-fit: cover; width: 100%; }
        .booking-card-body { padding: 1.3rem; display: flex; flex-direction: column; flex-grow: 1; }
        .booking-card-body h5 { font-size: 1.2rem !important; }
        .booking-card-body p, .booking-card-body small { font-size: 0.98rem !important; }

        .category-badge { font-size: 0.85rem !important; font-weight: 700; padding: 5px 12px; border-radius: 8px; background: rgba(201, 151, 63, 0.15); color: #8f6723; margin-bottom: 0.6rem; display: inline-block; }
        .promo-card { background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep)); color: #fff; border-radius: 16px; padding: 1.5rem; height: 100%; box-shadow: 0 8px 20px rgba(27, 58, 75, 0.1); }
        .contact-box { background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep)); border-radius: 24px; padding: 4rem; color: #ffffff; margin: 0 2.5rem 3rem 2.5rem; }
        footer.site-footer { background: #11222b; color: rgba(255,255,255,0.8); padding: 3.5rem 2.5rem 1.5rem 2.5rem; border-top: 1px solid rgba(255,255,255,0.1); font-size: 1.02rem; }

        /* Interactive Star Rating Styles */
        .star-rating-group { display: flex; flex-direction: row-reverse; justify-content: flex-end; gap: 0.3rem; }
        .star-rating-group input { display: none; }
        .star-rating-group label { font-size: 1.8rem; color: #cbd5e1; cursor: pointer; transition: color 0.2s ease; }
        .star-rating-group input:checked ~ label,
        .star-rating-group label:hover,
        .star-rating-group label:hover ~ label { color: var(--gold); }

        /* Auto Scroll Animation for Reviews */
        .auto-scroll-wrapper { width: 100%; position: relative; overflow: hidden; }
        .auto-scroll-track { display: flex; gap: 1.5rem; width: max-content; animation: smoothAutoScroll 35s linear infinite; }
        .auto-scroll-track:hover { animation-play-state: paused; }
        @keyframes smoothAutoScroll {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }
    </style>
</head>
<body>

    <!-- NAVBAR SECTION (Deep Teal Background Applied) -->
    <nav class="navbar navbar-expand-lg sticky-top shadow-sm">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="/">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="PearlTrails Logo">
                <span>Pearl<span style="color: var(--gold);">Trails</span></span>
            </a>
            <button class="navbar-toggler border-0 text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="#destinations">Destinations</a></li>
                    <li class="nav-item"><a class="nav-link" href="#stays-section">Stays</a></li>
                    <li class="nav-item"><a class="nav-link" href="#transports-section">Transports</a></li>
                    <li class="nav-item"><a class="nav-link" href="#packages-section">Packages</a></li>
                    <li class="nav-item"><a class="nav-link" href="#promos-section">Promos</a></li>
                    <li class="nav-item"><a class="nav-link" href="#reviews">Reviews</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                </ul>
            </div>

            <div class="d-flex align-items-center">
                <c:if test="${empty sessionScope.loggedInUser}">
                    <a href="/login" class="text-white text-decoration-none me-3 fw-semibold">Login</a>
                    <a href="/register" class="btn btn-custom-main btn-sm px-4">Sign Up</a>
                </c:if>

                <c:if test="${not empty sessionScope.loggedInUser}">
                    <c:if test="${sessionScope.loggedInUser.role == 'Admin' || sessionScope.loggedInUser.role == 'ADMIN'}">
                        <a href="/admin" class="btn btn-sm btn-warning me-3 fw-bold">Admin Dashboard</a>
                    </c:if>
                    <c:if test="${sessionScope.loggedInUser.role == 'Travel Agent' || sessionScope.loggedInUser.role == 'travel_agent'}">
                         <a href="/add-listing" class="btn btn-sm btn-outline-warning me-2 fw-bold">Add Place</a>
                         <a href="/my-listings" class="btn btn-sm btn-outline-info me-2 fw-bold">My Places</a>
                         <a href="/create-package" class="btn btn-sm btn-outline-success me-2 fw-bold">Create Package</a>
                         <a href="/my-packages" class="btn btn-sm btn-outline-secondary me-3 fw-bold">Manage Packages</a>
                    </c:if>
                    <c:if test="${sessionScope.loggedInUser.role == 'Hotel / Villa Provider'}">
                         <a href="/add-listing" class="btn btn-sm btn-outline-warning me-2 fw-bold">Add Place</a>
                         <a href="/my-listings" class="btn btn-sm btn-outline-info me-3 fw-bold">My Places</a>
                    </c:if>
                    <c:if test="${sessionScope.loggedInUser.role == 'Transport Provider'}">
                         <a href="/my-transports" class="btn btn-sm btn-outline-success me-2 fw-bold">My Vehicles</a>
                         <a href="/add-transport" class="btn btn-sm btn-warning me-3 fw-bold text-dark">Add Vehicle</a>
                    </c:if>
                    <c:if test="${sessionScope.loggedInUser.role == 'Tourist' || sessionScope.loggedInUser.role == 'tourist'}">
                         <a href="/my-bookings" class="btn btn-sm btn-outline-success me-3 fw-bold">My Bookings</a>
                    </c:if>
                    <span class="text-white me-3 fw-semibold">👤 ${sessionScope.loggedInUser.fullName}</span>
                    <a href="/logout" class="btn btn-outline-danger btn-sm">Logout</a>
                </c:if>
            </div>
        </div>
    </nav>

    <!-- HERO BANNER SECTION -->
    <div class="hero-banner-container">
        <div class="hero-banner" style="background-image: url('https://images.unsplash.com/photo-1566296314736-6eaac1ca0cb9?fm=jpg&q=70&w=1920&auto=format&fit=crop');">
            <div class="hero-banner-content">
                <span class="badge bg-warning text-dark px-3 py-2 rounded-pill fw-bold mb-3">EXPLORE SRI LANKA</span>
                <h1 class="hero-big-title">Travel Beyond Your Imagination</h1>
                <p class="hero-desc">Discover luxury hotels, secluded villas, and flexible vehicle rentals across Sri Lanka.</p>
                <div>
                    <a href="#destinations" class="btn-custom-main me-3">Explore Destinations</a>
                    <a href="#transports-section" class="btn btn-outline-light rounded-pill px-4 py-2 fw-bold">Rent a Vehicle</a>
                </div>
            </div>
        </div>
    </div>

    <!-- FLOATING SEARCH BAR -->
    <div class="floating-search-card">
        <form action="/" method="GET" class="row g-2 align-items-center">
            <div class="col-lg-9">
                <div class="p-2 border rounded-3 bg-light">
                    <small class="text-muted d-block fw-bold"><i class="fa-solid fa-location-dot text-danger me-1"></i> Search Destination or Hotel</small>
                    <input type="text" name="keyword" value="${keyword}" class="form-control border-0 bg-transparent p-0 fw-semibold" placeholder="Where are you going? (e.g. Kandy, Galle)">
                </div>
            </div>
            <div class="col-lg-3 d-grid">
                <button type="submit" class="btn btn-custom-main py-3 fw-bold shadow-sm">Search Stays</button>
            </div>
        </form>
    </div>

    <!-- ABOUT US SECTION -->
    <div class="section-container bg-white my-3 rounded-4 shadow-sm mx-4 p-5" id="about">
        <div class="row align-items-center">
            <div class="col-lg-6 mb-4 mb-lg-0">
                <span class="text-uppercase text-warning fw-bold small">About PearlTrails</span>
                <h2 class="section-heading mb-3">Your Ultimate Gateway to Exploring Sri Lanka</h2>
                <p class="text-secondary lh-lg">PearlTrails is a premier tourism platform dedicated to bringing you the finest experiences across Sri Lanka. From luxury hotels and secluded villas to custom travel packages and islandwide vehicle rentals, we make your dream vacation seamless and unforgettable.</p>
            </div>
            <div class="col-lg-6">
                <div id="aboutCarousel" class="carousel slide shadow-sm rounded-4 overflow-hidden" data-bs-ride="carousel" data-bs-interval="3000">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="https://srilankatravelandtourism.com/wp-content/uploads/2024/07/srilanka-travel-and-tourism.jpg" class="d-block w-100 rounded-4" style="height: 380px; object-fit: cover;" alt="Landscape">
                        </div>
                        <div class="carousel-item">
                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTBheVy0AbyvGDuv1Wm51X0oJrmwlt40WexziugDXi9A&s=10" class="d-block w-100 rounded-4" style="height: 380px; object-fit: cover;" alt="Train">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 1. TOP DESTINATIONS SECTION -->
    <div class="section-container" id="destinations">
        <div class="section-header-action">
            <div>
                <span class="text-uppercase text-warning fw-bold small">Must Visit Places</span>
                <h2 class="section-heading mb-0">Top Destinations</h2>
            </div>
            <div class="scroll-buttons-group">
                <button class="scroll-btn" onclick="scrollSection('destinationRow', -300)"><i class="fa-solid fa-chevron-left"></i></button>
                <button class="scroll-btn" onclick="scrollSection('destinationRow', 300)"><i class="fa-solid fa-chevron-right"></i></button>
            </div>
        </div>

        <div class="horizontal-scroll-container" id="destinationRow">
            <c:forEach var="place" items="${attractions}">
                <div class="horizontal-scroll-item">
                    <a href="/listing-details?id=${place.listingId}" class="text-decoration-none">
                        <div class="booking-card h-100">
                            <img src="${empty place.imageUrl ? 'https://images.unsplash.com/photo-1578922746465-3a8ab1b941cc?fm=jpg&w=600' : place.imageUrl}" alt="${place.title}">
                            <div class="booking-card-body">
                                <span class="category-badge">Attraction</span>
                                <h5 class="fw-bold mb-1 text-truncate">${place.title}</h5>
                                <p class="text-muted mb-2"><i class="fa-solid fa-location-dot text-danger me-1"></i> ${place.location}</p>
                                <span class="fw-bold text-warning mt-auto">View Details &rarr;</span>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 2. FEATURED STAYS SECTION -->
    <div class="section-container pt-0" id="stays-section">
        <div class="section-header-action">
            <div>
                <span class="text-uppercase text-warning fw-bold small">Curated Accommodations</span>
                <h2 class="section-heading mb-0">Featured Stays (Hotels & Villas)</h2>
            </div>
            <div class="scroll-buttons-group">
                <button class="scroll-btn" onclick="scrollSection('staysRow', -300)"><i class="fa-solid fa-chevron-left"></i></button>
                <button class="scroll-btn" onclick="scrollSection('staysRow', 300)"><i class="fa-solid fa-chevron-right"></i></button>
            </div>
        </div>

        <div class="horizontal-scroll-container" id="staysRow">
            <c:forEach var="hotel" items="${hotels}">
                <div class="horizontal-scroll-item">
                    <div class="booking-card">
                        <img src="${empty hotel.imageUrl ? 'https://images.unsplash.com/photo-1566073771259-6a8506099945?fm=jpg&w=600' : hotel.imageUrl}" alt="${hotel.title}">
                        <div class="booking-card-body">
                            <span class="category-badge">Hotel</span>
                            <h5 class="fw-bold mb-1 text-truncate"><a href="/listing-details?id=${hotel.listingId}" class="text-decoration-none" style="color: var(--ocean-blue);">${hotel.title}</a></h5>
                            <p class="text-muted mb-3"><i class="fa-solid fa-location-dot text-danger me-1"></i> ${hotel.location}</p>
                            <div class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top">
                                <span class="fw-bold fs-6" style="color: var(--ocean-blue);">$${hotel.price}</span>
                                <a href="/book-listing?id=${hotel.listingId}" class="btn btn-sm btn-custom-main px-3">Book</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:forEach var="villa" items="${villas}">
                <div class="horizontal-scroll-item">
                    <div class="booking-card">
                        <img src="${empty villa.imageUrl ? 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?fm=jpg&w=600' : villa.imageUrl}" alt="${villa.title}">
                        <div class="booking-card-body">
                            <span class="category-badge">Villa</span>
                            <h5 class="fw-bold mb-1 text-truncate"><a href="/listing-details?id=${villa.listingId}" class="text-decoration-none" style="color: var(--ocean-blue);">${villa.title}</a></h5>
                            <p class="text-muted mb-3"><i class="fa-solid fa-location-dot text-danger me-1"></i> ${villa.location}</p>
                            <div class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top">
                                <span class="fw-bold fs-6" style="color: var(--ocean-blue);">$${villa.price}</span>
                                <a href="/book-listing?id=${villa.listingId}" class="btn btn-sm btn-custom-main px-3">Book</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 3. EXPLORE VEHICLES SECTION -->
    <div class="section-container pt-0" id="transports-section">
        <div class="section-header-action">
            <div>
                <span class="text-uppercase text-warning fw-bold small">Islandwide Mobility</span>
                <h2 class="section-heading mb-0">Explore Vehicles</h2>
            </div>
            <div class="scroll-buttons-group">
                <button class="scroll-btn" onclick="scrollSection('transportsRow', -300)"><i class="fa-solid fa-chevron-left"></i></button>
                <button class="scroll-btn" onclick="scrollSection('transportsRow', 300)"><i class="fa-solid fa-chevron-right"></i></button>
            </div>
        </div>

        <div class="horizontal-scroll-container" id="transportsRow">
            <c:forEach var="transport" items="${transports}">
                <div class="horizontal-scroll-item">
                    <a href="/transport-details?id=${transport.id}" class="text-decoration-none">
                        <div class="booking-card h-100">
                            <img src="${empty transport.imageUrl ? 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?fm=jpg&w=600' : transport.imageUrl}" alt="${transport.vehicleModel}">
                            <div class="booking-card-body">
                                <span class="category-badge">${transport.vehicleType}</span>
                                <h5 class="fw-bold mb-1 text-truncate">${transport.vehicleModel}</h5>
                                <p class="text-muted mb-3"><i class="fa-solid fa-users text-primary me-1"></i> Seats: ${transport.seatingCapacity}</p>
                                <div class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top">
                                    <span class="fw-bold fs-6" style="color: var(--ocean-blue);">$${transport.price}</span>
                                    <span class="fw-bold text-warning">View Details &rarr;</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 4. CUSTOM TRAVEL PACKAGES SECTION -->
    <div class="section-container pt-0" id="packages-section">
        <div class="section-header-action">
            <div>
                <span class="text-uppercase text-warning fw-bold small">Special Itineraries</span>
                <h2 class="section-heading mb-0">Custom Travel Packages</h2>
            </div>
            <div class="scroll-buttons-group">
                <button class="scroll-btn" onclick="scrollSection('packagesRow', -320)"><i class="fa-solid fa-chevron-left"></i></button>
                <button class="scroll-btn" onclick="scrollSection('packagesRow', 320)"><i class="fa-solid fa-chevron-right"></i></button>
            </div>
        </div>

        <div class="horizontal-scroll-container" id="packagesRow">
            <c:forEach var="pkg" items="${travelPackages}">
                <div class="horizontal-scroll-item" style="flex: 0 0 320px; min-width: 320px; max-width: 320px;">
                    <div class="booking-card h-100">
                        <img src="${empty pkg.imageUrl ? 'https://images.unsplash.com/photo-1546708973-b339540b5162?fm=jpg&w=600' : pkg.imageUrl}" alt="${pkg.packageName}">
                        <div class="booking-card-body">
                            <span class="category-badge">${pkg.durationDays} Days Tour</span>
                            <h5 class="fw-bold mb-1 text-truncate">${pkg.packageName}</h5>
                            <p class="text-muted mb-2"><i class="fa-solid fa-route text-danger me-1"></i> ${pkg.destination}</p>
                            <p class="text-secondary mb-3 text-truncate">${pkg.description}</p>
                            <div class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top">
                                <span class="fw-bold fs-5" style="color: var(--ocean-blue);">$${pkg.totalPrice}</span>
                                <a href="/package-details?id=${pkg.packageId}" class="btn btn-sm btn-custom-main px-3">View Package</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 5. AVAILABLE PROMO CODES SECTION -->
    <div class="section-container pt-0" id="promos-section">
        <div class="section-header-action">
            <div>
                <span class="text-uppercase text-warning fw-bold small">Exclusive Discounts</span>
                <h2 class="section-heading mb-0">Available Promo Codes</h2>
            </div>
            <div class="scroll-buttons-group">
                <button class="scroll-btn" onclick="scrollSection('promosRow', -300)"><i class="fa-solid fa-chevron-left"></i></button>
                <button class="scroll-btn" onclick="scrollSection('promosRow', 300)"><i class="fa-solid fa-chevron-right"></i></button>
            </div>
        </div>

        <div class="horizontal-scroll-container" id="promosRow">
            <c:forEach var="promo" items="${promoCodes}">
                <div class="horizontal-scroll-item" style="flex: 0 0 320px; min-width: 320px;">
                    <div class="promo-card">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-warning text-dark px-3 py-1 fw-bold fs-6">${promo.code}</span>
                            <span class="fw-bold text-warning fs-5">${promo.discountPercentage}% OFF</span>
                        </div>
                        <p class="text-white-50 mb-0">${promo.description}</p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- CUSTOMER REVIEWS SECTION -->
    <div class="section-container pt-0" id="reviews">
        <div class="mb-5">
            <div class="section-header-action mb-3">
                <div>
                    <span class="text-uppercase text-warning fw-bold small">Testimonials</span>
                    <h2 class="section-heading mb-0">What Our Travelers Say</h2>
                </div>
            </div>

            <div class="auto-scroll-wrapper overflow-hidden position-relative">
                <div class="horizontal-scroll-container auto-scroll-track" id="reviewsRow" style="gap: 1.5rem;">
                    <c:forEach var="review" items="${approvedReviews}">
                        <div class="horizontal-scroll-item" style="flex: 0 0 340px; min-width: 340px;">
                            <div class="booking-card p-4 h-100 border-0 shadow-sm" style="background: #ffffff; border-radius: 16px;">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="bg-light rounded-circle d-flex align-items-center justify-content-center fw-bold me-3" style="width: 45px; height: 45px; font-size: 1.2rem; color: var(--ocean-blue);">
                                        ${review.tourist.fullName.substring(0, 1).toUpperCase()}
                                    </div>
                                    <div>
                                        <h6 class="fw-bold mb-0" style="color: var(--ocean-blue);">${review.tourist.fullName}</h6>
                                        <small class="text-muted">Verified Traveler</small>
                                    </div>
                                </div>
                                <p class="text-secondary fst-italic mb-0" style="line-height: 1.6;">"${review.comment}"</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="row align-items-stretch g-4">
            <div class="col-lg-5 d-flex flex-column">
                <div class="p-4 bg-white rounded-4 shadow-sm border h-100 d-flex flex-column justify-content-center">
                    <span class="text-uppercase text-warning fw-bold small">Share Your Voice</span>
                    <h2 class="section-heading mb-3" style="font-family: 'Fraunces', serif; font-size: 2.1rem; line-height: 1.2;">
                        What Our Travelers Say & Explore With Confidence.
                    </h2>
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <span class="fw-bold fs-5">4.8/5</span>
                        <span class="text-warning fs-5">★★★★★</span>
                        <span class="fw-bold text-muted">PearlTrails</span>
                    </div>
                    <p class="text-secondary mb-0">Verified experiences from real travelers across Sri Lanka. Submit your feedback using the form to have it featured on our platform after review.</p>
                </div>
            </div>

            <div class="col-lg-7">
                <div class="p-4 bg-white rounded-4 shadow-sm border h-100">
                    <div class="mb-3">
                        <h5 class="fw-bold mb-1" style="font-size: 1.25rem; color: var(--ocean-blue);">Share Your PearlTrails Experience</h5>
                        <p class="text-muted mb-0">We value your feedback! Fill out the details below.</p>
                    </div>

                    <form action="/submit-review" method="post" class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label fw-bold text-secondary">Your Full Name</label>
                            <input type="text" name="touristName" class="form-control rounded-3 py-2" placeholder="e.g. Alexander Smith" required>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label fw-bold text-secondary d-block">Rating Score</label>
                            <div class="star-rating-group">
                                <input type="radio" id="star5" name="rating" value="5" required /><label for="star5" title="5 stars"><i class="fa-solid fa-star"></i></label>
                                <input type="radio" id="star4" name="rating" value="4" /><label for="star4" title="4 stars"><i class="fa-solid fa-star"></i></label>
                                <input type="radio" id="star3" name="rating" value="3" /><label for="star3" title="3 stars"><i class="fa-solid fa-star"></i></label>
                                <input type="radio" id="star2" name="rating" value="2" /><label for="star2" title="2 stars"><i class="fa-solid fa-star"></i></label>
                                <input type="radio" id="star1" name="rating" value="1" /><label for="star1" title="1 star"><i class="fa-solid fa-star"></i></label>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label fw-bold text-secondary">Your Review & Comments</label>
                            <textarea name="comment" class="form-control rounded-3" rows="3" placeholder="Describe your trip, stays, or vehicle rental experience..." required></textarea>
                        </div>

                        <div class="col-12 text-end mt-3">
                            <button type="submit" class="btn btn-custom-main px-4 py-2 shadow-sm">Submit Review</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- CONTACT SECTION -->
    <div class="contact-box" id="contact" style="background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep)); border-radius: 24px; padding: 4rem; color: #ffffff; margin: 0 2.5rem 3rem 2.5rem;">
        <div class="row align-items-center">
            <div class="col-lg-5 mb-4 mb-lg-0">
                <span class="text-warning text-uppercase fw-bold small">Get In Touch</span>
                <h2 class="fw-bold mb-3" style="font-family:'Fraunces', serif; font-size: 2.2rem; color: #ffffff;">Plan Your Dream Sri Lanka Trip</h2>
                <p class="text-white-50 mb-3" style="font-size: 1.05rem;">Have questions or custom trip requests? Reach out to our team.</p>
                <p class="text-white mb-1" style="font-size: 1.02rem;"><i class="fa-solid fa-envelope text-warning me-2"></i> <strong>Email:</strong> pearltrails.admin@gmail.com</p>
                <p class="text-white mb-0" style="font-size: 1.02rem;"><i class="fa-solid fa-phone text-warning me-2"></i> <strong>Phone:</strong> +94 71 587 2765</p>
            </div>
            <div class="col-lg-7">
                <form action="/contact" method="post" class="row g-3 bg-white bg-opacity-10 p-4 rounded-4 shadow-lg">
                    <div class="col-md-6"><input type="text" name="name" class="form-control py-2" placeholder="Your Name" required></div>
                    <div class="col-md-6"><input type="email" name="email" class="form-control py-2" placeholder="Your Email" required></div>
                    <div class="col-12"><textarea name="message" class="form-control" rows="3" placeholder="Your Message" required></textarea></div>
                    <div class="col-12 text-end"><button type="submit" class="btn btn-custom-main px-5 py-2">Send Message</button></div>
                </form>
            </div>
        </div>
    </div>

    <!-- FOOTER SECTION -->
    <footer class="site-footer text-center">
        <p class="text-white-50 mb-0">&copy; 2026 PearlTrails Tourism Platform. All rights reserved.</p>
    </footer>

    <!-- JavaScript for Horizontal Scroll Buttons -->
    <script>
        function scrollSection(rowId, distance) {
            const row = document.getElementById(rowId);
            if (row) {
                row.scrollBy({ left: distance, behavior: 'smooth' });
            }
        }
    </script>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>