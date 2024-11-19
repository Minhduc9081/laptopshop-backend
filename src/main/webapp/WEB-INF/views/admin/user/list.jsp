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
</head>
<body class="sb-nav-fixed">
<%--<body>--%>
<%--<div class="container mt-5">--%>
<%--    <h2>User List</h2>--%>
<%--    <a href="/admin/users/create" class="btn btn-primary mb-3">Add New User</a>--%>
<%--    <table class="table">--%>
<%--        <thead>--%>
<%--        <tr>--%>
<%--            <th>ID</th>--%>
<%--            <th>Image</th>--%>
<%--            <th>Email</th>--%>
<%--            <th>Role</th>--%>
<%--            <th>Actions</th>--%>
<%--        </tr>--%>
<%--        </thead>--%>
<%--        <tbody>--%>
<%--        <c:forEach var="user" items="${users}">--%>
<%--            <tr>--%>
<%--                <td>${user.id}</td>--%>
<%--                <td>--%>
<%--                    <c:if test="${not empty user.imagePath}">--%>
<%--                        <img src="/resources/images/avatar/${user.imagePath}" alt="User Image"--%>
<%--                             style="width: 50px; height: 50px;">--%>
<%--                    </c:if>--%>
<%--                </td>--%>
<%--                <td>${user.email}</td>--%>
<%--                <td>${user.role}</td>--%>
<%--                <td>--%>
<%--                    <a href="/admin/users/edit/${user.id}" class="btn btn-warning btn-sm">Edit</a>--%>
<%--                    <form action="/users/delete/${user.id}" method="post" style="display: inline;">--%>
<%--                        <button type="submit" class="btn btn-danger btn-sm"--%>
<%--                                onclick="return confirm('Are you sure you want to delete this user?')">Delete</button>--%>
<%--                    </form>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--        </c:forEach>--%>
<%--        </tbody>--%>
<%--    </table>--%>
<%--</div>--%>
<%--</body>--%>
<jsp:include page="../layouts/header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="../layouts/sidebar.jsp"/>
    <div id="layoutSidenav_content">
        <main>
            <div class="page-header">
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Manage User</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">User</li>
                    </ol>
                </div>
            </div>
            <div class="container-fluid px-4">
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Users List</h5>
                        <a href="/admin/users/create" type="button" class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i>Create User
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Email</th>
                                    <th scope="col">Phone number</th>
                                    <th scope="col">Full Name</th>
                                    <th scope="col">Address</th>
                                    <th scope="col">Role</th>
                                    <th scope="col" class="text-center">Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="user" items="${users}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${user.email}</td>
                                        <td>${user.phone}</td>
                                        <td>${user.fullName}</td>
                                        <td>${user.address}</td>
                                        <td>${user.role}</td>
                                        <td>
                                            <div class="d-flex justify-content-center action-buttons">
                                                <a href="/admin/users/view/${user.id}" class="btn btn-primary btn-sm me-2">
                                                    <i class="fas fa-eye me-1"></i>View
                                                </a>
                                                <a href="/admin/users/edit/${user.id}" class="btn btn-primary btn-sm me-2">
                                                    <i class="fas fa-eye me-1"></i>Edit
                                                </a>
                                                <form action="/admin/users/delete/${user.id}" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
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
        </main>
        <jsp:include page="../layouts/footer.jsp"/>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="/js/chart-area-demo.js"></script>
<script src="/js/chart-bar-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="js/datatables-simple-demo.js"></script>
</body>
</html>


