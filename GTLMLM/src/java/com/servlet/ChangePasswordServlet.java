package com.servlet;


import com.util.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }
        
        int userId = (int) session.getAttribute("id");
        String currentPassword = request.getParameter("cpass");
        String newPassword = request.getParameter("newpass");
        
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        
        try {
            con = DBConnection.getConn(); // Ensure you have this utility class
            pst = con.prepareStatement("SELECT password FROM users WHERE id = ?");
            pst.setInt(1, userId);
            rs = pst.executeQuery();
            
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                
                if (!storedPassword.equals(currentPassword)) {
                    request.setAttribute("error", "Current password is incorrect!");
                    request.getRequestDispatcher("Change_member_password.jsp").forward(request, response);
                    return;
                }
                
                pst = con.prepareStatement("UPDATE users SET password = ? WHERE id = ?");
                pst.setString(1, newPassword);
                pst.setInt(2, userId);
                pst.executeUpdate();
                
                request.setAttribute("message", "Password changed successfully!");
                request.getRequestDispatcher("Change_member_password.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "User not found!");
                request.getRequestDispatcher("Change_member_password.jsp").forward(request, response);
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); if (pst != null) pst.close(); if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
