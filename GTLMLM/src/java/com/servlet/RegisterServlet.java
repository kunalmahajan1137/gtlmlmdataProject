/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import com.google.gson.Gson;
import com.util.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("Inside RegisterServlet");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String sponsorId = request.getParameter("sponsor_id");
        String sponsorName = request.getParameter("sponsor_name");
        String position = request.getParameter("position");
        String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");

        System.out.println("sponsorId"+ sponsorId);
        
        Connection conn = null;
        PreparedStatement stmt = null;
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            conn = DBConnection.getConn();
            String sql = "INSERT INTO users (sponsor_id, sponsor_name, position, name, mobile, email, password,confpassword) VALUES (?, ?, ?, ?, ?, ?, ?,?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, sponsorId);
            stmt.setString(2, sponsorName);
            stmt.setString(3, position);
            stmt.setString(4, name);
            stmt.setString(5, mobile);
            stmt.setString(6, email);
            stmt.setString(7, password); // Hash this in a real application
            stmt.setString(8, confirmPassword); // Hash this in a real application
            int rowsInserted = stmt.executeUpdate();
            System.out.println("rowsInserted"+ rowsInserted);
            if (rowsInserted > 0) {
                jsonResponse.put("status", "success");
                jsonResponse.put("message", "Registration successful!");
            } else {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Registration failed. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        // Convert map to JSON using Gson
        Gson gson = new Gson();
        String jsonResponseString = gson.toJson(jsonResponse);
        out.print(jsonResponseString);
        out.flush();
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
