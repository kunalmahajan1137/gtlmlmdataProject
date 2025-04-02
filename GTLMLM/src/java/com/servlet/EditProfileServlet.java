package com.servlet;

import com.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;


//@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
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
                request.getRequestDispatcher("edit_profile.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp"); // Redirect if no data found
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("id"); // Retrieve user ID from session

        String name = request.getParameter("name");
        String dob = request.getParameter("dobname");
        String gender = request.getParameter("gendername");
        String fatherName = request.getParameter("fathername");
        String husbandName = request.getParameter("husbandname");
        String email = request.getParameter("email");
        String contactNo = request.getParameter("contactno");
        String nationality = request.getParameter("nationality");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");
        String state = request.getParameter("state");
        String city = request.getParameter("city");
        String pincode = request.getParameter("pincode");
        String bankName = request.getParameter("bankname");
        String accHolderName = request.getParameter("accholdername");
        String accountType = request.getParameter("accounttype");
        String branchAddress = request.getParameter("branchadd");
        String accountNo = request.getParameter("accountno");
        String ifscCode = request.getParameter("IFSCcode");
        String panNo = request.getParameter("PANno");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConn();
            System.out.println(userId);
            ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM users_details WHERE user_id=" + userId);
            System.out.println(rs);
            if(!rs.next()){
                String sql = "INSERT INTO users_details(user_id, dob, gender, fathername, husbandname, nationality, " +
                     "address1, address2, state, city, pincode, bankname, accholdername, accounttype, " +
                     "branchadd, accountno, IFSCcode, PANno) " +
                     "VALUES ("+userId+", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)";
                conn.createStatement().execute(sql);
            }
            String sql = "UPDATE users_details SET dob=?, gender=?, fathername=?, husbandname=?, nationality=?, address1=?, address2=?, state=?, city=?, pincode=?, bankname=?, accholdername=?, accounttype=?, branchadd=?, accountno=?, IFSCcode=?, PANno=? WHERE user_id=?";
            ps = conn.prepareStatement(sql);

            ps.setString(1, dob);
            ps.setString(2, gender);
            ps.setString(3, fatherName);
            ps.setString(4, husbandName);
            ps.setString(5, nationality);
            ps.setString(6, address1);
            ps.setString(7, address2);
            ps.setString(8, state);
            ps.setString(9, city);
            ps.setString(10, pincode);
            ps.setString(11, bankName);
            ps.setString(12, accHolderName);
            ps.setString(13, accountType);
            ps.setString(14, branchAddress);
            ps.setString(15, accountNo);
            ps.setString(16, ifscCode);
            ps.setString(17, panNo);
            ps.setInt(18, userId);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                session.setAttribute("message", "Profile updated successfully.");
            } else {
                session.setAttribute("error", "Failed to update profile.");
            }
            
            // **Call doGet to refresh the profile page with updated data**
            doGet(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Something went wrong.");
            response.sendRedirect("edit_profile.jsp");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
