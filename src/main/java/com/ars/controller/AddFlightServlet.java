package com.ars.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/AddFlightServlet")
public class AddFlightServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String flightName = request.getParameter("flight_name");
        String airline = request.getParameter("airline");
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        String departureTime = request.getParameter("departure_time");
        String arrivalTime = request.getParameter("arrival_time");
        int seatsAvailable = Integer.parseInt(request.getParameter("seats_available"));
        double price = Double.parseDouble(request.getParameter("price"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");

            String sql = "INSERT INTO Flight (flight_name, airline, source, destination, departure_time, arrival_time, seats_available, price) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, flightName);
            stmt.setString(2, airline);
            stmt.setString(3, source);
            stmt.setString(4, destination);
            stmt.setString(5, departureTime);
            stmt.setString(6, arrivalTime);
            stmt.setInt(7, seatsAvailable);
            stmt.setDouble(8, price);

            int result = stmt.executeUpdate();
            if (result > 0) {
                response.sendRedirect("adminDashboard.jsp?msg=Flight Added Successfully");
            } else {
                response.sendRedirect("adminDashboard.jsp?msg=Flight Addition Failed");
            }
            
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?msg=Error Occurred");
        }
    }
}
