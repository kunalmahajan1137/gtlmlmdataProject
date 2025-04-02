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
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import com.util.DBConnection; // Update this according to your project structure

//@WebServlet("/ViewProfileServlet")
@WebServlet(name = "ViewProfileServlet", urlPatterns = {"/RegisterServlet"})
public class ViewProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("id");  // Ensure user ID is Integer type
        
        if (userId == null) {
            response.sendRedirect("../login.jsp"); // Redirect if session is invalid
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConn();
            rs = con.createStatement().executeQuery("SELECT * FROM users_details WHERE user_id=" + userId);
            System.out.println(rs);
            if(!rs.next()){
                String sql = "INSERT INTO users_details(user_id, dob, gender, fathername, husbandname, nationality, " +
                     "address1, address2, state, city, pincode, bankname, accholdername, accounttype, " +
                     "branchadd, accountno, IFSCcode, PANno) " +
                     "VALUES ("+userId+", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)";
                con.createStatement().execute(sql);
            }
            String query = "SELECT * FROM users u JOIN users_details ud ON u.id = ud.user_id WHERE u.id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                Map<String, String> userData = new HashMap<>();
                userData.put("user_id", rs.getString("user_id"));
                userData.put("name", rs.getString("name"));
                userData.put("sponsorid", rs.getString("sponsor_id"));
                userData.put("sponsorname", rs.getString("sponsor_name"));
                userData.put("fathername", rs.getString("fathername"));
                userData.put("husbandname", rs.getString("husbandname"));
                userData.put("password", rs.getString("password"));
                userData.put("dob", rs.getString("dob"));
                userData.put("address1", rs.getString("address1"));
                userData.put("address2", rs.getString("address2"));
                userData.put("pincode", rs.getString("pincode"));
                userData.put("city", rs.getString("city"));
                userData.put("state", rs.getString("state"));
                userData.put("nationality", rs.getString("nationality"));
                userData.put("contactno", rs.getString("mobile"));
                userData.put("gender", rs.getString("gender"));
                userData.put("regDate", rs.getString("created_at"));
                userData.put("email", rs.getString("email"));
                userData.put("bankname", rs.getString("bankname"));
                userData.put("branchadd", rs.getString("branchadd"));
                userData.put("accountno", rs.getString("accountno"));
                userData.put("accounttype", rs.getString("accounttype"));
                userData.put("accholdername", rs.getString("accholdername"));
                userData.put("IFSCcode", rs.getString("IFSCcode"));
                userData.put("PANno", rs.getString("PANno"));

                request.setAttribute("userData", userData);
                System.out.println(userData.toString());
                request.getRequestDispatcher("View_profile.jsp").forward(request, response);
            } else {
                response.sendRedirect("cerror.jsp"); // Redirect if no data found
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to error page on exception
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
