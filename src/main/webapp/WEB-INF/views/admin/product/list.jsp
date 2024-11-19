<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Dashboard - SB Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .profile-section {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .user-avatar-container {
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
            width: 200px;
            height: 200px;
            margin: 0 auto 2rem;
        }
        .user-avatar {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #007bff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .user-info-item {
            margin-bottom: 1.5rem;
        }
        .info-label {
            font-weight: 600;
            color: #6c757d;
            margin-bottom: 0.5rem;
        }
        .info-value {
            font-size: 1.1rem;
            color: #212529;
            padding: 0.5rem;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .role-badge {
            background-color: #007bff;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            display: inline-block;
        }
        .no-image-placeholder {
            width: 100%;
            height: 100%;
            background-color: #f8f9fa;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: #6c757d;
        }
    </style>
</head>
<body class="sb-nav-fixed">
<jsp:include page="../layouts/header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="../layouts/sidebar.jsp"/>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Manager Product</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Product</li>
                </ol>
                <div class="container-fluid px-4">
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Products List</h5>
                            <a href="/admin/products/create" type="button" class="btn btn-primary">
                                <i class="fas fa-plus me-2"></i>Create Product
                            </a>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Price</th>
                                        <th scope="col">Manufacture</th>
                                        <th scope="col">Description</th>
                                        <th scope="col" class="text-center">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="product" items="${products}" varStatus="status">
                                        <tr>
                                            <td>${status.index + 1}</td>
                                            <td>${product.name}</td>
                                            <td>${product.price}</td>
                                            <td>${product.manufacture}</td>
                                            <td>${product.shortDescription}</td>
                                            <td>
                                                <div class="d-flex justify-content-center action-buttons">
                                                    <a href="/admin/products/view/${product.id}" class="btn btn-primary btn-sm me-2">
                                                        <i class="fas fa-eye me-1"></i>View
                                                    </a>
                                                    <a href="/admin/products/edit/${product.id}" class="btn btn-primary btn-sm me-2">
                                                        <i class="fas fa-eye me-1"></i>Edit
                                                    </a>
                                                    <form action="/admin/products/delete/${product.id}" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                                        <button type="submit" class="btn btn-danger btn-sm">
                                                            <i class="fas fa-trash-alt me-1"></i>Delete
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layouts/footer.jsp"/>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
</body>
</html>


