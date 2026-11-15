<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book ${listing.title} - PearlTrails</title>
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
            --hotel-blue: #2f6fed;
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

        /* Page heading */
        .page-eyebrow {
            font-size: 0.85rem;
            font-weight: 700;
            letter-spacing: 0.14em;
            text-transform: uppercase;
            color: var(--hotel-blue);
            margin-bottom: 0.35rem;
        }
        .page-subtext {
            color: var(--text-muted);
            font-size: 1.02rem;
        }

        /* Card Styling */
        .booking-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.1);
        }
        .booking-card-header {
            background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep));
            padding: 1.75rem 2rem 1.5rem;
            position: relative;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .booking-card-header::after {
            content: "";
            position: absolute;
            left: 2rem;
            bottom: -1px;
            width: 42px;
            height: 3px;
            background: var(--hotel-blue);
            border-radius: 2px;
        }
        .hotel-icon-badge {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: rgba(47, 111, 237, 0.18);
            border: 1.5px solid var(--hotel-blue);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 1.2rem;
            color: #ffffff;
        }
        .booking-card-header h4 {
            font-family: 'Fraunces', serif;
            font-weight: 600;
            color: #ffffff;
            margin: 0;
            font-size: 1.4rem;
        }
        .booking-card-header p {
            color: rgba(255,255,255,0.78);
            font-size: 0.9rem;
            margin: 0.2rem 0 0;
        }
        .booking-card-body {
            padding: 2.2rem;
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
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--hotel-blue);
            box-shadow: 0 0 0 3px rgba(47, 111, 237, 0.18);
        }

        /* Submit Button (Gold Theme) */
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
                <a href="/my-bookings" class="text-white text-decoration-none small fw-bold">My Bookings</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">

                <div class="page-eyebrow">Hotel Booking</div>
                <p class="page-subtext mb-4">Confirm your stay and room specifications for <strong>${listing.title}</strong> below.</p>

                <div class="card booking-card">
                    <div class="booking-card-header">
                        <div class="hotel-icon-badge"><i class="fa-solid fa-bed"></i></div>
                        <div>
                            <h4>Book ${listing.title}</h4>
                            <p>Review your booking specifications.</p>
                        </div>
                    </div>
                    <div class="booking-card-body">
                        <!-- Action mapped to /book to handle saving booking and automated email confirmation via HttpSession -->
                        <form action="/book" method="post">
                            <!-- Hidden input to pass the listing ID -->
                            <input type="hidden" name="listingId" value="${listing.listingId}">

                            <!-- Check-in Date Input -->
                            <div class="mb-3">
                                <label class="form-label">Check-in Date</label>
                                <input type="date" name="checkInDate" class="form-control" required>
                            </div>

                            <!-- Check-out Date Input -->
                            <div class="mb-3">
                                <label class="form-label">Check-out Date</label>
                                <input type="date" name="checkOutDate" class="form-control" required>
                            </div>

                            <!-- Room Type Selection (Single, Double, Family) -->
                            <div class="mb-3">
                                <label class="form-label">Room Type</label>
                                <select name="roomType" class="form-select" required>
                                    <option value="" disabled selected>Select Room Type</option>
                                    <option value="Single Bed">Single Bed (Max 1-2 Guests)</option>
                                    <option value="Double Bed">Double Bed (Max 2-3 Guests)</option>
                                    <option value="Family Room">Family Room (Max 4-5 Guests)</option>
                                </select>
                            </div>

                            <!-- Number of Rooms Input -->
                            <div class="mb-3">
                                <label class="form-label">Number of Rooms</label>
                                <input type="number" name="roomCount" class="form-control" value="1" min="1" required>
                            </div>

                            <!-- Number of Guests Input -->
                            <div class="mb-4">
                                <label class="form-label">Number of Guests</label>
                                <input type="number" name="guestCount" class="form-control" value="1" min="1" required>
                            </div>

                            <!-- Submit Button -->
                            <button type="submit" class="btn btn-pearltrails w-100 btn-lg py-2">Confirm Booking</button>
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