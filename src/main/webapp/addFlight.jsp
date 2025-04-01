<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Flight</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Add Flight</h2>
        
        <form action="AddFlightServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Flight Name</label>
                <input type="text" class="form-control" name="flight_name" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Airline</label>
                <input type="text" class="form-control" name="airline" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Source</label>
                <input type="text" class="form-control" name="source" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Destination</label>
                <input type="text" class="form-control" name="destination" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Departure Time</label>
                <input type="datetime-local" class="form-control" name="departure_time" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Arrival Time</label>
                <input type="datetime-local" class="form-control" name="arrival_time" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Seats Available</label>
                <input type="number" class="form-control" name="seats_available" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Price</label>
                <input type="number" class="form-control" name="price" step="0.01" required>
            </div>

            <button type="submit" class="btn btn-primary">Add Flight</button>
            <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </form>
    </div>
</body>
</html>
