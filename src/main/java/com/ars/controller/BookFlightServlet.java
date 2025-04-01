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

@WebServlet("/BookFlightServlet")
public class BookFlightServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int flightId = Integer.parseInt(request.getParameter("flight_id"));
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");
        
        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ars_db", "root", "123456789");
            
            String query = "SELECT * FROM Flight WHERE flight_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, flightId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
            	
                String flightName = rs.getString("flight_name");
                String airline = rs.getString("airline");
                String source = rs.getString("source");
                String destination = rs.getString("destination");
                String departureTime = rs.getString("departure_time");
                String arrivalTime = rs.getString("arrival_time");
                int seatsAvailable = rs.getInt("seats_available");
                BigDecimal price = rs.getBigDecimal("price");
                
                session.setAttribute("flightId", flightId);
                session.setAttribute("flightName", flightName);
                session.setAttribute("airline", airline);
                session.setAttribute("source", source);
                session.setAttribute("destination", destination);
                session.setAttribute("departureTime", departureTime);
                session.setAttribute("arrivalTime", arrivalTime);
                session.setAttribute("seatsAvailable", seatsAvailable);
                session.setAttribute("price", price);
                
                response.sendRedirect("payment.jsp");
            } else {
                response.sendRedirect("dashboard.jsp?error=FlightNotFound");
            }
            
            rs.close();
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=DatabaseError");
        }
    }
}
