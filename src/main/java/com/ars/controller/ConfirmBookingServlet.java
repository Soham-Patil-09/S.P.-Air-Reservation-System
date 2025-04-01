package com.ars.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ConfirmBookingServlet")
public class ConfirmBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null) {
            response.sendRedirect("customerLogin.jsp");
            return;
        }

        String flightId = request.getParameter("flight_id");
        String price = request.getParameter("price");
        String seatNumber = "A" + (int)(Math.random() * 50 + 1); // Random seat number

        String jdbcURL = "jdbc:mysql://localhost:3306/ars_db";
        String dbUser = "root";
        String dbPassword = "123456789";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Insert into Booking table
            String bookingSQL = "INSERT INTO Booking (customer_id, flight_id, seat_number, status) VALUES (?, ?, ?, 'Booked')";
            PreparedStatement bookingStmt = conn.prepareStatement(bookingSQL, Statement.RETURN_GENERATED_KEYS);
            bookingStmt.setInt(1, customerId);
            bookingStmt.setInt(2, Integer.parseInt(flightId));
            bookingStmt.setString(3, seatNumber);
            bookingStmt.executeUpdate();

            ResultSet generatedKeys = bookingStmt.getGeneratedKeys();
            int bookingId = 0;
            if (generatedKeys.next()) {
                bookingId = generatedKeys.getInt(1);
            }

            // Insert into Payment table
            String paymentSQL = "INSERT INTO Payment (booking_id, amount, payment_method, payment_status) VALUES (?, ?, 'UPI', 'Completed')";
            PreparedStatement paymentStmt = conn.prepareStatement(paymentSQL);
            paymentStmt.setInt(1, bookingId);
            paymentStmt.setBigDecimal(2, new java.math.BigDecimal(price));
            paymentStmt.executeUpdate();

            bookingStmt.close();
            paymentStmt.close();
            conn.close();

            // Redirect to dashboard
            response.sendRedirect("customerDashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
