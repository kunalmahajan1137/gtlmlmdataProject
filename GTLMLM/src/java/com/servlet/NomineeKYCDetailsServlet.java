package com.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import com.util.DBConnection;

@MultipartConfig
public class NomineeKYCDetailsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String nomineeName = request.getParameter("nomineeName");
        String relationship = request.getParameter("relationship");
        String dob = request.getParameter("dob");
        String percentage = request.getParameter("percentage");
        String aadharNumber = request.getParameter("aadharNumber");

        String[] fileFields = {"bankInfoFile", "panCardFile", "aadharFrontFile", "aadharBackFile"};
        String[] fileNames = new String[fileFields.length];

        String uploadPath = getServletContext().getRealPath("/");
        uploadPath = uploadPath.substring(0, uploadPath.indexOf("build")) + "web/member/uploads/kyc/" + userId;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        try (Connection conn = DBConnection.getConn()) {
            for (int i = 0; i < fileFields.length; i++) {
                Part filePart = request.getPart(fileFields[i]);
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                    fileNames[i] = fileName;
                    System.out.println("chutya"+uploadDir+"mayur"+fileName);
                    File file = new File(uploadDir, fileName);
                    try (FileOutputStream fos = new FileOutputStream(file);
                         InputStream is = filePart.getInputStream()) {
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = is.read(buffer)) != -1) fos.write(buffer, 0, bytesRead);
                    }
                }
            }

            String checkQuery = "SELECT COUNT(*) FROM nominee_kyc_details WHERE user_id = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setInt(1, userId);
                ResultSet rs = checkStmt.executeQuery();
                boolean kycExists = rs.next() && rs.getInt(1) > 0;
                System.out.println("kyc"+kycExists);


                String sql;
                int a=1;
                if (kycExists) {
                    sql = "UPDATE nominee_kyc_details SET nominee_name = ?, relationship = ?, dob = ?, percentage = ?, aadhar_number = ?, bank_info_file = COALESCE(?, bank_info_file), pan_card_file = COALESCE(?, pan_card_file), aadhar_front_file = COALESCE(?, aadhar_front_file), aadhar_back_file = COALESCE(?, aadhar_back_file), upload_date = NOW() WHERE user_id = ?";
                    a=0;
                } else {
                    sql = "INSERT INTO nominee_kyc_details (user_id, nominee_name, relationship, dob, percentage, aadhar_number, bank_info_file, pan_card_file, aadhar_front_file, aadhar_back_file, upload_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,?, NOW())";
                    
                }

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(a+1, nomineeName);
                    ps.setString(a+2, relationship);
                    ps.setString(a+3, dob);
                    ps.setString(a+4, percentage);
                    ps.setString(a+5, aadharNumber);
                    for (int i = 0; i < fileNames.length; i++) {
                        if (fileNames[i] != null) {
                            ps.setString(a+6 + i, fileNames[i]);
                            System.out.println(fileNames[i]);
                        } else {
                            ps.setNull(a+6 + i, java.sql.Types.VARCHAR);
                        }
                    }

                    if (kycExists) {
                        ps.setInt(10, userId);
                        System.out.println("kk");

                    } else {
                        ps.setInt(1, userId);
                        System.out.println("mansi");

                    }
                    ps.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("NomineeDetails.jsp?error=ServerError");
            return;
        }
        response.sendRedirect("NomineeDetails.jsp?success=Uploaded");
    }
}
