<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Responsive Collapsible Sidebar with Navbar</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
        <style>
            body {
                background-color: #f8f9fa;
            }

            .container {
                max-width: 95%;
            }

            .breadcrumb {
                font-size: 0.9rem;
                color: #006666;
            }

            .breadcrumb-link {
                color: #006666;
                text-decoration: none;
            }

            .breadcrumb-link:hover {
                text-decoration: underline;
            }

            .card {
                background-color: #ffffff;
                border-radius: 8px;
                border: none;
            }

            .form-control {
                border-color: #d1d9e6;
            }

            .btn-primary {
                background-color: #00c7c7;
                border: none;
            }

            .btn-primary:hover {
                background-color: #009999;
            }

            .btn-secondary {
                background-color: #00c7c7;
                border: none;
            }

            .btn-secondary:hover {
                background-color: #009999;
            }


            .content-wrapper {
                flex: 1;
                display: flex;
                flex-direction: column;
            }

            .container {
                flex: 1;
            }

            footer {
                margin-top: auto;
                background-color: #f8f9fa; /* Adjust based on your theme */
                text-align: center;
                padding: 10px 0;
                border-top: 1px solid #ddd;
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

        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="d-flex">
            <!--Navbar-->
            <%@include file="navbar.jsp" %>
            <div class="content content-wrapper">
                <!--Top Navbar-->
                <%@include file="topnavbar.jsp" %>
                <!--Main Content page-->
                <div class="container my-2">

                    <div class="header">
                        <div class="row d-flex flex-wrap align-items-center justify-content-between">
                            <div class="col-md-6 col-12 d-flex justify-content-start">
                                <!--<span class="title text-truncate">Change Password</span>-->
                            </div>
                            <div class="col-md-6 col-12 d-flex justify-content-md-end justify-content-start overflow-hidden">
                                <div class="breadcrumb text-nowrap text-truncate">
                                    <!--<a href="./account.php" class="breadcrumb-link">ACCOUNT&nbsp;</a> / <span>&nbsp;CHANGE PASSWOR</span>-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container mt-5">
                        <h2>Change Password</h2>

                        <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                        <% } %>
                        <% if (request.getAttribute("message") != null) { %>
                        <div class="alert alert-success"><%= request.getAttribute("message") %></div>
                        <% } %>

                        <form action="ChangePasswordServlet" method="post">
                            <div class="mb-3">
                                <label for="cpass" class="form-label">Current Password</label>
                                <input type="password" class="form-control" id="cpass" name="cpass" required>
                            </div>
                            <div class="mb-3">
                                <label for="newpass" class="form-label">New Password</label>
                                <input type="password" class="form-control" id="newpass" name="newpass" required>
                            </div>
                            <div class="mb-3">
                                <label for="cnfpass" class="form-label">Confirm Password</label>
                                <input type="password" class="form-control" id="cnfpass" name="cnfpass" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Change Password</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
 <!-- Footer -->
                <%@include file="footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    // Sidebar toggle
    document.getElementById('sidebarCollapse').addEventListener('click', function () {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('collapsed');
        document.querySelector('.content').classList.toggle('collapsed');
    });
    </script>
    </body>
</html>
