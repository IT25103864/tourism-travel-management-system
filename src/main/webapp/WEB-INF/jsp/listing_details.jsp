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
    <title>${listing.title} - PearlTrails</title>
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

        /* Cards & Content Styling */
        .content-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.08);
            padding: 2.5rem;
            margin-bottom: 2rem;
        }
        .listing-title {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 2.2rem;
            color: var(--ocean-blue);
        }

        /* Form Elements */
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
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(201, 151, 63, 0.18);
        }

        /* Buttons (Gold Theme) */
        .btn-custom-main {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            font-size: 1.05rem;
            border-radius: 999px;
            padding: 0.85rem 2rem;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 10px 22px -10px rgba(201, 151, 63, 0.6);
        }
        .btn-custom-main:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
            box-shadow: 0 14px 26px -10px rgba(201, 151, 63, 0.7);
        }
        .btn-outline-custom {
            border: 1.5px solid var(--ocean-blue);
            color: var(--ocean-blue);
            font-weight: 600;
            border-radius: 999px;
            padding: 0.75rem 1.8rem;
            background: transparent;
            transition: all 0.15s ease;
        }
        .btn-outline-custom:hover {
            background: var(--ocean-blue);
            color: #ffffff;
        }
    </style>
</head>
<body>

    <!-- Simple Public Navbar -->
    <nav class="navbar navbar-pearltrails navbar-expand-lg sticky-top shadow-sm mb-4">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="/">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="PearlTrails Logo">
                <span>Pearl<span style="color: var(--gold);">Trails</span></span>
            </a>
            <div class="d-flex align-items-center">
                <c:if test="${empty sessionScope.loggedInUser}">
                    <a href="/login" class="text-white text-decoration-none small fw-bold me-3">Login</a>
                    <a href="/register" class="btn btn-custom-main btn-sm px-4 py-2" style="width: auto !important;">Sign Up</a>
                </c:if>
                <c:if test="${not empty sessionScope.loggedInUser}">
                    <span class="text-white me-3 fw-semibold">👤 ${sessionScope.loggedInUser.fullName}</span>
                    <a href="/logout" class="btn btn-outline-danger btn-sm" style="width: auto !important;">Logout</a>
                </c:if>
            </div>
        </div>
    </nav>

    <div class="container mt-4 mb-5">
        <div class="row g-4">
            <!-- Listing Details Section -->
            <div class="col-lg-8">

                <!-- Listing Image Preview -->
                <c:if test="${not empty listing.imageUrl}">
                    <div class="mb-4">
                        <img src="${listing.imageUrl}" alt="${listing.title}" class="img-fluid rounded-4 shadow-sm w-100" style="max-height: 450px; object-fit: cover; border: 1.5px solid var(--border-soft);">
                    </div>
                </c:if>

                <div class="content-card">
                    <h2 class="listing-title mb-2">${listing.title}</h2>
                    <h5 class="text-muted mb-4"><i class="fa-solid fa-location-dot text-danger me-2"></i>${listing.location}</h5>
                    <hr class="my-4" style="border-color: var(--border-soft);">
                    <h4 class="fw-bold mb-3" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);">Description</h4>
                    <p class="fs-6 text-secondary mb-0" style="white-space: pre-line;">${listing.description}</p>
                </div>

                <!-- Reviews Section -->
                <h4 class="fw-bold mb-3" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);">Guest Reviews</h4>
                <c:forEach var="review" items="${reviews}">
                    <div class="content-card py-3 px-4 mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="fw-bold mb-0" style="color: var(--ocean-blue);">${review.tourist.fullName}</h6>
                            <span class="badge bg-warning text-dark px-3 py-1 rounded-pill fw-bold"><i class="fa-solid fa-star me-1"></i> ${review.rating} / 5</span>
                        </div>
                        <p class="mt-2 mb-0 text-secondary">${review.comment}</p>
                    </div>
                </c:forEach>

                <c:if test="${empty reviews}">
                    <p class="text-muted fst-italic mb-4">No reviews yet for this place. Be the first to share your experience!</p>
                </c:if>

                <!-- Add Review Form -->
                <div class="content-card mt-4">
                    <h4 class="fw-bold mb-4" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);">Leave a Review</h4>
                    <form action="/add-review" method="post">
                        <input type="hidden" name="listingId" value="${listing.listingId}">

                        <div class="mb-3">
                            <label class="form-label">Rating</label>
                            <select name="rating" class="form-select" required>
                                <option value="5">⭐⭐⭐⭐⭐ (5/5) - Excellent</option>
                                <option value="4">⭐⭐⭐⭐ (4/5) - Very Good</option>
                                <option value="3">⭐⭐⭐ (3/5) - Average</option>
                                <option value="2">⭐⭐ (2/5) - Poor</option>
                                <option value="1">⭐ (1/5) - Terrible</option>
                            </select>
                        </div>

                        <!-- Comment Input -->
                        <div class="mb-4">
                            <label class="form-label">Comment</label>
                            <textarea name="comment" class="form-control" rows="3" required placeholder="Share your experience..."></textarea>
                        </div>

                        <button type="submit" class="btn btn-outline-custom">Submit Review</button>
                    </form>
                </div>
            </div>

            <!-- Sidebar (Price and Booking based on type) -->
            <div class="col-lg-4">
                <c:choose>
                    <%-- If the listing is an Attraction, show info only --%>
                    <c:when test="${listing.propertyType == 'Attraction'}">
                        <div class="content-card border-top border-warning border-4 text-center py-4">
                            <span class="badge bg-warning text-dark mb-2 px-3 py-1 rounded-pill fw-bold">Must Visit Attraction</span>
                            <h5 class="fw-bold mt-3" style="color: var(--ocean-blue);">Free to Visit / Explore</h5>
                            <p class="text-muted small mb-0">Enjoy the breathtaking views and experiences at this destination.</p>
                        </div>
                    </c:when>
                    <%-- If it's a Hotel or Villa, show booking card --%>
                    <c:otherwise>
                        <div class="content-card border-top border-primary border-4 text-center">
                            <c:choose>
                                <c:when test="${listing.price == 0.0}">
                                    <h3 class="text-success fw-bold mb-3 font-monospace">Free</h3>
                                </c:when>
                                <c:otherwise>
                                    <h3 class="fw-bold mb-3" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);">$${listing.price} <span class="fs-6 text-muted fw-normal">/ night</span></h3>
                                </c:otherwise>
                            </c:choose>

                            <a href="/book?listingId=${listing.listingId}" class="btn btn-custom-main btn-lg w-100 mb-3 py-3">Book Now</a>
                            <small class="text-muted d-block">You won't be charged yet</small>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>