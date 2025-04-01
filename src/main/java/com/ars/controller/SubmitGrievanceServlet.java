package com.ars.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/SubmitGrievanceServlet")
public class SubmitGrievanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Get session details
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) { 
            response.getWriter().write("<script>alert('Invalid session. Please log in again.'); window.location='customerLogin.jsp';</script>");
            return;
        }

        // Retrieve the complaint from request
        String complaint = request.getParameter("complaint");

        // Validate complaint field
        if (complaint == null || complaint.trim().isEmpty()) { 
            response.getWriter().write("<script>alert('Complaint field cannot be empty!'); window.history.back();</script>");
            return;
        }

        Connection conn = null;
        PreparedStatement pst = null;

        try {
            // Load MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");

            // Insert grievance into the database (without booking_id)
            String insertSQL = "INSERT INTO Grievance (customer_id, complaint) VALUES (?, ?)";
            pst = conn.prepareStatement(insertSQL);
            pst.setInt(1, customerId);
            pst.setString(2, complaint);

            int rowsInserted = pst.executeUpdate();
            if (rowsInserted > 0) {
                response.getWriter().write("<script>alert('Grievance submitted successfully!'); window.location='customerDashboard.jsp';</script>");
            } else {
                response.getWriter().write("<script>alert('Error submitting grievance. Please try again.'); window.history.back();</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("<script>alert('Database error: " + e.getMessage() + "'); window.history.back();</script>");
        } finally {
            try {
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
