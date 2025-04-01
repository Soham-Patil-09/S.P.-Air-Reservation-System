<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    HttpSession sessionM = request.getSession(false);
    if (sessionM == null || sessionM.getAttribute("manager_id") == null) {
        response.sendRedirect("managerLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manager Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <h2>Welcome, <%= sessionM.getAttribute("manager_name") %></h2>
        <hr>

        <!-- Navigation Tabs -->
        <ul class="nav nav-tabs" id="managerTab">
            <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#schedule">Flight Schedule</a></li>
            <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#customers">Customers</a></li>
            <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#queries">Queries</a></li>
            <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#staff">Staff</a></li>
            <li class="nav-item"><a class="nav-link text-danger" href="LogoutServletManager">Logout</a></li>
        </ul>

        <div class="tab-content mt-3">
            
            <!-- Flight Schedule -->
            <div class="tab-pane fade show active" id="schedule">
                <h4>Flight Schedule</h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Flight ID</th><th>Name</th><th>Airline</th><th>Source</th><th>Destination</th><th>Departure</th><th>Arrival</th>
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
                            <th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Nationality</th><th>Address</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");
                                 PreparedStatement pst = con.prepareStatement("SELECT * FROM Customers");
                                 ResultSet rs = pst.executeQuery()) {

                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("first_name") %> <%= rs.getString("last_name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("phone_number") %></td>
                            <td><%= rs.getString("nationality") %></td>
                            <td><%= rs.getString("address") %></td>
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
		                <th>ID</th><th>Customer ID</th><th>Booking ID</th><th>Complaint</th><th>Status</th><th>Action</th>
		            </tr>
		        </thead>
		        <tbody>
		            <%
		                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");
		                     PreparedStatement pst = con.prepareStatement("SELECT grievance_id, customer_id, booking_id, complaint, status FROM Grievance");
		                     ResultSet rs = pst.executeQuery()) {
		
		                    while (rs.next()) {
		            %>
		            <tr>
		                <td><%= rs.getInt("grievance_id") %></td>
		                <td><%= rs.getInt("customer_id") %></td>
		                <td><%= rs.getInt("booking_id") %></td>
		                <td><%= rs.getString("complaint") %></td>
		                <td><%= rs.getString("status") %></td>
		                <td>
		                    <a href="resolveGrievanceServlet?id=<%= rs.getInt("grievance_id") %>" class="btn btn-success btn-sm">Resolve</a>
		                </td>
		            </tr>
		            <% } } catch (Exception e) { out.println("Error: " + e.getMessage()); } %>
		        </tbody>
		    </table>
		</div>

            <!-- Staff -->
            <div class="tab-pane fade" id="staff">
                <h4>Staff List</h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Staff ID</th><th>Name</th><th>Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");
                                 PreparedStatement pst = con.prepareStatement("SELECT staff_id, name, email FROM Staff");
                                 ResultSet rs = pst.executeQuery()) {

                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("staff_id") %></td>
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
