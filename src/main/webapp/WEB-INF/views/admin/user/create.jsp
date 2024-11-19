<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Create New User - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .form-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 2rem;
            margin: 20px auto;
            max-width: 900px;
        }
        .preview-container {
            position: relative;
            width: 200px;
            height: 200px;
            margin: 20px auto;
            border-radius: 10px;
            overflow: hidden;
            background: #f8f9fa;
            border: 2px dashed #dee2e6;
        }
        .preview-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .preview-placeholder {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            color: #6c757d;
        }
        .preview-placeholder i {
            font-size: 3rem;
            margin-bottom: 10px;
        }
        .form-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        .section-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #495057;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .form-label {
            font-weight: 500;
            color: #495057;
        }
        .form-control, .form-select {
            border: 1px solid #ced4da;
            padding: 0.5rem 0.75rem;
            border-radius: 6px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 0.25rem rgba(13,110,253,.25);
        }
        .error {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        .required-field::after {
            content: '*';
            color: #dc3545;
            margin-left: 4px;
        }
        .btn-toolbar {
            padding-top: 1rem;
            border-top: 1px solid #dee2e6;
            margin-top: 2rem;
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
                <h1 class="mt-4">Create New User</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/users">Users</a></li>
                    <li class="breadcrumb-item active">Create User</li>
                </ol>

                <div class="form-container">
                    <%--@elvariable id="user" type=""--%>
                    <form:form id="createForm" action="/admin/users/create" method="post"
                               enctype="multipart/form-data" modelAttribute="user">

                        <!-- Profile Image Section -->
                        <div class="form-section">
                            <div class="section-title">
                                <i class="fas fa-image"></i> Profile Image
                            </div>
                            <div class="preview-container">
                                <img id="imagePreview" src="#" alt="Profile Preview" style="display: none;">
                                <div class="preview-placeholder">
                                    <i class="fas fa-user"></i>
                                    <p>Click to upload image</p>
                                </div>
                            </div>
                            <div class="mb-3">
                                <input type="file" class="form-control" id="image" name="image"
                                       accept="image/*" onchange="previewImage(event)">
                                <div class="form-text">Accepted formats: JPG, PNG. Max size: 5MB</div>
                            </div>
                        </div>

                        <!-- Basic Information Section -->
                        <div class="form-section">
                            <div class="section-title">
                                <i class="fas fa-user"></i> Basic Information
                            </div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="fullName" class="form-label required-field">Full Name</label>
                                    <input type="text" id="fullName" name="fullName" class="form-control"
                                           required placeholder="Enter full name" value="${user.fullName}">
                                    <c:if test="${not empty errors.fullName}">
                                        <div class="text-danger">${errors.fullName[0]}</div>
                                    </c:if>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label required-field">Email</label>
                                    <input type="email" id="email" name="email" class="form-control"
                                           placeholder="Enter email address" value="${user.email}">
                                    <c:if test="${not empty errors.email}">
                                        <div class="text-danger">${errors.email[0]}</div>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!-- Contact Information Section -->
                        <div class="form-section">
                            <div class="section-title">
                                <i class="fas fa-address-card"></i> Contact Information
                            </div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="phone" class="form-label required-field">Phone Number</label>
                                    <input type="tel" id="phone" name="phone" class="form-control"
                                           required placeholder="Enter phone number" value="${user.phone}">
                                    <c:if test="${not empty errors.phone}">
                                        <div class="text-danger">${errors.phone[0]}</div>
                                    </c:if>
                                </div>
                                <div class="col-md-6">
                                    <label for="address" class="form-label required-field">Address</label>
                                    <input type="text" id="address" name="address" class="form-control"
                                           required placeholder="Enter address" value="${user.address}">
                                    <c:if test="${not empty errors.address}">
                                        <div class="text-danger">${errors.address[0]}</div>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!-- Account Settings Section -->
                        <div class="form-section">
                            <div class="section-title">
                                <i class="fas fa-lock"></i> Account Settings
                            </div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="password" class="form-label required-field">Password</label>
                                    <input type="password" id="password" name="password" class="form-control"
                                           required placeholder="Enter password">
                                    <c:if test="${not empty errors.password}">
                                        <div class="text-danger">${errors.password[0]}</div>
                                    </c:if>
                                    <div class="form-text">Minimum 6 characters</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="role" class="form-label required-field">Role</label>
                                    <select class="form-select" id="role" name="role" required>
                                        <option value="">Select role</option>
                                        <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>User</option>
                                        <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                    </select>
                                    <c:if test="${not empty errors.role}">
                                        <div class="text-danger">${errors.role[0]}</div>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="btn-toolbar justify-content-end gap-2">
                            <a href="/admin/users" class="btn btn-secondary">
                                <i class="fas fa-times me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-user-plus me-1"></i>Create User
                            </button>
                        </div>
                    </form:form>
                </div>

            </div>
        </main>
        <jsp:include page="../layouts/footer.jsp"/>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
<script>
    function previewImage(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const preview = document.getElementById('imagePreview');
                preview.src = e.target.result;
                preview.style.display = 'block';
                document.querySelector('.preview-placeholder').style.display = 'none';
            }
            reader.readAsDataURL(file);
        }
    }
</script>
</body>
</html>