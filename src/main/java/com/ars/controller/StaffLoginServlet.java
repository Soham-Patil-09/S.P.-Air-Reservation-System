package com.ars.controller;

import java.io.IOException;
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

@WebServlet("/StaffLoginServlet")
public class StaffLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Database connection (update credentials if needed)
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");

            // Query to validate login
            String sql = "SELECT * FROM Staff WHERE email=? AND password=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Login successful, create session
                HttpSession session = request.getSession();
                session.setAttribute("staff_id", rs.getInt("staff_id"));
                session.setAttribute("staff_name", rs.getString("name"));
                response.sendRedirect("staffDashboard.jsp"); // Redirect to dashboard
            } else {
                // Invalid credentials
                response.sendRedirect("staffLogin.jsp?message=Invalid%20credentials");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("staffLogin.jsp?message=Error%20occurred");
        }
    }
}
