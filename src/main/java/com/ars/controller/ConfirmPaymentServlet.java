package com.ars.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ConfirmPaymentServlet")
public class ConfirmPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");
        Integer flightId = (Integer) session.getAttribute("flightId");
        BigDecimal price = (BigDecimal) session.getAttribute("price");
        String paymentMethod = request.getParameter("payment_method");

        if (customerId == null || flightId == null || price == null || paymentMethod == null) {
            response.sendRedirect("dashboard.jsp?error=InvalidSession");
            return;
        }

        Connection conn = null;
        PreparedStatement bookingStmt = null, paymentStmt = null;
        ResultSet generatedKeys = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");

            // Insert into Booking Table
            String bookingQuery = "INSERT INTO Booking (customer_id, flight_id, seat_number, status) VALUES (?, ?, ?, 'Booked')";
            bookingStmt = conn.prepareStatement(bookingQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            bookingStmt.setInt(1, customerId);
            bookingStmt.setInt(2, flightId);
            bookingStmt.setString(3, "A1"); // Hardcoded seat number, update logic as needed

            int affectedRows = bookingStmt.executeUpdate();
            if (affectedRows == 0) {
                throw new Exception("Booking creation failed.");
            }

            // Retrieve Generated Booking ID
            generatedKeys = bookingStmt.getGeneratedKeys();
            int bookingId = 0;
            if (generatedKeys.next()) {
                bookingId = generatedKeys.getInt(1);
            } else {
                throw new Exception("Booking ID retrieval failed.");
            }

            // Insert into Payment Table
            String paymentQuery = "INSERT INTO Payment (booking_id, amount, payment_method, payment_status) VALUES (?, ?, ?, 'Completed')";
            paymentStmt = conn.prepareStatement(paymentQuery);
            paymentStmt.setInt(1, bookingId);
            paymentStmt.setBigDecimal(2, price);
            paymentStmt.setString(3, paymentMethod);

            paymentStmt.executeUpdate();

            // Redirect to Dashboard after Successful Payment
            response.sendRedirect("customerDashboard.jsp?success=PaymentCompleted");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("customerDashboard.jsp?error=PaymentFailed");
        } finally {
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (bookingStmt != null) bookingStmt.close();
                if (paymentStmt != null) paymentStmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
