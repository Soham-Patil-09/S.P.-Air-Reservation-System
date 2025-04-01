<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card p-4 w-50 shadow">
            <h2 class="text-center">Admin Login</h2>
            <form action="AdminLoginServlet" method="post">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Login</button>
                <p class="text-center mt-3">
            		<a href="index.jsp">Back to Main Page</a>
       			 </p>
            </form>
            <%-- Display error message if login fails --%>
            <% String error = request.getParameter("error"); 
               if (error != null) { %>
                <p class="text-danger mt-2 text-center"><%= error %></p>
            <% } %>
        </div>
    </div>
</body>
</html>
