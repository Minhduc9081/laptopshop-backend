<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Minh Đức - Dự án laptopshop" />
    <meta name="author" content="Minh Đức" />
    <title>Dashboard - SB Admin</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .card {
            box-shadow: 0 0.15rem 1.75rem 0 rgb(33 40 50 / 15%);
        }
        .table > :not(caption) > * > * {
            padding: 1rem;
        }
        .action-buttons .btn {
            margin: 0 0.25rem;
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
        }
        .btn-view {
            background-color: #0dcaf0;
            border-color: #0dcaf0;
        }
        .btn-edit {
            background-color: #ffc107;
            border-color: #ffc107;
        }
        .btn-delete {
            background-color: #dc3545;
            border-color: #dc3545;
        }
        .page-header {
            padding: 1.5rem 0;
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
            margin-bottom: 2rem;
        }
        .avatar-preview {
            max-width: 150px;
            margin: 1rem auto;
            border-radius: 5px;
        }
        .modal-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }
        .modal-footer {
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
        }
    </style>
</head>

<body class="sb-nav-fixed">
<jsp:include page="../layouts/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layouts/sidebar.jsp" />
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
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createUserModal">
                            <i class="fas fa-plus me-2"></i>Create User
                        </button>
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
                                        <td>
                                            <div class="d-flex justify-content-center action-buttons">
                                                <button type="button" class="btn btn-view text-white"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#viewUserModal"
                                                        data-email="${user.email}"
                                                        data-phone="${user.phone}"
                                                        data-fullname="${user.fullName}"
                                                        data-address="${user.address}"
                                                        data-role="${user.role.name}"
                                                        data-avatar="<c:url value='/resources/images/avatar/${user.avatar}'/>">
                                                    <i class="fas fa-eye me-1"></i>View
                                                </button>
                                                <button type="button" class="btn btn-edit" data-bs-toggle="modal"
                                                        data-bs-target="#editUserModal" data-id="${user.id}"
                                                        data-email="${user.email}" data-phone="${user.phone}"
                                                        data-fullname="${user.fullName}" data-address="${user.address}"
                                                        data-role="${user.role}" data-avatar="${user.avatar}>
                                                    <i class="fas fa-edit me-1"></i>Edit
                                                </button>
                                                <form action="/admin/user/delete/${user.id}" method="post"
                                                      style="display: inline;"
                                                      onsubmit="return confirm('Are you sure you want to delete this user?');">
                                                    <button type="submit" class="btn btn-delete text-white">
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

            <!-- Create User Modal -->
            <div class="modal fade" id="createUserModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Create New User</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form id="createForm" action="/admin/user/create" method="post" enctype="multipart/form-data" modelAttribute="user">
                            <div class="modal-body">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" id="email" name="email" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="phone" class="form-label">Phone number</label>
                                        <input type="text" id="phone" name="phone" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="password" class="form-label">Password</label>
                                        <input type="password" id="password" name="password" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="fullName" class="form-label">Full Name</label>
                                        <input type="text" id="fullName" name="fullName" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="address" class="form-label">Address</label>
                                        <input type="text" id="address" name="address" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Role</label>
                                        <select name="role" class="form-select" required>
                                            <option value="">Select role</option>
                                            <c:forEach items="${roles}" var="role">
                                                <option value="${role.id}">${role.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <label for="avatarFile" class="form-label">Avatar</label>
                                        <input class="form-control" type="file" id="avatarFile"
                                               accept=".png, .jpg, .jpeg" name="avatarFile">
                                    </div>
                                    <div class="col-12 text-center">
                                        <img class="avatar-preview" src="" alt="avatar preview" id="avatarPreview">
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

            <!-- Edit User Modal -->
            <div class="modal fade" id="editUserModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit User</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form id="editForm" method="post" action="/admin/user/update/${user.id}">
                            <div class="modal-body">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="editEmail" class="form-label">Email</label>
                                        <input type="email" id="editEmail" name="email" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="editPhone" class="form-label">Phone number</label>
                                        <input type="text" id="editPhone" name="phone" class="form-control" required>
                                    </div>
                                    <div class="col-12">
                                        <label for="editFullName" class="form-label">Full Name</label>
                                        <input type="text" id="editFullName" name="fullName" class="form-control" required>
                                    </div>
                                    <div class="col-12">
                                        <label for="editAddress" class="form-label">Address</label>
                                        <input type="text" id="editAddress" name="address" class="form-control" required>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save me-1"></i>Update User
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- View User Modal -->
            <div class="modal fade" id="viewUserModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">User Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <p class="mb-1"><strong>Email:</strong></p>
                                    <p class="text-muted" id="viewEmail"></p>
                                </div>
                                <div class="col-md-6">
                                    <p class="mb-1"><strong>Phone:</strong></p>
                                    <p class="text-muted" id="viewPhone"></p>
                                </div>
                                <div class="col-md-6">
                                    <p class="mb-1"><strong>Full Name:</strong></p>
                                    <p class="text-muted" id="viewFullName"></p>
                                </div>
                                <div class="col-md-6">
                                    <p class="mb-1"><strong>Address:</strong></p>
                                    <p class="text-muted" id="viewAddress"></p>
                                </div>
                                <div class="col-md-6">
                                    <p class="mb-1"><strong>Role:</strong></p>
                                    <p class="text-muted" id="viewRole"></p>
                                </div>
                                <div class="col-md-6">
                                    <p class="mb-1"><strong>Image:</strong></p>
                                    <img id="viewAvatar" src="" alt="Avatar" class="img-thumbnail"
                                         style="width: 150px; height: 150px; display: none;">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layouts/footer.jsp" />
    </div>
</div>

<script>
    $(document).ready(function() {
        $(".btn-edit").click(function() {
            const userId = $(this).data("id");
            const email = $(this).data("email");
            const phone = $(this).data("phone");
            const fullName = $(this).data("fullname");
            const address = $(this).data("address");
            const role = $(this).data("role");
            const avatar = $(this).data("avatar");

            $("#editForm").attr("action", "/admin/user/update/" + userId);

            $("#editEmail").val(email);
            $("#editPhone").val(phone);
            $("#editFullName").val(fullName);
            $("#editAddress").val(address);
            $("#editRole").val(role);
            $("#editAvatar").val(avatar);
        });

        $("#editForm").submit(function(event) {
            if (!this.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            $(this).addClass('was-validated');
        });
    });
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const viewButtons = document.querySelectorAll('.btn-view');
        viewButtons.forEach(button => {
            button.addEventListener('click', function () {
                // Lấy dữ liệu từ các thuộc tính data-*

                const email = this.getAttribute('data-email');
                const phone = this.getAttribute('data-phone');
                const fullName = this.getAttribute('data-fullname');
                const address = this.getAttribute('data-address');
                const role = this.getAttribute('data-role');
                const avatar = this.getAttribute('data-avatar');
                console.log("Avatar path:", avatar);

                // Gắn dữ liệu vào các thẻ trong modal
                document.getElementById('viewEmail').textContent = email;
                document.getElementById('viewPhone').textContent = phone;
                document.getElementById('viewFullName').textContent = fullName;
                document.getElementById('viewAddress').textContent = address;
                document.getElementById('viewRole').textContent = role;

                const avatarElement = document.getElementById('viewAvatar');
                if (avatar) {
                    avatarElement.src = avatar;
                    avatarElement.style.display = "block";
                } else {
                    avatarElement.style.display = "none";
                }
            });
        });
    });
</script>
<script>
    // JavaScript for image preview
    document.getElementById('avatarFile').addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('avatarPreview').src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>
</body>

</html>