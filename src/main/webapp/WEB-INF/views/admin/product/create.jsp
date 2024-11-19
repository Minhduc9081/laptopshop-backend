<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Create New Product - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .create-product-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-bottom: 2rem;
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
        }
        .section-title i {
            margin-right: 0.5rem;
            color: #6c757d;
        }
        .form-label {
            font-weight: 500;
            color: #495057;
            margin-bottom: 0.5rem;
        }
        .form-control {
            border: 1px solid #ced4da;
            padding: 0.625rem;
            border-radius: 6px;
            transition: border-color 0.15s ease-in-out;
        }
        .form-control:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 0.25rem rgba(13,110,253,.25);
        }
        .error {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        .image-preview-container {
            background: white;
            border: 2px dashed #ced4da;
            border-radius: 10px;
            padding: 1rem;
            text-align: center;
            margin-top: 1rem;
        }
        #imagePreview {
            max-width: 300px;
            max-height: 300px;
            margin: 1rem auto;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .btn-submit {
            padding: 0.625rem 1.25rem;
            font-weight: 500;
        }
        .form-control.textarea {
            min-height: 100px;
            resize: vertical;
        }
        .required-field::after {
            content: "*";
            color: #dc3545;
            margin-left: 4px;
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
                <h1 class="mt-4">Create New Product</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/products">Products</a></li>
                    <li class="breadcrumb-item active">Create New Product</li>
                </ol>

                <div class="create-product-container">
                    <form id="createForm" action="/admin/products/create" method="post" enctype="multipart/form-data">
                        <!-- Basic Information Section -->
                        <div class="form-section">
                            <div class="section-title">
                                <i class="fas fa-info-circle"></i> Basic Information
                            </div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="name" class="form-label required-field">Product Name</label>
                                    <input type="text" id="name" name="name" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="price" class="form-label required-field">Price ($)</label>
                                    <input type="number" id="price" name="price" class="form-control" step="0.01" min="0" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="quantity" class="form-label required-field">Quantity</label>
                                    <input type="number" id="quantity" name="quantity" class="form-control" min="0" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="sold" class="form-label">Sold</label>
                                    <input type="number" id="sold" name="sold" class="form-control" value="0" min="0">
                                </div>
                            </div>
                        </div>

                        <!-- Product Details Section -->
                        <div class="form-section">
                            <div class="section-title">
                                <i class="fas fa-file-alt"></i> Product Details
                            </div>
                            <div class="row g-3">
                                <div class="col-12">
                                    <label for="shortDescription" class="form-label required-field">Short Description</label>
                                    <textarea id="shortDescription" name="shortDescription" class="form-control textarea" required></textarea>
                                </div>
                                <div class="col-12">
                                    <label for="detailDescription" class="form-label required-field">Detailed Description</label>
                                    <textarea id="detailDescription" name="detailDescription" class="form-control textarea" required></textarea>
                                </div>
                            </div>
                        </div>

                        <!-- Additional Information Section -->
                        <div class="form-section">
                            <div class="section-title">
                                <i class="fas fa-tag"></i> Additional Information
                            </div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="manufacture" class="form-label required-field">Manufacturer</label>
                                    <input type="text" id="manufacture" name="manufacture" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="target" class="form-label required-field">Target Market</label>
                                    <input type="text" id="target" name="target" class="form-control" required>
                                </div>
                            </div>
                        </div>

                        <!-- Product Image Section -->
                        <div class="form-section">
                            <div class="section-title">
                                <i class="fas fa-image"></i> Product Image
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <label for="image" class="form-label required-field">Upload Image</label>
                                    <input type="file" class="form-control" id="image" name="image"
                                           accept="image/*" onchange="previewImage(event)" required>
                                    <div class="image-preview-container">
                                        <img id="imagePreview" src="#" alt="Image Preview" style="display: none;">
                                        <div id="uploadPrompt">
                                            <i class="fas fa-cloud-upload-alt fa-3x text-muted"></i>
                                            <p class="text-muted mt-2">Preview will appear here</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Form Actions -->
                        <div class="text-end mt-4">
                            <a href="/admin/products" class="btn btn-secondary me-2">
                                <i class="fas fa-times me-1"></i> Cancel
                            </a>
                            <button type="submit" class="btn btn-primary btn-submit">
                                <i class="fas fa-save me-1"></i> Create Product
                            </button>
                        </div>
                    </form>
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
        const preview = document.getElementById('imagePreview');
        const uploadPrompt = document.getElementById('uploadPrompt');

        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
                uploadPrompt.style.display = 'none';
            }
            reader.readAsDataURL(file);
        } else {
            preview.style.display = 'none';
            uploadPrompt.style.display = 'block';
        }
    }

</script>
</body>
</html>