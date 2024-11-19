<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit User - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .edit-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        .edit-card-header {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 15px 15px 0 0;
            border-bottom: 1px solid #dee2e6;
        }
        .edit-card-body {
            padding: 2rem;
        }
        .image-preview-container {
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
        }
        .image-preview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #007bff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin: 0 auto;
        }
        .image-upload-wrapper {
            position: relative;
            margin: 1rem auto;
            max-width: 300px;
        }
        .custom-file-upload {
            border: 2px dashed #007bff;
            border-radius: 10px;
            padding: 1rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
        }
        .custom-file-upload:hover {
            background-color: #f8f9fa;
            border-color: #0056b3;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.5rem;
        }
        .form-control {
            border-radius: 8px;
            padding: 0.75rem 1rem;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
        }
        .password-wrapper {
            position: relative;
        }
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
        }
        .btn-group {
            margin-top: 2rem;
        }
        .btn {
            padding: 0.75rem 1.5rem;
            font-weight: 500;
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
                <h1 class="mt-4">Edit User</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/users">Users</a></li>
                    <li class="breadcrumb-item active">Edit Product</li>
                </ol>

                <div class="row">
                    <div class="col-xl-12">
                        <div class="edit-card">
                            <div class="edit-card-header">
                                <i class="fas fa-user-edit me-2"></i>
                                User Information
                            </div>
                            <div class="edit-card-body">
                                <form action="/admin/users/edit/${user.id}" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="id" value="${user.id}">

                                    <div class="row justify-content-center">
                                        <div class="col-md-4">
                                            <div class="image-preview-container">
                                                <c:choose>
                                                    <c:when test="${not empty user.imagePath}">
                                                        <img id="currentImage"
                                                             src="/resources/images/avatar/${user.imagePath}"
                                                             alt="Current Profile"
                                                             class="image-preview">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="image-preview d-flex align-items-center justify-content-center bg-light">
                                                            <i class="fas fa-user fa-4x text-secondary"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <img id="newPreview" src="#" alt="New Preview"
                                                     class="image-preview" style="display:none;">

                                                <div class="image-upload-wrapper mt-3">
                                                    <label for="imageInput" class="custom-file-upload w-100">
                                                        <i class="fas fa-cloud-upload-alt"></i>
                                                        <span class="ms-2">Upload new image</span>
                                                    </label>
                                                    <input id="imageInput" type="file" name="image"
                                                           class="form-control d-none"
                                                           onchange="previewImage(event)"
                                                           accept="image/*">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-8">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="form-label">Email Address</label>
                                                        <input type="email" name="email" value="${user.email}"
                                                               class="form-control" required>
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="form-label">Full Name</label>
                                                        <input type="text" name="fullName" value="${user.fullName}"
                                                               class="form-control" required>
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="form-label">Phone Number</label>
                                                        <input type="tel" name="phone" value="${user.phone}"
                                                               class="form-control" required>
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="form-label">Role</label>
                                                        <select name="role" class="form-control">
                                                            <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>User</option>
                                                            <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <div class="form-group">
                                                        <label class="form-label">Address</label>
                                                        <textarea name="address" class="form-control"
                                                                  rows="3">${user.address}</textarea>
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <div class="form-group">
                                                        <label class="form-label">Password</label>
                                                        <div class="password-wrapper">
                                                            <input type="password" name="password" id="password"
                                                                   class="form-control"
                                                                   placeholder="Leave blank to keep current password">
                                                            <i class="fas fa-eye password-toggle"
                                                               onclick="togglePassword()"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mt-4">
                                        <div class="col-12 text-end">
                                            <a href="/admin/users" class="btn btn-secondary me-2">
                                                <i class="fas fa-times me-2"></i>Cancel
                                            </a>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-save me-2"></i>Save Changes
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
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
        const reader = new FileReader();
        reader.onload = function() {
            const currentImage = document.getElementById('currentImage');
            const newPreview = document.getElementById('newPreview');
            if (currentImage) currentImage.style.display = 'none';
            newPreview.src = reader.result;
            newPreview.style.display = 'block';
        };
        reader.readAsDataURL(event.target.files[0]);
    }

    function togglePassword() {
        const passwordInput = document.getElementById('password');
        const toggleIcon = document.querySelector('.password-toggle');
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleIcon.classList.remove('fa-eye');
            toggleIcon.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            toggleIcon.classList.remove('fa-eye-slash');
            toggleIcon.classList.add('fa-eye');
        }
    }
</script>
</body>
</html>