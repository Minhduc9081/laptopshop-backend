<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>User Profile - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
                <h1 class="mt-4">Order Profile</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Order Profile</li>
                </ol>

                <div class="profile-section">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="user-info-item">
                                <div class="info-label">Price</div>
                                <div class="info-value">${order.price}</div>
                            </div>
                        </div>

                    <div class="text-center mt-4">
                        <a href="/admin/order" class="btn btn-secondary me-2">Back to Order List</a>
                        <a href="/admin/order/edit/${order.id}" class="btn btn-primary">Order Profile</a>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layouts/footer.jsp"/>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
</body>
</html>