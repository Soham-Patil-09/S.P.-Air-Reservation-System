<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Ensure admin is logged in
    HttpSession adminSession = request.getSession(false);
    if (adminSession == null || adminSession.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    int flightId = Integer.parseInt(request.getParameter("id"));
    String name = "", airline = "", source = "", destination = "";
    int seats = 0;
    double price = 0.0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");
        PreparedStatement pst = con.prepareStatement("SELECT * FROM Flight WHERE flight_id=?");
        pst.setInt(1, flightId);
        ResultSet rs = pst.executeQuery();
        
        if (rs.next()) {
            name = rs.getString("flight_name");
            airline = rs.getString("airline");
            source = rs.getString("source");
            destination = rs.getString("destination");
            seats = rs.getInt("seats_available");
            price = rs.getDouble("price");
        }
        
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Flight</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Edit Flight</h2>
        <form action="editFlightServlet" method="post">
            <input type="hidden" name="flight_id" value="<%= flightId %>">
            
            <div class="mb-3">
                <label class="form-label">Flight Name</label>
                <input type="text" class="form-control" name="name" value="<%= name %>" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Airline</label>
                <input type="text" class="form-control" name="airline" value="<%= airline %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Source</label>
                <input type="text" class="form-control" name="source" value="<%= source %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Destination</label>
                <input type="text" class="form-control" name="destination" value="<%= destination %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Seats Available</label>
                <input type="number" class="form-control" name="seats" value="<%= seats %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Price</label>
                <input type="text" class="form-control" name="price" value="<%= price %>" required>
            </div>

            <button type="submit" class="btn btn-primary">Update Flight</button>
            <a href="adminDashboard.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>
