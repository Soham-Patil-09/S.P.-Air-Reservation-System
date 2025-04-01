<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.math.BigDecimal, java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Payment</h2>
        
        <% 
            HttpSession sessionObj = request.getSession(false);
            if (sessionObj == null || sessionObj.getAttribute("customerId") == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            Integer customerId = (Integer) sessionObj.getAttribute("customerId");
            String customerName = (String) sessionObj.getAttribute("customerName");
            String customerEmail = (String) sessionObj.getAttribute("email");
            String customerPhone = (String) sessionObj.getAttribute("phone_number");
            
            Integer flightId = (Integer) sessionObj.getAttribute("flightId");
            String flightName = (String) sessionObj.getAttribute("flightName");
            String airline = (String) sessionObj.getAttribute("airline");
            String source = (String) sessionObj.getAttribute("source");
            String destination = (String) sessionObj.getAttribute("destination");
            String departureTime = (String) sessionObj.getAttribute("departureTime");
            String arrivalTime = (String) sessionObj.getAttribute("arrivalTime");
            BigDecimal price = (BigDecimal) sessionObj.getAttribute("price");
            
            if (flightId == null || price == null) {
                out.println("<p class='text-danger'>No flight selected.</p>");
            } else {
        %>
        <div class="card p-4">
            <h4>Flight Details</h4>
            <p><strong>Flight Name:</strong> <%= flightName %></p>
            <p><strong>Airline:</strong> <%= airline %></p>
            <p><strong>From:</strong> <%= source %> to <%= destination %></p>
            <p><strong>Departure:</strong> <%= departureTime %></p>
            <p><strong>Arrival:</strong> <%= arrivalTime %></p>
            <p><strong>Price:</strong> ₹<%= price %></p>
        </div>
        
        <div class="card p-4 mt-3">
            <h4>Customer Details</h4>
            <p><strong>Name:</strong> <%= customerName %></p>
            <p><strong>Email:</strong> <%= customerEmail %></p>
            <p><strong>Phone:</strong> <%= customerPhone %></p>
        </div>
        
        <div class="card p-4 mt-3">
            <h4>Select Payment Method</h4>
            <form action="ConfirmPaymentServlet" method="post">
                <input type="hidden" name="flight_id" value="<%= flightId %>">
                <input type="hidden" name="customer_id" value="<%= customerId %>">
                <input type="hidden" name="price" value="<%= price %>">
                
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="payment_method" value="Credit Card" required>
                    <label class="form-check-label">Credit Card</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="payment_method" value="Debit Card" required>
                    <label class="form-check-label">Debit Card</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="payment_method" value="UPI" required>
                    <label class="form-check-label">UPI</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="payment_method" value="Net Banking" required>
                    <label class="form-check-label">Net Banking</label>
                </div>
                
                <button type="submit" class="btn btn-primary mt-3">Proceed to Pay</button>
            </form>
        </div>
        <% } %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>