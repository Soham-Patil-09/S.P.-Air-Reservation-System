package com.ars.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/CustomerRegisterServlet")
public class CustomerRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CustomerRegisterServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String dob = request.getParameter("dob");
        String nationality = request.getParameter("nationality");
        String phoneNumber = request.getParameter("phone"); // FIXED HERE
        String address = request.getParameter("address");

        // Debugging print statements
        System.out.println("Received Phone Number: " + phoneNumber);

        // Validate phone number (ensure it's not null and is 10 digits)
        if (phoneNumber == null || phoneNumber.trim().isEmpty() || !phoneNumber.matches("\\d{10}")) {
            response.getWriter().println("Error: Invalid phone number. It must be 10 digits.");
            return;
        }

        String jdbcURL = "jdbc:mysql://localhost:3306/ars_db";
        String dbUser = "root";
        String dbPassword = "123456789";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "INSERT INTO customers (first_name, last_name, email, password, dob, nationality, phone_number, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, email);
            stmt.setString(4, password);
            stmt.setString(5, dob);
            stmt.setString(6, nationality);
            stmt.setString(7, phoneNumber);
            stmt.setString(8, address);

            int rowsInserted = stmt.executeUpdate();
            stmt.close();
            conn.close();

            if (rowsInserted > 0) {
                response.sendRedirect("customerLogin.jsp");
            } else {
                response.getWriter().println("Registration failed. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
