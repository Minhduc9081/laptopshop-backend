<!DOCTYPE html>
<html>
<head>
    <title>User Details</title>
</head>
<body>
<h1>User Details for ID: ${id}</h1>

<c:if test="${not empty users}">
    <p>Name: ${users.name}</p>
    <p>Email: ${users.email}</p>
    <!-- Add more fields as needed -->
</c:if>

<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>
</body>
</html>
