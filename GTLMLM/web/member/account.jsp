<!--<?php
session_start();
error_reporting(0);
$mysponsorid="";
include('./includes/config.php');

if(strlen($_SESSION['login'])==0)
    {   
header('location:../mainlogin.php');
}
else{
?>-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MLM </title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Collapsible Sidebar with Navbar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">

    
</head>
<body>
    <!-- Sidebar -->
    <div class="container-my d-flex">
        <%@include file="navbar.jsp" %>
                <!--<?php include('navbar.php');?>--> 

        <div class="content content-wrapper">
            <%@include file="topnavbar.jsp" %>
              <!--<?php include('topnavbar.php');?>--> 

              <!--Main Content page-->
              <%@include file="cards.jsp" %>
              <!--<?php include('cards.php');?>--> 


              <!-- Footer -->
              <%@include file="footer.jsp" %>
              <!--<?php include('footer.php');?>--> 
            


        </div>
    </div>

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

