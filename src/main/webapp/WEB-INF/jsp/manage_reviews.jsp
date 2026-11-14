<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Reviews - PearlTrails Admin</title>
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
            --bg-body: #f8faf9;
            --card-white: #ffffff;
            --border-soft: #e3e9e8;
            --text-dark: #1f2d2c;
            --text-muted: #64777a;
        }

        body {
            background-color: var(--bg-body);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
            font-size: 1.05rem;
            line-height: 1.6;
        }

        .navbar-pearltrails-admin {
            background: linear-gradient(135deg, var(--ocean-blue), var(--teal-deep)) !important;
            padding: 1rem 1.5rem;
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.15);
        }
        .navbar-pearltrails-admin .navbar-brand {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 1.4rem;
            color: var(--gold) !important;
            letter-spacing: 0.02em;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            text-decoration: none;
        }

        .page-heading {
            font-family: 'Fraunces', serif;
            font-weight: 700;
            font-size: 2rem;
            color: var(--ocean-blue);
        }

        .admin-card {
            background: var(--card-white);
            border: 1.5px solid var(--border-soft);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(27, 58, 75, 0.05);
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

        .btn-approve {
            background-color: #2fae66;
            border: none;
            color: #ffffff;
            border-radius: 999px;
            font-weight: 600;
            padding: 0.35rem 0.9rem;
            font-size: 0.85rem;
        }
        .btn-approve:hover { opacity: 0.9; color: #ffffff; }

        .btn-reject {
            background-color: #f59e0b;
            border: none;
            color: #ffffff;
            border-radius: 999px;
            font-weight: 600;
            padding: 0.35rem 0.9rem;
            font-size: 0.85rem;
        }
        .btn-reject:hover { opacity: 0.9; color: #ffffff; }

        .btn-delete {
            background-color: #ef4444;
            border: none;
            color: #ffffff;
            border-radius: 999px;
            font-weight: 600;
            padding: 0.35rem 0.9rem;
            font-size: 0.85rem;
        }
        .btn-delete:hover { opacity: 0.9; color: #ffffff; }

        .btn-back {
            border: 1.5px solid var(--border-soft);
            color: var(--ocean-blue);
            background: var(--card-white);
            font-weight: 600;
            border-radius: 999px;
            padding: 0.6rem 1.5rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.15s ease;
        }
        .btn-back:hover {
            background: var(--ocean-blue);
            color: #ffffff;
            border-color: var(--ocean-blue);
        }
    </style>
</head>
<body>

    <jsp:include page="admin_navbar.jsp" />

    <div class="container mt-4 mb-5">
        <h2 class="page-heading mb-1">Manage All Reviews</h2>
        <p class="text-muted mb-4">View, approve, reject, or permanently delete tourist reviews.</p>

        <div class="card admin-card mb-4">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom align-middle">
                        <thead>
                            <tr>
                                <th class="ps-4">Review ID</th>
                                <th>Listing / Package</th>
                                <th>Tourist</th>
                                <th>Rating</th>
                                <th>Status</th>
                                <th>Comment</th>
                                <th class="text-center pe-4">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="review" items="${reviews}">
                                <tr>
                                    <td class="ps-4 fw-bold">#${review.reviewId}</td>
                                    <td class="fw-semibold">Listing #${review.listing.listingId}</td>
                                    <td>User #${review.tourist.userId}</td>
                                    <td>
                                        <span class="badge bg-warning text-dark fw-bold px-2 py-1"><i class="fa-solid fa-star me-1"></i> ${review.rating} / 5</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${review.status == 'Approved'}">
                                                <span class="badge bg-success px-2 py-1">Approved</span>
                                            </c:when>
                                            <c:when test="${review.status == 'Rejected'}">
                                                <span class="badge bg-danger px-2 py-1">Rejected</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary px-2 py-1">Pending</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-break text-secondary" style="max-width: 200px;">${review.comment}</td>
                                    <td class="text-center pe-4">
                                        <form action="/admin/reviews/approve" method="post" style="display:inline;">
                                            <input type="hidden" name="reviewId" value="${review.reviewId}">
                                            <button type="submit" class="btn btn-sm btn-approve me-1 shadow-sm" title="Approve"><i class="fa-solid fa-check"></i></button>
                                        </form>

                                        <form action="/admin/reviews/reject" method="post" style="display:inline;">
                                            <input type="hidden" name="reviewId" value="${review.reviewId}">
                                            <button type="submit" class="btn btn-sm btn-reject me-1 shadow-sm" title="Reject"><i class="fa-solid fa-xmark"></i></button>
                                        </form>

                                        <a href="/admin/reviews/delete?reviewId=${review.reviewId}" class="btn btn-sm btn-delete shadow-sm" title="Delete" onclick="return confirm('Are you sure you want to delete this review permanently?')">
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty reviews}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-5 fst-italic">No reviews found in the system.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <a href="/admin" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>