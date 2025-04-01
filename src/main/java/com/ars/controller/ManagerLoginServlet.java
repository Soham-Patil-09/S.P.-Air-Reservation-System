package com.ars.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@jakarta.servlet.annotation.WebServlet("/ManagerLoginServlet")
public class ManagerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");


            String sql = "SELECT * FROM Manager WHERE email=? AND password=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Login success - Create session
                HttpSession session = request.getSession();
                session.setAttribute("manager_id", rs.getInt("manager_id"));
                session.setAttribute("manager_name", rs.getString("name"));
                response.sendRedirect("managerDashboard.jsp"); // Redirect to dashboard
            } else {
                // Login failed
                response.sendRedirect("managerLogin.jsp?message=Invalid credentials");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
