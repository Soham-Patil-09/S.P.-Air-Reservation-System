<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .login-container h3 {
            margin-bottom: 20px;
        }
        
        .error {
            color: red;
            text-align: center;
        }        
    </style>
</head>
<body>
    <div class="login-container">
        <h3 class="text-center">Staff Login</h3>
        
        <%-- Display error message if login fails --%>
        <% String message = request.getParameter("message"); 
           if (message != null) { %>
            <p class="error"><%= message %></p>
        <% } %>
        
        <form action="StaffLoginServlet" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your Staff email" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <button type="submit" class="btn btn-warning w-100">Login</button>
        </form>
        <p class="text-center mt-3">
            <a href="index.jsp">Back to Main Page</a>
        </p>
    </div>
</body>
</html>
