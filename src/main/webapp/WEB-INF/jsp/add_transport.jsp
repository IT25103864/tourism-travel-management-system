<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Transport - PearlTrails</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600;9..144,700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

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
        }

        body {
            background-color: var(--bg);
            font-family: 'Inter', sans-serif;
            color: #1f2d2c;
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
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .navbar-pearltrails .navbar-brand img {
            height: 42px;
            width: auto;
            object-fit: contain;
        }

        .page-eyebrow {
            font-size: 0.85rem;
            font-weight: 700;
            letter-spacing: 0.14em;
            text-transform: uppercase;
            color: var(--transport-green);
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
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .listing-card-header::after {
            content: "";
            position: absolute;
            left: 2rem;
            bottom: -1px;
            width: 42px;
            height: 3px;
            background: var(--transport-green);
            border-radius: 2px;
        }
        .transport-icon-badge {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: rgba(47, 174, 102, 0.18);
            border: 1.5px solid var(--transport-green);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: #ffffff;
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
            font-size: 0.9rem;
            margin: 0.2rem 0 0;
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
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--transport-green);
            box-shadow: 0 0 0 3px rgba(47, 174, 102, 0.18);
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

        .card-footer-link {
            padding: 1.2rem;
            text-align: center;
            border-top: 1px solid var(--border-soft);
            background: #fafcfb;
        }
        .card-footer-link a {
            color: var(--transport-green);
            font-weight: 600;
            font-size: 0.95rem;
            text-decoration: none;
        }
        .card-footer-link a:hover {
            text-decoration: underline;
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
                <a href="/my-transports" class="text-white text-decoration-none small fw-bold">My Vehicles</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-7">

                <div class="page-eyebrow">Transport Provider</div>
                <h2 class="page-heading mb-1">Add a transport service</h2>
                <p class="page-subtext mb-4">List a vehicle and route for travellers to search and book.</p>

                <div class="card listing-card">
                    <div class="listing-card-header">
                        <div class="transport-icon-badge"><i class="fa-solid fa-van-shuttle"></i></div>
                        <div>
                            <h4>Transport Details</h4>
                            <p>Shown to travellers once your listing is live.</p>
                        </div>
                    </div>
                    <div class="listing-card-body">

                        <!-- Form Starts Here -->
                        <form action="/add-transport" method="post">

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Vehicle Type</label>
                                    <select name="vehicleType" class="form-select" required>
                                        <option value="" disabled selected>Select vehicle type</option>
                                        <option value="Car">Car</option>
                                        <option value="Van">Van</option>
                                        <option value="Safari Jeep">Safari Jeep</option>
                                        <option value="SUV">SUV</option>
                                        <option value="Tuk-Tuk">Tuk-Tuk</option>
                                        <option value="Bus">Bus</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Vehicle Model</label>
                                    <input type="text" name="vehicleModel" class="form-control" required placeholder="e.g. Toyota KDH, Honda Vezel">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Number Plate</label>
                                    <input type="text" name="numberPlate" class="form-control" required placeholder="e.g. WP CAA-1234">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Seating Capacity</label>
                                    <input type="number" name="seatingCapacity" class="form-control" required placeholder="e.g. 7">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Route (Optional)</label>
                                <input type="text" name="route" class="form-control" placeholder="e.g. Colombo to Kandy">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Price per day/trip ($)</label>
                                <input type="number" step="0.01" name="price" class="form-control" required placeholder="e.g. 50.00">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Image URL</label>
                                <input type="url" name="imageUrl" class="form-control" required placeholder="e.g. https://images.unsplash.com/...">
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Description</label>
                                <textarea name="description" class="form-control" rows="3" placeholder="AC available, Full insurance..." required></textarea>
                            </div>

                            <button type="submit" class="btn btn-pearltrails w-100 py-2">Add Transport</button>
                        </form>
                    </div>

                    <div class="card-footer-link">
                        <a href="/my-transports">&larr; Back to My Transports</a>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>