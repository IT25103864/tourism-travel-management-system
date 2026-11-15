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
    <title>My Bookings - PearlTrails</title>
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

        /* Card & Table Styling */
        .admin-card {
            background: var(--card-bg);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(27, 58, 75, 0.08);
            overflow: hidden;
        }
        .table-custom {
            margin-bottom: 0;
            vertical-align: middle;
        }
        .table-custom th {
            background-color: var(--ocean-blue);
            color: #ffffff;
            font-family: 'Fraunces', serif;
            font-weight: 600;
            font-size: 1.05rem;
            padding: 1rem 1.25rem;
            border: none;
        }
        .table-custom td {
            padding: 1rem 1.25rem;
            color: var(--text-dark);
            border-bottom: 1px solid var(--border-soft);
        }
        .table-custom tbody tr:hover {
            background-color: rgba(27, 58, 75, 0.02);
        }

        /* Buttons (Gold Theme) */
        .btn-custom-main {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            font-size: 0.95rem;
            border-radius: 999px;
            padding: 0.4rem 1.25rem;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 8px 18px -8px rgba(201, 151, 63, 0.6);
        }
        .btn-custom-main:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
        }
        .btn-explore {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            border-radius: 999px;
            padding: 0.75rem 2rem;
            transition: all 0.15s ease;
            box-shadow: 0 10px 22px -10px rgba(201, 151, 63, 0.6);
        }
        .btn-explore:hover {
            background: var(--gold-light);
            color: #1f2d2c;
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
                <a href="/logout" class="btn btn-outline-danger btn-sm px-3" style="width: auto !important;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4 mb-5">

        <!-- Success/Alert Popups -->
        <c:if test="${param.paymentSuccess eq 'true'}">
            <div class="alert alert-success alert-dismissible fade show rounded-4 p-3 shadow-sm mb-4" role="alert">
                <strong><i class="fa-solid fa-circle-check me-1"></i> Payment Successful!</strong> Your payment has been confirmed and a confirmation email has been sent.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${param.cancelled eq 'true'}">
            <div class="alert alert-warning alert-dismissible fade show rounded-4 p-3 shadow-sm mb-4" role="alert">
                <strong><i class="fa-solid fa-triangle-exclamation me-1"></i> Booking Cancelled!</strong> Your booking has been successfully cancelled.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <h2 class="page-heading mb-1">My Bookings</h2>
        <p class="text-muted mb-4">Manage your hotel reservations and track their payment statuses.</p>

        <div class="card admin-card mb-5">
            <div class="card-body p-0">
                <c:if test="${empty bookings}">
                    <div class="text-center py-5 px-3">
                        <h5 class="text-muted mb-3">You haven't booked any places yet.</h5>
                        <a href="/" class="btn btn-explore">Explore Places</a>
                    </div>
                </c:if>

                <c:if test="${not empty bookings}">
                    <div class="table-responsive">
                        <table class="table table-custom align-middle">
                            <thead>
                                <tr>
                                    <th class="ps-4">Booking ID</th>
                                    <th>Place</th>
                                    <th>Location</th>
                                    <th>Check-in</th>
                                    <th>Check-out</th>
                                    <th>Total Amount</th>
                                    <th>Status</th>
                                    <th class="text-center pe-4">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="booking" items="${bookings}">
                                    <tr>
                                        <td class="ps-4 fw-bold">#${booking.bookingId}</td>
                                        <td class="fw-bold" style="color: var(--ocean-blue);">${booking.listing.title}</td>
                                        <td><i class="fa-solid fa-location-dot text-danger me-1"></i>${booking.listing.location}</td>
                                        <td>${booking.checkInDate}</td>
                                        <td>${booking.checkOutDate}</td>
                                        <td class="fw-bold text-success">$${booking.totalAmount}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${booking.status eq 'Paid'}">
                                                    <span class="badge bg-success px-3 py-1.5 rounded-pill fw-bold"><i class="fa-solid fa-circle-check me-1"></i> Paid</span>
                                                </c:when>
                                                <c:when test="${booking.status eq 'Cancelled'}">
                                                    <span class="badge bg-secondary px-3 py-1.5 rounded-pill fw-bold">Cancelled</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning text-dark px-3 py-1.5 rounded-pill fw-bold">${booking.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center pe-4">
                                            <c:choose>
                                                <c:when test="${booking.status eq 'Paid'}">
                                                    <span class="text-muted small fst-italic">Completed</span>
                                                </c:when>
                                                <c:when test="${booking.status eq 'Cancelled'}">
                                                    <span class="text-muted small fst-italic">N/A</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/checkout-booking?bookingId=${booking.bookingId}" class="btn btn-sm btn-custom-main mb-1 shadow-sm">Pay Now</a>
                                                    <a href="${pageContext.request.contextPath}/cancel-booking?id=${booking.bookingId}" class="btn btn-sm btn-outline-danger mb-1 rounded-pill px-3" onclick="return confirm('Are you sure you want to cancel this booking?');">Cancel</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Section for Transport Bookings -->
        <h3 class="page-heading mb-1" style="font-size: 1.6rem;">My Vehicle Bookings</h3>
        <p class="text-muted mb-4">Track your reserved transport services and vehicle rentals.</p>

        <div class="card admin-card">
            <div class="card-body p-0">
                <c:if test="${empty transportBookings}">
                    <div class="text-center py-5 px-3">
                        <p class="text-muted fst-italic mb-0">You have no vehicle bookings yet.</p>
                    </div>
                </c:if>

                <c:if test="${not empty transportBookings}">
                    <div class="table-responsive">
                        <table class="table table-custom align-middle">
                            <thead>
                                <tr>
                                    <th class="ps-4">Booking ID</th>
                                    <th>Vehicle Model</th>
                                    <th>Type</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Passengers</th>
                                    <th>Total Amount</th>
                                    <th>Status</th>
                                    <th class="text-center pe-4">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="tb" items="${transportBookings}">
                                    <tr>
                                        <td class="ps-4">#${tb.id}</td>
                                        <td class="fw-bold" style="color: var(--ocean-blue);">${tb.transport.vehicleModel}</td>
                                        <td>${tb.transport.vehicleType}</td>
                                        <td>${tb.startDate}</td>
                                        <td>${tb.endDate}</td>
                                        <td>${tb.passengerCount}</td>
                                        <td class="text-success fw-bold">$${tb.totalAmount}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${tb.status eq 'Paid'}">
                                                    <span class="badge bg-success px-3 py-1.5 rounded-pill fw-bold"><i class="fa-solid fa-circle-check me-1"></i> Paid</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning text-dark px-3 py-1.5 rounded-pill fw-bold">${tb.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center pe-4">
                                            <c:choose>
                                                <c:when test="${tb.status eq 'Paid'}">
                                                    <span class="text-muted small fst-italic">Completed</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/checkout-transport?transportBookingId=${tb.id}" class="btn btn-sm btn-custom-main shadow-sm">Pay Now</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>

    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>