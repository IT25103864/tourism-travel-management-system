<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book ${transport.vehicleModel} - PearlTrails</title>
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

        /* Page Heading */
        .page-eyebrow {
            font-size: 0.85rem;
            font-weight: 700;
            letter-spacing: 0.14em;
            text-transform: uppercase;
            color: var(--transport-green);
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
        .form-control {
            border: 1.5px solid var(--border-soft);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 0.98rem;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }
        .form-control:focus {
            border-color: var(--transport-green);
            box-shadow: 0 0 0 3px rgba(47, 174, 102, 0.18);
        }

        /* Buttons (Gold Theme) */
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

                <div class="page-eyebrow">Vehicle Rental</div>
                <h2 class="fw-bold mb-1" style="font-family: 'Fraunces', serif; color: var(--ocean-blue); font-size: 2.2rem;">Rent ${transport.vehicleModel}</h2>
                <p class="page-subtext mb-4">Review your rental details and schedule your trip across Sri Lanka.</p>

                <div class="card booking-card">
                    <div class="booking-card-header">
                        <div class="transport-icon-badge"><i class="fa-solid fa-car"></i></div>
                        <div>
                            <h4>${transport.vehicleModel}</h4>
                            <p>Review your vehicle rental specifications.</p>
                        </div>
                    </div>
                    <div class="booking-card-body">
                        <!-- Form for transport booking submission -->
                        <form action="/book-transport" method="post">
                            <input type="hidden" name="transportId" value="${transport.id}">

                            <!-- Rental Start Date -->
                            <div class="mb-3">
                                <label class="form-label">Rental Start Date</label>
                                <input type="date" name="startDate" class="form-control" required>
                            </div>

                            <!-- Rental End Date -->
                            <div class="mb-3">
                                <label class="form-label">Rental End Date</label>
                                <input type="date" name="endDate" class="form-control" required>
                            </div>

                            <!-- Number of Passengers -->
                            <div class="mb-4">
                                <label class="form-label">Number of Passengers</label>
                                <input type="number" name="passengerCount" class="form-control" value="1" min="1" required>
                            </div>

                            <button type="submit" class="btn btn-pearltrails w-100 btn-lg py-2">Confirm Vehicle Rental</button>
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