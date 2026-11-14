<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Listing - PearlTrails</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

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
        }

        body {
            background: var(--bg);
            font-family: 'Inter', sans-serif;
            color: #1f2d2c;
            font-size: 1.05rem;
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

        .page-eyebrow {
            font-size: 0.85rem;
            font-weight: 600;
            letter-spacing: 0.14em;
            text-transform: uppercase;
            color: var(--gold);
            margin-bottom: 0.35rem;
        }
        .page-heading {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 2.2rem;
            color: var(--ocean-blue);
        }
        .page-subtext {
            color: var(--text-muted);
            font-size: 1.02rem;
        }

        .listing-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.1);
        }
        .listing-card-header {
            background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep));
            padding: 1.75rem 2rem 1.5rem;
            position: relative;
        }
        .listing-card-header::after {
            content: "";
            position: absolute;
            left: 2rem;
            bottom: -1px;
            width: 42px;
            height: 3px;
            background: var(--gold);
            border-radius: 2px;
        }
        .listing-card-header h4 {
            font-family: 'Fraunces', serif;
            font-weight: 600;
            color: #ffffff;
            margin: 0;
            font-size: 1.4rem;
        }
        .listing-card-header p {
            color: rgba(255,255,255,0.78);
            font-size: 0.92rem;
            margin: 0.3rem 0 0;
        }
        .listing-card-body {
            padding: 2.2rem;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.92rem;
            color: var(--ocean-blue);
        }
        .form-control, .form-select, textarea.form-control {
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
        .form-hint {
            color: var(--text-muted);
            font-size: 0.85rem;
            margin-top: 0.4rem;
        }

        .btn-pearltrails {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            font-size: 1.02rem;
            border-radius: 999px;
            padding: 0.85rem 1.5rem;
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

    <!-- Navbar -->
    <nav class="navbar navbar-pearltrails navbar-expand-lg sticky-top shadow-sm">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="/">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="PearlTrails Logo">
                <span>Pearl<span style="color: var(--gold);">Trails</span></span>
            </a>
            <div class="d-flex align-items-center">
                <a href="/" class="text-white text-decoration-none small fw-bold me-3">Home</a>
                <a href="/my-listings" class="text-white text-decoration-none small fw-bold">My Places</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-7">

                <div class="page-eyebrow">Provider Listings</div>
                <h2 class="page-heading mb-1">Add a new place</h2>
                <p class="page-subtext mb-4">Submit your property or place for admin approval.</p>

                <div class="card listing-card">
                    <div class="listing-card-header">
                        <h4>Listing Details</h4>
                        <p>Every field below is shown to travellers once approved.</p>
                    </div>
                    <div class="listing-card-body">
                        <form action="/add-listing" method="post">
                            <div class="mb-3">
                                <label class="form-label">Title</label>
                                <input type="text" name="title" class="form-control" required placeholder="e.g. Sunset Beach Villa">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Location</label>
                                <input type="text" name="location" class="form-control" required placeholder="e.g. Mirissa, Sri Lanka">
                            </div>

                            <!-- Property Type Dropdown (Hotel, Villa, Attraction) -->
                            <div class="mb-3">
                                <label class="form-label">Property Type</label>
                                <select name="propertyType" class="form-select" required>
                                    <option value="">-- Select Property Type --</option>
                                    <option value="Hotel">Hotel</option>
                                    <option value="Villa">Villa</option>
                                    <option value="Attraction">Attraction</option>
                                </select>
                                <div class="form-hint">Choose whether this appears under Stays or Destinations.</div>
                            </div>

                            <!-- Price field -->
                            <div class="mb-3">
                                <label class="form-label">Price / Entrance Fee (LKR / $) <span class="text-muted fw-normal text-lowercase">(Optional)</span></label>
                                <input type="number" step="0.01" name="price" class="form-control" placeholder="e.g. 15000.00 (Leave empty if free)">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Image URL</label>
                                <input type="url" name="imageUrl" class="form-control" required placeholder="e.g. https://images.unsplash.com/...">
                                <div class="form-hint">Provide a valid high-quality image link.</div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Description</label>
                                <textarea name="description" class="form-control" rows="4" required placeholder="Describe your place..."></textarea>
                            </div>

                            <button type="submit" class="btn btn-pearltrails w-100 py-2">Submit for Approval</button>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>

</body>
</html>