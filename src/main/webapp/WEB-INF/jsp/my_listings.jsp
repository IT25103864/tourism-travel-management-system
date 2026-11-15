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
    <title>My Listings - PearlTrails</title>
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

        /* Page Headings */
        .page-heading {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 2rem;
            color: var(--ocean-blue);
        }

        /* Listing Card Styling */
        .listing-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.08);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .listing-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.12);
        }
        .listing-img {
            height: 200px;
            object-fit: cover;
            width: 100%;
            border-bottom: 1.5px solid var(--border-soft);
        }

        /* Buttons (Gold Theme) */
        .btn-custom-add {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            border-radius: 999px;
            padding: 0.5rem 1.25rem;
            transition: transform 0.15s ease, background 0.15s ease;
            box-shadow: 0 8px 18px -8px rgba(201, 151, 63, 0.6);
        }
        .btn-custom-add:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
        }
        .btn-edit-action {
            border: 1.5px solid var(--ocean-blue);
            color: var(--ocean-blue);
            background: transparent;
            font-weight: 600;
            border-radius: 999px;
            padding: 0.4rem 1rem;
            transition: all 0.15s ease;
        }
        .btn-edit-action:hover {
            background: var(--ocean-blue);
            color: #ffffff;
        }
        .btn-delete-action {
            border: 1.5px solid #ef4444;
            color: #ef4444;
            background: transparent;
            font-weight: 600;
            border-radius: 999px;
            padding: 0.4rem 1rem;
            transition: all 0.15s ease;
        }
        .btn-delete-action:hover {
            background: #ef4444;
            color: #ffffff;
        }
    </style>
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-pearltrails navbar-expand-lg sticky-top shadow-sm mb-4">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="/">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="PearlTrails Logo">
                <span>Pearl<span style="color: var(--gold);">Trails</span></span>
            </a>
            <div class="d-flex align-items-center">
                <a href="/add-listing" class="btn btn-custom-add fw-bold me-2"><i class="fa-solid fa-plus me-1"></i> Add New Place</a>
                <a href="/logout" class="btn btn-outline-danger btn-sm px-3" style="width: auto !important;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4 mb-5">
        <!-- Alert Messages for Update and Delete -->
        <c:if test="${param.updated eq 'true'}">
            <div class="alert alert-success alert-dismissible fade show rounded-4 p-3 shadow-sm mb-4" role="alert">
                <strong><i class="fa-solid fa-circle-check me-1"></i> Successfully Updated!</strong> Your listing has been updated.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${param.deleted eq 'true'}">
            <div class="alert alert-danger alert-dismissible fade show rounded-4 p-3 shadow-sm mb-4" role="alert">
                <strong><i class="fa-solid fa-trash-can me-1"></i> Successfully Deleted!</strong> Your listing has been removed.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="page-heading mb-1">My Listings</h2>
                <p class="text-muted mb-0">Manage the places and properties you have listed on PearlTrails.</p>
            </div>
            <a href="/" class="btn btn-outline-secondary rounded-pill px-4 fw-semibold">Home</a>
        </div>

        <div class="row">
            <c:forEach var="listing" items="${listings}">
                <div class="col-md-4 mb-4">
                    <div class="card listing-card h-100 d-flex flex-column">
                        <!-- Listing Image Display -->
                        <img src="${not empty listing.imageUrl ? listing.imageUrl : 'https://images.unsplash.com/photo-1579989197262-d9fb5b48d2f9?fm=jpg&q=70&w=800&auto=format&fit=crop'}"
                             class="listing-img" alt="${listing.title}">

                        <div class="card-body d-flex flex-column flex-grow-1 p-4">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title fw-bold mb-0" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);">${listing.title}</h5>
                                <c:choose>
                                    <c:when test="${listing.status == 'Approved'}">
                                        <span class="badge bg-success px-3 py-1.5 rounded-pill fw-bold"><i class="fa-solid fa-circle-check me-1"></i> ${listing.status}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning text-dark px-3 py-1.5 rounded-pill fw-bold">${listing.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <p class="text-muted small mb-2"><i class="fa-solid fa-location-dot text-danger me-1"></i> <strong>${listing.location}</strong></p>
                            <p class="card-text small text-secondary flex-grow-1 mb-3">${listing.description}</p>

                            <div class="d-flex justify-content-between align-items-center mt-auto pt-3 border-top">
                                <c:choose>
                                    <c:when test="${listing.price == 0.0}">
                                        <span class="text-success fw-bold fs-5">Free</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="fw-bold fs-5" style="color: var(--ocean-blue);">$${listing.price}</span>
                                    </c:otherwise>
                                </c:choose>
                                <span class="small text-muted font-monospace">ID: #${listing.listingId}</span>
                            </div>

                            <!-- Edit and Delete Actions -->
                            <div class="mt-3 pt-3 border-top d-flex justify-content-between gap-2">
                                <a href="/edit-listing?id=${listing.listingId}" class="btn btn-sm btn-edit-action w-50 text-center"><i class="fa-solid fa-pen-to-square me-1"></i> Edit</a>
                                <a href="/delete-listing?id=${listing.listingId}" class="btn btn-sm btn-delete-action w-50 text-center" onclick="return confirm('Are you sure you want to delete this listing?');"><i class="fa-solid fa-trash me-1"></i> Delete</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty listings}">
                <div class="col-12 text-center py-5">
                    <div class="card border-0 shadow-sm p-5 bg-white rounded-4" style="border: 1.5px solid var(--border-soft) !important;">
                        <h4 class="text-muted mb-3 font-monospace">You haven't added any places yet.</h4>
                        <div>
                            <a href="/add-listing" class="btn btn-custom-add px-4 py-2 fw-bold">Add Your First Place</a>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>