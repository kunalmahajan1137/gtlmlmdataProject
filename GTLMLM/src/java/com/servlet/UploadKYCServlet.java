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
public class UploadKYCServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        String[] fileFields = {"bankInfoFile", "panCardFile", "aadharFrontFile", "aadharBackFile"};
        String[] fileNames = new String[4];

        // Define absolute upload path
        String uploadPath = getServletContext().getRealPath("/");
        uploadPath = uploadPath.substring(0, uploadPath.indexOf("build")) + "web/member/uploads" + File.separator + userId;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs(); // Create directory if not exists


        try (Connection conn = DBConnection.getConn()) { // Use try-with-resources to auto-close connection
                    System.out.println(3);

            for (int i = 0; i < fileFields.length; i++) {
                Part filePart = request.getPart(fileFields[i]);
                if (filePart.getSize() > 0) {
                    String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName(); // Unique filename
                    fileNames[i] = fileName;
                    System.out.println(uploadDir);
                    System.out.println(fileName);


                    File file = new File(uploadDir, fileName);
                    
                    try (FileOutputStream fos = new FileOutputStream(file);
                         InputStream is = filePart.getInputStream()) {
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = is.read(buffer)) != -1) fos.write(buffer, 0, bytesRead);
                    }
                } else {
                    fileNames[i] = null; // If no file uploaded, keep null
                }
            }
            System.out.println(4);

            // Check if KYC details already exist for the user
            String checkQuery = "SELECT COUNT(*) FROM kyc_details WHERE user_id = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setInt(1, userId);
                ResultSet rs = checkStmt.executeQuery();

                boolean kycExists = false;
                if (rs.next() && rs.getInt(1) > 0) {
                    kycExists = true;
                }

                String sql;
                if (kycExists) {
                    // If KYC details exist, update only the provided files
                    sql = "UPDATE kyc_details SET "
                        + "bank_info = COALESCE(?, bank_info), "
                        + "pan_card = COALESCE(?, pan_card), "
                        + "aadhar_front = COALESCE(?, aadhar_front), "
                        + "aadhar_back = COALESCE(?, aadhar_back), "
                        + "upload_date = NOW() WHERE user_id = ?";
                } else {
                    // If KYC details do not exist, insert a new record
                    sql = "INSERT INTO kyc_details (user_id, bank_info, pan_card, aadhar_front, aadhar_back, upload_date) "
                        + "VALUES (?, ?, ?, ?, ?, NOW())";
                }

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    if (kycExists) {
                        for (int i = 0; i < fileNames.length; i++) {
                            if (fileNames[i] != null) {
                                ps.setString(i + 1, fileNames[i]);
                            } else {
                                ps.setNull(i + 1, java.sql.Types.VARCHAR);
                            }
                        }
                        ps.setInt(5, userId); // user_id for WHERE condition
                    } else {
                        ps.setInt(1, userId);
                        for (int i = 0; i < fileNames.length; i++) {
                            if (fileNames[i] != null) {
                                ps.setString(2 + i, fileNames[i]);
                            } else {
                                ps.setNull(2 + i, java.sql.Types.VARCHAR);
                            }
                        }
                    }
                    ps.executeUpdate();
                }
            }

        } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("Upload_KYC.jsp?error=ServerError");
        }

        response.sendRedirect("Upload_KYC.jsp");
    }
}
