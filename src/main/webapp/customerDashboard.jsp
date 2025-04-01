<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Welcome to Your Dashboard</h2>
        <ul class="nav nav-tabs" id="dashboardTabs">
            <li class="nav-item">
                <a class="nav-link active" data-bs-toggle="tab" href="#bookFlight">Book Flight</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#booking">Booking</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#grievance">Grievance</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-danger" href="CustomerLogoutServlet">Logout</a>
            </li>
        </ul>
        
        <div class="tab-content mt-3">
            <div class="tab-pane fade show active" id="bookFlight">
                <h3>Available Flights</h3>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Flight Name</th>
                            <th>Airline</th>
                            <th>Source</th>
                            <th>Destination</th>
                            <th>Departure</th>
                            <th>Arrival</th>
                            <th>Seats Available</th>
                            <th>Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");
                                String query = "SELECT * FROM Flight WHERE seats_available > 0";
                                PreparedStatement stmt = conn.prepareStatement(query);
                                ResultSet rs = stmt.executeQuery();
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("flight_name") %></td>
                            <td><%= rs.getString("airline") %></td>
                            <td><%= rs.getString("source") %></td>
                            <td><%= rs.getString("destination") %></td>
                            <td><%= rs.getTimestamp("departure_time") %></td>
                            <td><%= rs.getTimestamp("arrival_time") %></td>
                            <td><%= rs.getInt("seats_available") %></td>
                            <td><%= rs.getBigDecimal("price") %></td>
                            <td>
								<form action="BookFlightServlet" method="post">
								    <input type="hidden" name="flight_id" value="<%= rs.getInt("flight_id") %>">
								    <button type="submit" class="btn btn-success">Book</button>
								</form>

                            </td>
                        </tr>
                        <% 
                                }
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
            
            <div class="tab-pane fade" id="booking">
                <h3>My Bookings</h3>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Flight Name</th>
                            <th>Airline</th>
                            <th>Source</th>
                            <th>Destination</th>
                            <th>Departure</th>
                            <th>Seat Number</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");
                            
                            Integer customerId = (Integer) session.getAttribute("customerId"); // No need to declare HttpSession again

                            String query = "SELECT b.booking_id, f.flight_name, f.airline, f.source, f.destination, f.departure_time, b.seat_number, b.status FROM Booking b JOIN Flight f ON b.flight_id = f.flight_id WHERE b.customer_id = ?";
                            PreparedStatement stmt = conn.prepareStatement(query);
                            stmt.setInt(1, customerId);
                            ResultSet rs = stmt.executeQuery();

                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("flight_name") %></td>
                            <td><%= rs.getString("airline") %></td>
                            <td><%= rs.getString("source") %></td>
                            <td><%= rs.getString("destination") %></td>
                            <td><%= rs.getTimestamp("departure_time") %></td>
                            <td><%= rs.getString("seat_number") %></td>
                            <td><%= rs.getString("status") %></td>
                            <td>
                                <% if ("Booked".equals(rs.getString("status"))) { %>
                                    <form action="CancelBookingServlet" method="post">
                                        <input type="hidden" name="booking_id" value="<%= rs.getInt("booking_id") %>">
                                        <button type="submit" class="btn btn-danger">Cancel</button>
                                    </form>
                                <% } %>
                            </td>
                        </tr>
                        <% 
                                }
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
            
            <div class="tab-pane fade" id="grievance">
                <h3>Submit a Grievance</h3>
                <form action="SubmitGrievanceServlet" method="post">
                    <div class="mb-3">
                        <label for="complaint" class="form-label">Your Complaint</label>
                        <textarea class="form-control" id="complaint" name="complaint" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
