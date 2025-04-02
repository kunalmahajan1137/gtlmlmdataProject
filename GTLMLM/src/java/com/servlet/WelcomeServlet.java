package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


// Database connection import
import com.util.DBConnection;
import jakarta.servlet.http.HttpSession;
import java.lang.Integer;

@WebServlet("/WelcomeServlet")
public class WelcomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {   
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("id");  // Ensure user ID is Integer type
        
        if (userId == null) {
            response.sendRedirect("../login.jsp"); // Redirect if session is invalid
            return;
        }
        System.out.println(userId);

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConn();
            
            // Modify this query based on your table structure
            String query = "SELECT u.id, u.name, u.email, u.mobile, u.created_at, ud.address1, ud.city, ud.state, ud.pincode, " +
                            "ud.fathername, nd.nominee_name, nd.relationship " +  
                            "FROM users as u " +
                            "JOIN users_details as ud ON u.id = ud.user_id " +
                            "JOIN nominee_kyc_details as nd ON u.id = nd.user_id " +
                            "WHERE u.id = ?";
                           
            ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println(rs);
                request.setAttribute("userId", rs.getString("id"));
                request.setAttribute("userName", rs.getString("name"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("contactNo", rs.getString("mobile"));
                request.setAttribute("address", rs.getString("address1"));
                request.setAttribute("city", rs.getString("city"));
                request.setAttribute("state", rs.getString("state"));
                request.setAttribute("pincode", rs.getString("pincode"));
                request.setAttribute("fatherName", rs.getString("fathername"));
                request.setAttribute("nomineeName", rs.getString("nominee_name"));
                request.setAttribute("relation", rs.getString("relationship"));
                request.setAttribute("joiningDate", rs.getString("created_at"));
//                request.setAttribute("package", rs.getString("package_name"));
//                request.setAttribute("price", rs.getString("price"));
           
                request.setAttribute("package", "package_name");
                request.setAttribute("price","price");

            }
            request.getRequestDispatcher("cpwelcomeletter.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
