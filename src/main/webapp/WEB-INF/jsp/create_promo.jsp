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
    <title>Manage & Create Promo Codes - PearlTrails</title>
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
            font-size: 1.85rem;
            color: var(--ocean-blue);
        }

        /* Card Container */
        .promo-card {
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

        /* Submit Button (Gold Theme) */
        .btn-custom-submit {
            background: var(--gold);
            border: none;
            color: #1f2d2c;
            font-weight: 700;
            font-size: 1.05rem;
            border-radius: 999px;
            padding: 0.85rem;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 10px 22px -10px rgba(201, 151, 63, 0.6);
        }
        .btn-custom-submit:hover {
            background: var(--gold-light);
            transform: translateY(-1px);
            color: #1f2d2c;
            box-shadow: 0 14px 26px -10px rgba(201, 151, 63, 0.7);
        }

        /* Table Styling */
        .table th {
            background-color: rgba(27, 58, 75, 0.03);
            color: var(--ocean-blue);
            font-weight: 600;
            font-size: 0.92rem;
            border-bottom: 1.5px solid var(--border-soft);
            padding: 0.85rem;
        }
        .table td {
            padding: 0.85rem;
            color: var(--text-dark);
            border-bottom: 1px solid var(--border-soft);
            font-size: 0.92rem;
            vertical-align: middle;
        }

        /* Action Buttons */
        .btn-action-edit {
            background: rgba(201, 151, 63, 0.15);
            color: #9a7125;
            border: none;
            border-radius: 8px;
            padding: 0.35rem 0.75rem;
            font-weight: 600;
            font-size: 0.82rem;
            transition: all 0.15s ease;
            text-decoration: none;
        }
        .btn-action-edit:hover {
            background: var(--gold);
            color: #1f2d2c;
        }
        .btn-action-delete {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            border: none;
            border-radius: 8px;
            padding: 0.35rem 0.75rem;
            font-weight: 600;
            font-size: 0.82rem;
            transition: all 0.15s ease;
            text-decoration: none;
        }
        .btn-action-delete:hover {
            background: #dc3545;
            color: #ffffff;
        }
    </style>
</head>
<body>

    <!-- Admin Navbar Section -->
    <nav class="navbar navbar-pearltrails navbar-expand-lg sticky-top shadow-sm mb-4">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="/">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="PearlTrails Logo">
                <span>Pearl<span style="color: var(--gold);">Trails</span> <span class="fs-6 text-white-50 ms-2">| Admin</span></span>
            </a>
            <div class="d-flex align-items-center">
                <a href="/" class="text-white text-decoration-none small fw-bold me-3">Home</a>
                <a href="/logout" class="btn btn-outline-danger btn-sm px-3" style="width: auto !important;">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">

            <!-- Success Alert Notification -->
            <div class="col-lg-10">
                <c:if test="${param.success eq 'true'}">
                    <div class="alert alert-success alert-dismissible fade show rounded-4 py-3 mb-4 shadow-sm" role="alert">
                        <i class="fa-solid fa-circle-check me-2"></i> <strong>Success!</strong> Promo code has been processed successfully.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
            </div>

            <!-- Left / Top Column: Create / Edit Promo Code Form -->
            <div class="col-lg-5 mb-4 mb-lg-0">
                <div class="promo-card p-4 p-md-4 h-100">
                    <h3 class="page-heading mb-2">
                        <c:choose>
                            <c:when test="${not empty promoCode}">Edit Promo Code</c:when>
                            <c:otherwise>Create Promo Code</c:otherwise>
                        </c:choose>
                    </h3>
                    <p class="text-muted mb-4 small">
                        <c:choose>
                            <c:when test="${not empty promoCode}">Update existing discount offer details.</c:when>
                            <c:otherwise>Add a new discount offer for users.</c:otherwise>
                        </c:choose>
                    </p>
                    <hr class="my-3" style="border-color: var(--border-soft);">

                    <!-- Dynamic Form Action (Create vs Update) -->
                    <form action="${not empty promoCode ? '/admin/update-promo' : '/admin/create-promo'}" method="post">

                        <!-- Hidden ID field if editing -->
                        <c:if test="${not empty promoCode}">
                            <input type="hidden" name="promoId" value="${promoCode.promoId}">
                        </c:if>

                        <div class="mb-3">
                            <label class="form-label">Promo Code</label>
                            <input type="text" name="code" class="form-control" required value="${promoCode.code}" placeholder="e.g. SAVE10">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Discount Percentage (%)</label>
                            <input type="number" step="0.1" name="discountPercentage" class="form-control" required value="${promoCode.discountPercentage}" placeholder="e.g. 10">
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Description / Occasion</label>
                            <input type="text" name="description" class="form-control" required value="${promoCode.description}" placeholder="e.g., Weekend Deal">
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-custom-submit w-100 shadow-sm">
                                <i class="fa-solid ${not empty promoCode ? 'fa-pen-to-square' : 'fa-tag'} me-2"></i>
                                ${not empty promoCode ? 'Update Promo Code' : 'Save Promo Code'}
                            </button>
                            <c:if test="${not empty promoCode}">
                                <a href="/admin/create-promo" class="btn btn-outline-secondary rounded-pill px-4 fw-bold d-flex align-items-center">Cancel</a>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Right / Bottom Column: Existing Promo Codes List -->
            <div class="col-lg-7">
                <div class="promo-card p-4 p-md-4 h-100">
                    <h3 class="page-heading mb-2">Existing Promo Codes</h3>
                    <p class="text-muted mb-4 small">Manage, update, or remove active promo codes.</p>
                    <hr class="my-3" style="border-color: var(--border-soft);">

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Discount</th>
                                    <th>Description</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="promo" items="${promoCodes}">
                                    <tr>
                                        <td><span class="fw-bold font-monospace text-success bg-success bg-opacity-10 px-2 py-1 rounded">${promo.code}</span></td>
                                        <td><span class="fw-bold">${promo.discountPercentage}%</span></td>
                                        <td><span class="text-secondary small">${promo.description}</span></td>
                                        <td class="text-end">
                                            <!-- Edit Button links to same page with promoId -->
                                            <a href="/admin/edit-promo?id=${promo.promoId}" class="btn-action-edit me-1">
                                                <i class="fa-solid fa-pen-to-square"></i> Edit
                                            </a>
                                            <!-- Delete Button -->
                                            <a href="/admin/delete-promo?id=${promo.promoId}" class="btn-action-delete" onclick="return confirm('Are you sure you want to delete this promo code?');">
                                                <i class="fa-solid fa-trash-can"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty promoCodes}">
                                    <tr>
                                        <td colspan="4" class="text-center py-4">
                                            <span class="text-muted small font-monospace">No promo codes created yet.</span>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>