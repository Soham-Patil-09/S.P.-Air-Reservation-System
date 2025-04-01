<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("admin_id") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    String adminName = (String) sessionObj.getAttribute("admin_name");

    // Database connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Welcome, <%= adminName %></h2>
        
        <!-- Navigation Tabs -->
        <ul class="nav nav-tabs" id="adminTabs">
            <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#flights">Flights</a></li>
            <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#bookings">Bookings</a></li>
            <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#grievances">Customer Queries</a></li>
            <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#staff">Staff And Managers</a></li>
            <li class="nav-item"><a class="nav-link text-danger" href="AdminLogoutServlet">Logout</a></li>
        </ul>

        <!-- Tab Content -->
        <div class="tab-content mt-3">

			 <!-- Flights Management -->
			<div class="tab-pane fade show active" id="flights">
			    <h4 class="mb-3">Manage Flights</h4>
			
			    <!-- Add Flight Button -->
			    <a href="addFlight.jsp" class="btn btn-success mb-3">
			        <i class="fas fa-plus"></i> Add Flight
			    </a>
			
			    <table class="table table-bordered">
			        <thead class="table-dark">
			            <tr>
			                <th>Flight ID</th><th>Name</th><th>Airline</th><th>Source</th><th>Destination</th><th>Seats</th><th>Price</th><th>Action</th>
			            </tr>
			        </thead>
			        <tbody>
			            <%
			                PreparedStatement pst = con.prepareStatement("SELECT * FROM Flight");
			                ResultSet rs = pst.executeQuery();
			                while (rs.next()) {
			            %>
			            <tr>
			                <td><%= rs.getInt("flight_id") %></td>
			                <td><%= rs.getString("flight_name") %></td>
			                <td><%= rs.getString("airline") %></td>
			                <td><%= rs.getString("source") %></td>
			                <td><%= rs.getString("destination") %></td>
			                <td><%= rs.getInt("seats_available") %></td>
			                <td>&#8377;<%= rs.getDouble("price") %></td>

			                <td>
			                    
			                    <a href="deleteFlightServlet?id=<%= rs.getInt("flight_id") %>" class="btn btn-danger btn-sm">
			                        <i class="fas fa-trash"></i> Delete
			                    </a>
			                </td>
			            </tr>
			            <% } %>
			        </tbody>
			    </table>
			</div>

            <!-- View Bookings -->
            <div class="tab-pane fade" id="bookings">
                <h4>All Bookings</h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Booking ID</th><th>Customer ID</th><th>Flight ID</th><th>Date</th><th>Status</th><th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            pst = con.prepareStatement("SELECT * FROM Booking");
                            rs = pst.executeQuery();
                            while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("booking_id") %></td>
                            <td><%= rs.getInt("customer_id") %></td>
                            <td><%= rs.getInt("flight_id") %></td>
                            <td><%= rs.getTimestamp("booking_date") %></td>
                            <td><%= rs.getString("status") %></td>
                            <td>
                                <a href="cancelBookingServlet?id=<%= rs.getInt("booking_id") %>" class="btn btn-danger btn-sm">Cancel</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Customer Grievances -->
            <div class="tab-pane fade" id="grievances">
                <h4>Customer Queries</h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>ID</th><th>Customer ID</th><th>Booking ID</th><th>Complaint</th><th>Status</th><th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            pst = con.prepareStatement("SELECT * FROM Grievance");
                            rs = pst.executeQuery();
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
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Staff & Managers -->
            <div class="tab-pane fade" id="staff">
                <h4>Staff & Managers</h4>
                <table class="table table-bordered">
                    <thead>
                        <tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th></tr>
                    </thead>
                    <tbody>
                        <%
                            pst = con.prepareStatement("SELECT manager_id AS id, name, email, 'Manager' AS role FROM Manager UNION ALL SELECT staff_id, name, email, 'Staff' FROM Staff");
                            rs = pst.executeQuery();
                            while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("role") %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
