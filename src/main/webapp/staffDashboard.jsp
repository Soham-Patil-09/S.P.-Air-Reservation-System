<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Session check for authentication
    HttpSession sessionS = request.getSession(false);
    if (sessionS == null || sessionS.getAttribute("staff_id") == null) {
        response.sendRedirect("staffLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <h2>Welcome, <%= sessionS.getAttribute("staff_name") %></h2>
        <hr>

        <!-- Navigation Tabs -->
        <ul class="nav nav-tabs" id="staffTab">
            <li class="nav-item">
                <a class="nav-link active" data-bs-toggle="tab" href="#schedule">Flight Schedule</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#customers">Customers</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#queries">Queries</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#manager">Duty Manager</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-danger" href="StaffLogoutServlet">Logout</a>
            </li>
        </ul>

        <div class="tab-content mt-3">
            <!-- Flight Schedule -->
            <div class="tab-pane fade show active" id="schedule">
                <h4>Flight Schedule</h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Flight ID</th><th>Name</th><th>Airline</th><th>Source</th><th>Destination</th><th>Departure</th><th>Arrival</th><th>Seats</th><th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");
                                 PreparedStatement pst = con.prepareStatement("SELECT * FROM Flight");
                                 ResultSet rs = pst.executeQuery()) {
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("flight_id") %></td>
                            <td><%= rs.getString("flight_name") %></td>
                            <td><%= rs.getString("airline") %></td>
                            <td><%= rs.getString("source") %></td>
                            <td><%= rs.getString("destination") %></td>
                            <td><%= rs.getTimestamp("departure_time") %></td>
                            <td><%= rs.getTimestamp("arrival_time") %></td>
                            <td><%= rs.getInt("seats_available") %></td>
                            <td>₹<%= rs.getDouble("price") %></td>
                        </tr>
                        <% } } catch (Exception e) { out.println("Error: " + e.getMessage()); } %>
                    </tbody>
                </table>
            </div>

            <!-- Customers -->
            <div class="tab-pane fade" id="customers">
                <h4>Customer Details</h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>ID</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Phone</th><th>Nationality</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");
                                 PreparedStatement pst = con.prepareStatement("SELECT id, first_name, last_name, email, phone_number, nationality FROM customers");
                                 ResultSet rs = pst.executeQuery()) {
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("first_name") %></td>
                            <td><%= rs.getString("last_name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("phone_number") %></td>
                            <td><%= rs.getString("nationality") %></td>
                        </tr>
                        <% } } catch (Exception e) { out.println("Error: " + e.getMessage()); } %>
                    </tbody>
                </table>
            </div>

            <!-- Queries -->
            <div class="tab-pane fade" id="queries">
                <h4>Customer Queries</h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Grievance ID</th><th>Customer</th><th>Booking ID</th><th>Complaint</th><th>Status</th><th>Submitted At</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");
                                 PreparedStatement pst = con.prepareStatement(
                                     "SELECT g.grievance_id, c.first_name, c.last_name, g.booking_id, g.complaint, g.status, g.submitted_at " +
                                     "FROM Grievance g JOIN Customers c ON g.customer_id = c.id");
                                 ResultSet rs = pst.executeQuery()) {
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("grievance_id") %></td>
                            <td><%= rs.getString("first_name") %> <%= rs.getString("last_name") %></td>
                            <td><%= rs.getInt("booking_id") %></td>
                            <td><%= rs.getString("complaint") %></td>
                            <td><%= rs.getString("status") %></td>
                            <td><%= rs.getTimestamp("submitted_at") %></td>
                        </tr>
                        <% } } catch (Exception e) { out.println("Error: " + e.getMessage()); } %>
                    </tbody>
                </table>
            </div>

            <!-- Duty Manager -->
            <div class="tab-pane fade" id="manager">
                <h4>Duty Manager Details</h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Manager ID</th><th>Name</th><th>Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");
                                 PreparedStatement pst = con.prepareStatement("SELECT * FROM Manager LIMIT 1");
                                 ResultSet rs = pst.executeQuery()) {
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("manager_id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("email") %></td>
                        </tr>
                        <% } } catch (Exception e) { out.println("Error: " + e.getMessage()); } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
