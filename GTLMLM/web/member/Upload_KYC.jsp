<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>

<%
    // Get session object directly
    
    if (session.getAttribute("id") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // Retrieve userId from session
    Integer id = (Integer) session.getAttribute("id"); // Correct casting to Integer
    if (id == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int userId = (Integer) session.getAttribute("id");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String bankInfo = "", panCard = "", aadharFront = "", aadharBack = "", uploadDate = "";

    try {
        // Load MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DBConnection.getConn(); // Ensure DBConnection.getConn() is properly defined
        
        // Query to fetch KYC details for the logged-in user
        String query = "SELECT k.bank_info, k.pan_card, k.aadhar_front, k.aadhar_back, k.upload_date " +
                       "FROM users u LEFT JOIN kyc_details k ON u.id = k.user_id WHERE u.id = ?";
        
        ps = conn.prepareStatement(query);
        ps.setInt(1, userId);
        rs = ps.executeQuery();

        if (rs.next()) {
            bankInfo = rs.getString("bank_info") != null ? rs.getString("bank_info") : "";
            panCard = rs.getString("pan_card") != null ? rs.getString("pan_card") : "";
            aadharFront = rs.getString("aadhar_front") != null ? rs.getString("aadhar_front") : "";
            aadharBack = rs.getString("aadhar_back") != null ? rs.getString("aadhar_back") : "";
            uploadDate = rs.getString("upload_date") != null ? rs.getString("upload_date") : "";
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Upload KYC</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="style.css">

        <style>
            /* General Styling */
            body {
                background-color: #f4f6f9;
                font-family: 'Arial', sans-serif;
                color: #333;
            }
            .container {
                margin-top: 20px;
            }
            .card {
                border: none;
                border-radius: 8px;
                overflow: hidden;
            }
            .card-header {
                font-size: 1.5rem;
                font-weight: 600;
                color: #495057;
                background-color: #f8f9fa;
                border-bottom: 2px solid #00c7b7;
            }
            .info-text {
                font-size: 0.95rem;
                color: #666;
                padding: 10px 15px;
                background-color: #e9f7f7;
                border-radius: 5px;
                border: 1px solid #cce7e7;
                margin-bottom: 20px;
            }

            /* Form Styling */
            .form-group label {
                font-weight: 500;
                color: #495057;
            }
            .form-control-file {
                border: 1px solid #ced4da;
                padding: 7px;
                border-radius: 4px;
                background-color: #fff;
                transition: border-color 0.3s ease;
            }
            .form-control-file:hover {
                border-color: #00c7b7;
            }
            .btn-submit {
                background-color: #00c7b7;
                color: #fff;
                font-weight: bold;
                padding: 10px 30px;
                border-radius: 5px;
                border: none;
                transition: background-color 0.3s ease;
            }
            .btn-submit:hover {
                background-color: #00b2a5;
            }

            .header {
                padding: 15px; /* optional padding for better alignment */
            }

            .header .breadcrumb,
            .header .title {
                max-width: 100%; /* Ensure the text remains within container bounds */
                overflow: hidden; /* Prevent overflow */
                text-overflow: ellipsis; /* Adds ellipsis to overflowing text */
                white-space: nowrap; /* Prevents wrapping */
            }

            .row.flex-wrap {
                flex-wrap: wrap;
            }

            .profile-pic img {
                width: 100px;
                height: 100px;
                object-fit: cover; /* Ensures the image fits nicely within the circular frame */
            }

            /* CSS for responsive images */
            img {
                max-width: 100%;
                height: auto;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="d-flex">
            <!--Navbar-->
            <%@include file="navbar.jsp" %>

            <div class="content content-wrapper">
                <!--Top Navbar-->
                <header>    
                    <%@include file="topnavbar.jsp" %>


                </header>
                <!--Main Content page-->
                <div class="my-2">
                    <div class="header">
                        <div class="row d-flex flex-wrap align-items-center justify-content-between">
                            <div class="col-md-6 col-12 d-flex justify-content-start">
                                <!--<span class="title text-truncate">My Profile</span>-->
                            </div>
                            <div class="col-md-6 col-12 d-flex justify-content-md-end justify-content-start overflow-hidden">
                                <div class="breadcrumb text-nowrap text-truncate">
                                    <!--<a href="./account.php" class="breadcrumb-link">ACCOUNT&nbsp;</a> / <span>&nbsp;MY PROFILE</span>-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="container">
                        <div class="card-header">
                            <h2>Upload KYC</h2>
                            <p class="info-text">
                                Upload your KYC documents. Allowed formats: .gif, .jpg, .jpeg, .png (Max size: 300 KB).
                            </p>

                            <form action="UploadKYCServlet" method="POST" enctype="multipart/form-data">
                                <input type="hidden" name="userId" value="<%= userId %>">

                                <div class="mb-3">
                                    <label>Bank Information:</label>
                                    <input type="file" name="bankInfoFile" class="form-control"> 
                                </div>

                                <div class="mb-3">
                                    <label>PAN Card:</label>
                                    <input type="file" name="panCardFile" class="form-control">
                                </div>

                                <div class="mb-3">
                                    <label>Aadhar Card Front:</label>
                                    <input type="file" name="aadharFrontFile" class="form-control">
                                </div>

                                <div class="mb-3">
                                    <label>Aadhar Card Back:</label>
                                    <input type="file" name="aadharBackFile" class="form-control">
                                </div>

                                <button type="submit" class="btn btn-primary">Submit</button>
                            </form>

                            <!-- Uploaded Documents Table -->
                            <h3 class="mt-4">Uploaded Documents</h3>
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Bank Info</th>
                                        <th>PAN</th>
                                        <th>Aadhar Front</th>
                                        <th>Aadhar Back</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (!bankInfo.isEmpty()) { %>
                                    <tr>
                                        <td><img src="./uploads/<%= id %>/<%= bankInfo %>" width="100"></td>
                                        <td><img src="./uploads/<%= id %>/<%= panCard %>" width="100"></td>
                                        <td><img src="./uploads/<%= id %>/<%= aadharFront %>" width="100"></td>
                                        <td><img src="./uploads/<%= id %>/<%= aadharBack %>" width="100"></td>
                                        <td><%= uploadDate %></td>
                                    </tr>
                                    <% } else { %>
                                    <tr>
                                        <td colspan="5" class="text-center">No documents uploaded yet.</td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                     <!-- Footer -->
                <%@include file="footer.jsp" %>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        function loadProfileImage(event) {
                            const profileImage = document.getElementById('profileImage');
                            profileImage.src = URL.createObjectURL(event.target.files[0]);
                        }

                        document.getElementById('sidebarCollapse').addEventListener('click', function () {
                            const sidebar = document.getElementById('sidebar');
                            sidebar.classList.toggle('collapsed');
                            document.querySelector('.content').classList.toggle('collapsed');
                        });

                    </script>
                    </body>
                    </html>
