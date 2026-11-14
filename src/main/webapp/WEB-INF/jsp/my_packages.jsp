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
    <title>My Travel Packages - PearlTrails</title>
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

        /* Package Card Styling */
        .package-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.08);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .package-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.12);
        }
        .pkg-img {
            height: 200px;
            object-fit: cover;
            width: 100%;
            border-bottom: 1.5px solid var(--border-soft);
        }

        /* Buttons (Gold Theme) */
        .btn-custom-create {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            border-radius: 999px;
            padding: 0.5rem 1.25rem;
            transition: transform 0.15s ease, background 0.15s ease;
            box-shadow: 0 8px 18px -8px rgba(201, 151, 63, 0.6);
        }
        .btn-custom-create:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
        }
        .btn-view-action {
            border: 1.5px solid var(--ocean-blue);
            color: var(--ocean-blue);
            background: transparent;
            font-weight: 600;
            border-radius: 999px;
            padding: 0.4rem 1.2rem;
            transition: all 0.15s ease;
        }
        .btn-view-action:hover {
            background: var(--ocean-blue);
            color: #ffffff;
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
<body>

    <!-- Navbar Section -->
    <nav class="navbar navbar-pearltrails navbar-expand-lg sticky-top shadow-sm mb-4">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="/">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="PearlTrails Logo">
                <span>Pearl<span style="color: var(--gold);">Trails</span></span>
            </a>
            <div class="d-flex align-items-center">
                <a href="/create-package" class="btn btn-custom-create fw-bold me-2"><i class="fa-solid fa-plus me-1"></i> Create New Package</a>
                <a href="/" class="text-white text-decoration-none small fw-bold me-3">Home</a>
                <a href="/logout" class="btn btn-outline-danger btn-sm px-3" style="width: auto !important;">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container mt-4 mb-5">
        <!-- Alert Messages for Update and Delete -->
        <c:if test="${param.updated eq 'true'}">
            <div class="alert alert-success alert-dismissible fade show rounded-4 p-3 shadow-sm mb-4" role="alert">
                <strong><i class="fa-solid fa-circle-check me-1"></i> Successfully Updated!</strong> Your travel package has been updated.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${param.deleted eq 'true'}">
            <div class="alert alert-danger alert-dismissible fade show rounded-4 p-3 shadow-sm mb-4" role="alert">
                <strong><i class="fa-solid fa-trash-can me-1"></i> Successfully Deleted!</strong> Your travel package has been removed.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${param.success eq 'created'}">
            <div class="alert alert-success alert-dismissible fade show rounded-4 p-3 shadow-sm mb-4" role="alert">
                <strong><i class="fa-solid fa-circle-check me-1"></i> Successfully Created!</strong> Your new custom travel package has been created.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="page-heading mb-1">My Custom Travel Packages</h2>
                <p class="text-muted mb-0">Manage and customize your curated travel routes and vacation packages.</p>
            </div>
        </div>

        <div class="row">
            <!-- Iterate over each created travel package -->
            <c:forEach var="pkg" items="${packages}">
                <div class="col-md-6 mb-4">
                    <div class="card package-card h-100 d-flex flex-column border-0">

                        <!-- Package Cover Image -->
                        <div class="position-relative">
                            <img src="${not empty pkg.imageUrl ? pkg.imageUrl : 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?fm=jpg&w=800'}"
                                 class="pkg-img" alt="${pkg.packageName}">
                            <span class="position-absolute top-0 end-0 m-3 badge bg-dark px-3 py-2 rounded-pill shadow fw-bold">
                                <i class="fa-regular fa-clock text-warning me-1"></i> ${pkg.durationDays} Days Tour
                            </span>
                        </div>

                        <!-- Card Body Details -->
                        <div class="card-body d-flex flex-column flex-grow-1 p-4">
                            <h4 class="card-title fw-bold mb-3" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);"><i class="fa-solid fa-box me-2 text-warning"></i>${pkg.packageName}</h4>

                            <hr class="my-2" style="border-color: var(--border-soft);">

                            <!-- Destinations / Places Included -->
                            <div class="mb-2">
                                <span class="text-dark fw-bold small"><i class="fa-solid fa-location-dot text-danger me-1"></i> Destinations / Stays:</span>
                                <p class="mb-1 text-muted small ps-3"><strong>${pkg.destination}</strong></p>
                            </div>

                            <!-- Package Description -->
                            <div class="mb-3">
                                <span class="text-dark fw-bold small"><i class="fa-solid fa-circle-info text-info me-1"></i> Description:</span>
                                <p class="mb-0 text-muted small ps-3 text-truncate">${pkg.description}</p>
                            </div>

                            <hr class="my-2 mt-auto" style="border-color: var(--border-soft);">

                            <!-- Pricing and Checkout Action -->
                            <div class="d-flex justify-content-between align-items-center pt-2">
                                <div>
                                    <span class="fw-bold text-secondary small">Total: </span>
                                    <span class="fw-bold fs-4" style="color: var(--ocean-blue);">$${pkg.totalPrice}</span>
                                </div>
                                <a href="/package-details?id=${pkg.packageId}" class="btn btn-sm btn-view-action fw-bold px-3">View Details</a>
                            </div>

                            <!-- Edit and Delete Actions for Travel Agents -->
                            <div class="mt-3 pt-3 border-top d-flex justify-content-between gap-2">
                                <a href="/edit-package?id=${pkg.packageId}" class="btn btn-sm btn-edit-action w-50 text-center"><i class="fa-solid fa-pen-to-square me-1"></i> Edit</a>
                                <a href="/delete-package?id=${pkg.packageId}" class="btn btn-sm btn-delete-action w-50 text-center" onclick="return confirm('Are you sure you want to delete this package?');"><i class="fa-solid fa-trash me-1"></i> Delete</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- Fallback message if no packages are found -->
            <c:if test="${empty packages}">
                <div class="col-12 text-center py-5">
                    <div class="card border-0 shadow-sm p-5 bg-white rounded-4" style="border: 1.5px solid var(--border-soft) !important;">
                        <h4 class="text-muted mb-3 font-monospace">You haven't created any custom packages yet.</h4>
                        <div>
                            <a href="/create-package" class="btn btn-custom-create px-4 py-2 fw-bold">Create Your First Package</a>
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