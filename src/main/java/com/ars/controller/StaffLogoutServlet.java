package com.ars.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/StaffLogoutServlet")
public class StaffLogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current session (if exists)
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            session.invalidate(); // Destroy the session
        }
        
        // Redirect to login page after logout
        response.sendRedirect("staffLogin.jsp?message=Logged%20out%20successfully");
    }
}
