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
    <title>Vehicle Rental Checkout - PearlTrails</title>
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
            --orange: #e08a1e;
            --orange-soft: #fdefdc;
            --green: #2fae66;
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

        .page-eyebrow {
            font-size: 0.85rem;
            font-weight: 700;
            letter-spacing: 0.14em;
            text-transform: uppercase;
            color: var(--orange);
            margin-bottom: 0.35rem;
        }

        /* Checkout Card */
        .checkout-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.1);
            border-top: 4px solid var(--orange);
            overflow: hidden;
        }
        .checkout-card-body {
            padding: 2.5rem;
        }
        .checkout-title {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 1.8rem;
            color: var(--ocean-blue);
        }

        /* Promo Form */
        .form-label {
            font-weight: 600;
            font-size: 0.92rem;
            color: var(--ocean-blue);
        }
        .form-control {
            border: 1.5px solid var(--border-soft);
            border-radius: 12px 0 0 12px;
            padding: 0.75rem 1rem;
            font-size: 0.98rem;
        }
        .form-control:focus {
            border-color: var(--orange);
            box-shadow: 0 0 0 3px rgba(224, 138, 30, 0.18);
        }
        .btn-apply-promo {
            border: 1.5px solid var(--orange);
            color: var(--orange);
            font-weight: 700;
            background: #ffffff;
            border-radius: 0 12px 12px 0;
            padding: 0 1.25rem;
            transition: background 0.15s ease, color 0.15s ease;
        }
        .btn-apply-promo:hover {
            background: var(--orange);
            color: #ffffff;
        }

        .divider-soft {
            border: none;
            border-top: 1px solid var(--border-soft);
            margin: 1.8rem 0;
        }

        /* Price Breakdown Box */
        .price-breakdown-box {
            background: var(--bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 16px;
            padding: 1.5rem;
        }
        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            font-size: 1.02rem;
        }
        .price-row .label {
            color: var(--text-muted);
        }
        .price-row .value {
            font-weight: 700;
            color: var(--ocean-blue);
        }
        .price-row .value.discount {
            color: var(--green);
        }
        .price-row.final {
            border-top: 1.5px dashed var(--border-soft);
            padding-top: 1rem;
            margin-top: 0.6rem;
            align-items: center;
        }
        .price-row.final .label {
            font-family: 'Fraunces', serif;
            font-weight: 600;
            font-size: 1.15rem;
            color: var(--ocean-blue);
        }
        .price-row.final .value {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 1.8rem;
            color: var(--green);
        }

        /* Action Buttons */
        .btn-pay {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            font-size: 1.05rem;
            border-radius: 999px;
            padding: 0.85rem 2.2rem;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 10px 22px -10px rgba(201, 151, 63, 0.6);
        }
        .btn-pay:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
            box-shadow: 0 14px 26px -10px rgba(201, 151, 63, 0.7);
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
                <a href="/" class="text-white text-decoration-none small fw-bold me-3">Home</a>
                <a href="/my-bookings" class="text-white text-decoration-none small fw-bold">My Bookings</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-7">

                <div class="page-eyebrow">Checkout &amp; Payment</div>

                <div class="card checkout-card">
                    <div class="checkout-card-body">
                        <h3 class="checkout-title mb-3">Vehicle Rental Checkout</h3>
                        <hr class="divider-soft">

                        <!-- Transport Booking Summary -->
                        <div class="mb-4">
                            <h5 class="fw-bold mb-3" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);">Rental Summary</h5>
                            <p class="mb-2"><strong style="color: var(--ocean-blue);">Vehicle Model:</strong> ${transportBooking.transport.vehicleModel}</p>
                            <p class="mb-2"><strong style="color: var(--ocean-blue);">Vehicle Type:</strong> ${transportBooking.transport.vehicleType}</p>
                            <p class="mb-2"><strong style="color: var(--ocean-blue);">Number Plate:</strong> ${transportBooking.transport.numberPlate}</p>
                            <p class="mb-2"><strong style="color: var(--ocean-blue);">Start Date:</strong> ${transportBooking.startDate} | <strong style="color: var(--ocean-blue);">End Date:</strong> ${transportBooking.endDate}</p>
                            <p class="mb-0"><strong style="color: var(--ocean-blue);">Passengers:</strong> ${transportBooking.passengerCount}</p>
                        </div>

                        <!-- Promo Code Form -->
                        <form action="/checkout-transport" method="get" class="mb-4">
                            <input type="hidden" name="transportBookingId" value="${transportBooking.id}">
                            <label class="form-label mb-2">Have a Promo Code?</label>
                            <div class="input-group">
                                <input type="text" name="promoCode" class="form-control" value="${param.promoCode}" placeholder="Enter promo code (e.g. SAVE10)">
                                <button type="submit" class="btn-apply-promo">Apply</button>
                            </div>
                            <c:if test="${not empty promoMessage}">
                                <div class="text-success small mt-2 fw-semibold"><i class="fa-solid fa-circle-check me-1"></i>${promoMessage}</div>
                            </c:if>
                            <c:if test="${not empty promoError}">
                                <div class="text-danger small mt-2 fw-semibold"><i class="fa-solid fa-circle-exclamation me-1"></i>${promoError}</div>
                            </c:if>
                        </form>

                        <!-- Price Breakdown -->
                        <div class="price-breakdown-box mb-4">
                            <div class="price-row">
                                <span class="label">Original Amount</span>
                                <span class="value">$${originalAmount}</span>
                            </div>
                            <div class="price-row">
                                <span class="label">Discount</span>
                                <span class="value discount">-$${discountAmount}</span>
                            </div>
                            <div class="price-row final">
                                <span class="label">Final Total</span>
                                <span class="value">$${finalAmount}</span>
                            </div>
                        </div>

                        <!-- Proceed to Payment Details Form -->
                        <form action="/payment-details" method="get">
                            <input type="hidden" name="transportBookingId" value="${transportBooking.id}">
                            <input type="hidden" name="finalAmount" value="${finalAmount}">

                            <button type="submit" class="btn btn-pay w-100 py-3 fw-bold fs-5 shadow-sm">Proceed to Payment Details</button>
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