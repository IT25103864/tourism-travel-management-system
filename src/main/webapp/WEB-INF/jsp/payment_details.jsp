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
    <title>Payment Details - PearlTrails</title>
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

        /* Card Styling */
        .checkout-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.08);
            overflow: hidden;
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
        }
        .form-control:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(201, 151, 63, 0.18);
        }
        .form-check-input:checked {
            background-color: var(--gold);
            border-color: var(--gold);
        }

        /* Submit Button (Gold Theme) */
        .btn-custom-pay {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            font-size: 1.1rem;
            border-radius: 999px;
            padding: 0.9rem;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 10px 22px -10px rgba(201, 151, 63, 0.6);
        }
        .btn-custom-pay:hover {
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
                <c:if test="${not empty sessionScope.loggedInUser}">
                    <a href="/my-bookings" class="text-white text-decoration-none small fw-bold">My Bookings</a>
                </c:if>
            </div>
        </div>
    </nav>

    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-xl-7">
                <div class="checkout-card p-4 p-md-5">
                    <h3 class="page-heading mb-2">Enter Payment Details</h3>
                    <p class="text-muted mb-4">Complete your reservation securely with your preferred payment option.</p>
                    <hr class="my-4" style="border-color: var(--border-soft);">

                    <form action="/process-payment" method="post">
                        <!-- Hidden parameters passed from checkout -->
                        <input type="hidden" name="packageId" value="${packageId}">
                        <input type="hidden" name="bookingId" value="${bookingId}">
                        <input type="hidden" name="transportBookingId" value="${transportBookingId}">
                        <input type="hidden" name="originalAmount" value="${originalAmount}">
                        <input type="hidden" name="discountAmount" value="${discountAmount}">
                        <input type="hidden" name="finalAmount" value="${finalAmount}">
                        <input type="hidden" name="promoCodeUsed" value="${promoCodeUsed}">

                        <!-- Personal Details Section -->
                        <h5 class="fw-bold mb-3" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);"><i class="fa-solid fa-user-check me-2 text-warning"></i>1. Personal Information</h5>
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="fullName" class="form-control" value="${loggedInUser.fullName}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone Number (For OTP Verification)</label>
                            <input type="text" name="phone" class="form-control" value="${loggedInUser.phone}" required placeholder="+94 77 123 4567">
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Email Address</label>
                            <input type="email" name="email" class="form-control" value="${loggedInUser.email}" required>
                        </div>

                        <hr class="my-4" style="border-color: var(--border-soft);">

                        <!-- Payment Method Section -->
                        <h5 class="fw-bold mb-3" style="font-family: 'Fraunces', serif; color: var(--ocean-blue);"><i class="fa-solid fa-credit-card me-2 text-warning"></i>2. Select Payment Method</h5>
                        <div class="mb-4 p-3 rounded-4" style="border: 1.5px solid var(--border-soft); background: var(--bg);">
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="cardMethod" value="Card" checked onclick="toggleCardDetails(true)">
                                <label class="form-check-label fw-semibold" for="cardMethod"><i class="fa-solid fa-credit-card text-success me-1"></i> Credit / Debit Card (Visa, MasterCard)</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="kokoMethod" value="Koko" onclick="toggleCardDetails(false)">
                                <label class="form-check-label fw-semibold" for="kokoMethod"><i class="fa-solid fa-wallet text-warning me-1"></i> Koko Pay-Later (Installments)</label>
                            </div>
                        </div>

                        <!-- Card Details Section (Shown when Card is selected) -->
                        <div id="cardDetailsSection" class="p-4 rounded-4 mb-4" style="border: 1.5px solid var(--border-soft); background: var(--bg);">
                            <h6 class="fw-bold mb-3" style="color: var(--ocean-blue);"><i class="fa-solid fa-id-card me-2 text-primary"></i>Card Information</h6>
                            <div class="mb-3">
                                <label class="form-label">Card Number</label>
                                <input type="text" name="cardNumber" id="cardNumberInput" class="form-control" placeholder="1234 5678 9012 3456" maxlength="19" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3 mb-md-0">
                                    <label class="form-label">Expiry Date</label>
                                    <input type="text" name="expiryDate" id="expiryInput" class="form-control" placeholder="MM/YY" maxlength="5" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">CVV / CVC</label>
                                    <input type="password" name="cvv" id="cvvInput" class="form-control" placeholder="123" maxlength="4" required>
                                </div>
                            </div>
                        </div>

                        <!-- Total Summary & Submit -->
                        <div class="d-flex justify-content-between align-items-center mb-4 p-3 rounded-4" style="border: 1.5px solid var(--border-soft); background: var(--bg);">
                            <span class="fs-5 fw-bold text-secondary">Total Payable:</span>
                            <span class="fs-3 fw-bold" style="color: var(--ocean-blue);">$${finalAmount}</span>
                        </div>

                        <button type="submit" class="btn btn-custom-pay w-100 shadow-sm"><i class="fa-solid fa-lock me-2"></i> Proceed to OTP Verification ($${finalAmount})</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript for card details visibility, auto-slash expiry date, and validation -->
    <script>
        function toggleCardDetails(show) {
            const cardSection = document.getElementById('cardDetailsSection');
            const cardInput = document.getElementById('cardNumberInput');
            const expiryInput = document.getElementById('expiryInput');
            const cvvInput = document.getElementById('cvvInput');

            if (show) {
                cardSection.style.display = 'block';
                cardInput.setAttribute('required', 'required');
                expiryInput.setAttribute('required', 'required');
                cvvInput.setAttribute('required', 'required');
            } else {
                cardSection.style.display = 'none';
                cardInput.removeAttribute('required');
                expiryInput.removeAttribute('required');
                cvvInput.removeAttribute('required');
            }
        }

        // Auto-format Expiry Date (MM/YY) with automatic slash insertion
        document.addEventListener("DOMContentLoaded", function () {
            const expiryInput = document.getElementById('expiryInput');
            if (expiryInput) {
                expiryInput.addEventListener('input', function (e) {
                    let value = e.target.value.replace(/\D/g, '');
                    if (value.length >= 3) {
                        e.target.value = value.substring(0, 2) + '/' + value.substring(2, 4);
                    } else {
                        e.target.value = value;
                    }
                });
            }
        });
    </script>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>