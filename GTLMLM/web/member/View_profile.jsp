<!--<?php
session_start();
error_reporting(0);
$mysponsorid="";
include('../includes/config.php');
?>-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Retrieve user data from request attribute
    Map<String, String> userData = (Map<String, String>) request.getAttribute("userData");

    if (userData == null) {
        response.sendRedirect("error.jsp"); // Redirect if no data is found
        return;
    }
%>
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

    /* General Styling */
    body {
      background-color: #f8fafc;
      font-family: 'Arial', sans-serif;
      color: #333;
    }
    .container {
      margin-top: 20px;
    }
    
    .profile-card {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
    }
    .header-text {
      font-size: 1.5rem;
      font-weight: bold;
      color: #4a4a4a;
    }
    .section-title {
      font-size: 1.2rem;
      font-weight: 600;
      color: #333;
      border-bottom: 2px solid #00c7b7;
      padding-bottom: 5px;
      margin-top: 20px;
    }
    .info-label {
      font-weight: bold;
      color: #555;
    }
    .info-value {
      color: #666;
    }
    .edit-profile-btn {
      background-color: #00c7b7;
      color: #fff;
      font-weight: bold;
      border: none;
      padding: 8px 20px;
      border-radius: 5px;
      margin-top: 20px;
    }
    .edit-profile-btn:hover {
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






  <div class="container content-center">
    <div class="profile-card">
<!--     Header Section -->
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="header-text">My Profile</h2>
        <a href="#" class="text-primary">ACCOUNT / MY PROFILE</a>
      </div>

      <!-- Welcome Section -->
      <div class="d-flex align-items-center">
        <span class="mr-2"><i class="fas fa-user"></i> WELCOME :</span>
        <h5 class="mb-0 text-uppercase font-weight-bold text-success"> <%= userData.get("sponsorname") %></h5>
      </div>

      <!-- Account Details Section -->
      <div class="section-title">Account details:</div>

      <div class="row mt-3">
        <!--<div class="col-md-3">-->
        <!--  <span class="info-label">spanrofile spanicture:</span>-->
        <!--  <img src="httspans://via.spanlaceholder.com/100" alt="spanrofile Picture" class="img-fluid border rounded">-->
        <!--</div>-->
        <div class="col-md-3">
          <p class="info-label">Member's ID:</p>
          <p class="info-value"><%= userData.get("user_id") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">User name:</p>
         <p class="info-value"><%= userData.get("name") %></p>

        </div>
        <div class="col-md-3">
          <p class="info-label">Sponsor ID:</p>
         <p class="info-value"><%= userData.get("sonserid") %></p>
        </div>
         <div class="col-md-3">
          <p class="info-label">Referral ID:</p>
         <p class="info-value"><%= userData.get("referralid") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Father's Name:</p>
         <p class="info-value"><%= userData.get("fathername") %></p>
        </div>
         <div class="col-md-3">
          <p class="info-label">Husband name:</p>
         <p class="info-value"><%= userData.get("husbundname") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Password:</p>
          <p class="info-value"><%= userData.get("password") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Member type:</p>
          <p class="info-value"><%= userData.get("member") %></p>
        </div>
      </div>

      <!-- Personal Details Section -->
      <div class="section-title">Personal details:</div>
      <div class="row mt-3">
        <div class="col-md-3">
          <p class="info-label">Name:</p>
        <p class="info-value"><%= userData.get("name") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Date of birth:</p>
         <p class="info-value"><%= userData.get("dob") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Address 1:</p>
          <p class="info-value"><%= userData.get("address1") %></p>
        </div>
         <div class="col-md-3">
          <p class="info-label">Address 2:</p>
          <p class="info-value"><%= userData.get("address2") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Pincode:</p>
         <p class="info-value"><%= userData.get("pincode") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">City:</p>
     <p class="info-value"><%= userData.get("city") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">State:</p>
         <p class="info-value"><%= userData.get("state") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Country:</p>
         <p class="info-value"><%= userData.get("country") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Mobile:</p>
       <p class="info-value"><%= userData.get("conctactno") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Gender:</p>
      <p class="info-value"><%= userData.get("gender") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Date of joining:</p>
          <p class="info-value"><%= userData.get("dateofjoining") %></p>
        </div>
       
        <!--<div class="col-md-3">-->
        <!--  <p class="info-label">Nominee:</p>-->
        <!--    <p class="info-value"><?php // echo $row['nomineename']; ?></p>-->
        <!--</div>-->
        <!-- <div class="col-md-3">-->
        <!--  <p class="info-label">Relation:</p>-->
        <!--    <p class="info-value"><?php // echo $row['relation']; ?></p>-->
        <!--</div>-->
        <!-- <div class="col-md-3">-->
        <!--  <p class="info-label">Nominee Percentage:</p>-->
        <!--    <p class="info-value"><?php // echo $row['nomineepercentage']; ?></p>-->
        <!--</div>-->
        <div class="col-md-3">
          <p class="info-label">Phone:</p>
             <p class="info-value"><%= userData.get("conctactno") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Email:</p>
            <p class="info-value"><%= userData.get("email") %></p>
        </div>
      </div>

      <!-- Bank Details Section -->
      <div class="section-title">Bank details:</div>
      <div class="row mt-3">
        <div class="col-md-3">
          <p class="info-label">Bank name:</p>
           <p class="info-value"><%= userData.get("bankname") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Branch address:</p>
          <p class="info-value"><%= userData.get("brachadd") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Account No.:</p>
          <p class="info-value"><%= userData.get("accountno") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Account type:</p>
           <p class="info-value"><%= userData.get("accounttype") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Account holder:</p>
          <p class="info-value"><%= userData.get("accountholdername") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">IFSC:</p>
           <p class="info-value"><%= userData.get("IFSCCode") %></p>
        </div>
       
        <div class="col-md-3">
          <p class="info-label">PAN No:</p>
          <p class="info-value"><%= userData.get("PANno") %></p>
        </div>
        <div class="col-md-3">
          <p class="info-label">Email verification status:</p>
          <p class="info-value">Not verified</p>
        </div>
      </div>

      <!-- Edit Profile Button -->
      <div class="text-right">
          <a href="EditProfileServlet" class="text-light ps-4">
        <button class="edit-profile-btn">Edit profile</button></a>
      </div>
    </div>
  </div>




        
    </div>
           <!-- Footer -->
                <%@include file="footer.jsp" %>
        </div>
    </div>

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
