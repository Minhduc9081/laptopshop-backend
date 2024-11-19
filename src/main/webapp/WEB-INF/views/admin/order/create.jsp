<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

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

    <head>
        <title>Create New User</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .error {
                color: red;
                font-size: 0.9em;
                margin-top: 5px;
            }
        </style>
        <script>
            function previewImage(event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const preview = document.getElementById('imagePreview');
                        preview.src = e.target.result;
                        preview.style.display = 'block';
                    }
                    reader.readAsDataURL(file);
                }
            }

            function validateForm() {
                let isValid = true;
                const email = document.getElementById('email').value;
                const password = document.getElementById('password').value;

                // Reset previous error messages
                document.querySelectorAll('.error').forEach(el => el.remove());

                // Email validation
                if (!email) {
                    showError('email', 'Email is required');
                    isValid = false;
                } else if (!isValidEmail(email)) {
                    showError('email', 'Please enter a valid email address');
                    isValid = false;
                }

                // Password validation
                if (!password) {
                    showError('password', 'Password is required');
                    isValid = false;
                } else if (password.length < 6) {
                    showError('password', 'Password must be at least 6 characters long');
                    isValid = false;
                }

                return isValid;
            }

            function isValidEmail(email) {
                const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return regex.test(email);
            }

            function showError(fieldId, message) {
                const field = document.getElementById(fieldId);
                const errorDiv = document.createElement('div');
                errorDiv.className = 'error';
                errorDiv.innerHTML = message;
                field.parentNode.appendChild(errorDiv);
            }
        </script>
    </head>

</head>

<body>
<jsp:include page="../layouts/header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="../layouts/sidebar.jsp"/>
    <div id="layoutSidenav_content">
        <main>
            <div class="page-header">
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Create User</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">User</li>
                    </ol>
                </div>
            </div>
            <div class="container-fluid px-4">
                <div class="" id="createUserModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form id="createForm" action="/admin/order/create" method="post" enctype="multipart/form-data" modelAttribute="user">
                            <div class="modal-body">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="price" class="form-label">Price</label>
                                        <input type="text" id="price" name="price" class="form-control" required>
                                    </div>

                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save me-1"></i>Create User
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            </div>
        </main>
    </div>
<!-- Bootstrap JS and dependencies -->

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="/js/chart-area-demo.js"></script>
        <script src="/js/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
</body>

</html>