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
import java.sql.ResultSet;

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CustomerLoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Debugging statement
        System.out.println("Login attempt: Email - " + email + ", Password - " + password);

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/ars_db";
        String dbUser = "root";
        String dbPassword = "123456789";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL query to check credentials
            String sql = "SELECT id, first_name FROM customers WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // User exists, create session
                HttpSession session = request.getSession();
                session.setAttribute("customerId", rs.getInt("id"));
                session.setAttribute("customerName", rs.getString("first_name"));

                // Redirect to customer dashboard or home page
                response.sendRedirect("customerDashboard.jsp");
            } else {
                // Invalid credentials, redirect to login page with error message
                response.sendRedirect("customerLogin.jsp?error=Invalid email or password");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
