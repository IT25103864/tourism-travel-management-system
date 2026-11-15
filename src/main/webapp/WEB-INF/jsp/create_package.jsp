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
    <title>Create Custom Travel Package - PearlTrails</title>
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

        /* Navbar Style */
        .navbar-pearltrails {
            background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep)) !important;
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
            height: 55px;
            width: auto;
            object-fit: contain;
        }

        .package-card {
            border: 1.5px solid var(--border-soft);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 20px 40px -15px rgba(27, 58, 75, 0.12);
            background: #ffffff;
        }

        .package-card-header {
            background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep));
            padding: 2.2rem 2rem;
            text-align: center;
            color: #ffffff;
            position: relative;
        }

        .package-card-header::after {
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

        .package-card-header h3 {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 1.75rem;
            margin-bottom: 0.4rem;
            color: #ffffff;
        }

        .package-card-body {
            padding: 2.5rem;
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

        /* Scrollable checkbox container style */
        .checkbox-container {
            max-height: 180px;
            overflow-y: auto;
            border: 1.5px solid var(--border-soft);
            border-radius: 12px;
            padding: 0.85rem 1.1rem;
            background: #ffffff;
        }
        .form-check-input:checked {
            background-color: var(--gold);
            border-color: var(--gold);
        }

        .btn-pearltrails {
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

        .btn-pearltrails:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
            box-shadow: 0 14px 26px -10px rgba(201, 151, 63, 0.7);
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-pearltrails sticky-top shadow-sm mb-4">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="/">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="PearlTrails Logo">
                <span>Pearl<span style="color: var(--gold);">Trails</span></span>
            </a>
            <div class="d-flex align-items-center">
                <a href="/" class="text-white text-decoration-none small fw-bold me-3">Home</a>
                <a href="/my-packages" class="text-white text-decoration-none small fw-bold">My Packages</a>
            </div>
        </div>
    </nav>

    <!-- Main Container for Package Creation Form -->
    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-9 col-lg-8">
                <div class="card package-card">
                    <div class="package-card-header">
                        <h3>Create Your Custom Travel Package</h3>
                        <p class="mb-0 text-white-50 small">Select destinations, stays, transport, and add details for your trip.</p>
                    </div>
                    <div class="package-card-body">
                        <!-- Form submitting to backend package save mapping -->
                        <form action="/save-package" method="post">

                            <!-- Package Name Field -->
                            <div class="mb-3">
                                <label class="form-label">Package Name</label>
                                <input type="text" name="packageName" class="form-control" placeholder="e.g., Galle Heritage & Rumassala Getaway" required>
                            </div>

                            <!-- Image URL Field for Card Display -->
                            <div class="mb-3">
                                <label class="form-label">Package Cover Image URL</label>
                                <input type="text" name="imageUrl" class="form-control" placeholder="https://images.unsplash.com/..." required>
                                <small class="text-muted">Provide a high-quality image link to display on the home page cards.</small>
                            </div>

                            <!-- Multiple Destinations / Attractions Selection -->
                            <div class="mb-3">
                                <label class="form-label">Select Destinations / Attractions</label>
                                <div class="checkbox-container">
                                    <c:forEach var="dest" items="${destinationListings}">
                                        <div class="form-check mb-2">
                                            <!-- Checkbox inputs mapped as a list in Spring Boot Controller -->
                                            <input class="form-check-input" type="checkbox" name="destinationListingIds" value="${dest.listingId}" id="dest_${dest.listingId}">
                                            <label class="form-check-label small fw-semibold text-dark" for="dest_${dest.listingId}">
                                                ${dest.title} (${dest.location})
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Multiple Hotels / Villas (Stays) Selection -->
                            <div class="mb-3">
                                <label class="form-label">Select Hotels / Villas (Stays)</label>
                                <div class="checkbox-container">
                                    <c:forEach var="hotel" items="${hotelListings}">
                                        <div class="form-check mb-2">
                                            <!-- Checkbox inputs mapped as a list in Spring Boot Controller -->
                                            <input class="form-check-input" type="checkbox" name="hotelListingIds" value="${hotel.listingId}" id="hotel_${hotel.listingId}">
                                            <label class="form-check-label small fw-semibold text-dark" for="hotel_${hotel.listingId}">
                                                ${hotel.title} (${hotel.location}) - <span class="text-success fw-bold">$ ${hotel.price}</span>
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Transport / Vehicle Selection Dropdown -->
                            <div class="mb-3">
                                <label class="form-label">Select Vehicle / Transport</label>
                                <select name="transportId" class="form-select" required>
                                    <option value="">-- Choose Transport Service --</option>
                                    <c:forEach var="t" items="${transports}">
                                        <option value="${t.id}">
                                            ${t.vehicleType} - ${t.vehicleModel} (${t.numberPlate}) - $ ${t.price}/day
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Number of Days (Duration) Field -->
                            <div class="mb-3">
                                <label class="form-label">Number of Days (Duration)</label>
                                <input type="number" name="numberOfDays" class="form-control" min="1" value="1" required>
                            </div>

                            <!-- Total Price Field -->
                            <div class="mb-3">
                                <label class="form-label">Total Price ($)</label>
                                <input type="number" step="0.01" name="totalPrice" class="form-control" placeholder="e.g., 320.00" required>
                            </div>

                            <!-- Detailed Description Textarea -->
                            <div class="mb-4">
                                <label class="form-label">Package Description</label>
                                <textarea name="description" class="form-control" rows="4" placeholder="Describe the tour details, included places, stays, and experience..." required></textarea>
                            </div>

                            <!-- Form Action Buttons -->
                            <div class="d-flex justify-content-between align-items-center mt-4">
                                <a href="/" class="btn btn-outline-secondary rounded-pill px-4 py-2">Cancel</a>
                                <button type="submit" class="btn-pearltrails">Create Package</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>