<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Letter</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
/* General Styling */
body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    margin: 0;
    padding: 0;
    background-color: #f9f9f9;
}

.container {
    max-width: 900px;
    margin: 20px auto;
    padding: 20px;
    background: #ffffff;
    border: 1px solid #ddd;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 2px solid #007bff;
    padding-bottom: 20px;
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

.logo h1 {
    color: #007bff;
    font-size: 24px;
    margin: 0;
}

.logo p {
    margin: 0;
    font-size: 14px;
    color: #333;
}

.company-info h2 {
    font-size: 18px;
    color: #b55108;
    margin: 0;
}

.company-info p {
    font-size: 14px;
    color: #555;
}

.welcome-title {
    text-align: center;
    color: #007bff;
    font-size: 24px;
    margin: 20px 0;
}

.greeting {
    text-align: center;
    font-size: 20px;
    color: #333;
}

.greeting span {
    color: #007bff;
    font-weight: bold;
}

.intro-text {
    margin: 10px 0;
    color: #555;
}

.section-title {
    text-align: center;
    color: #007bff;
    font-size: 20px;
    margin: 20px 0;
}

.account-info {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    border:1px solid gray;
}

.account-info td {
    border: 1px solid #ddd;
    padding: 10px;
    font-size: 14px;
    border:1px solid gray;
}

.account-info td:first-child {
    font-weight: bold;
    border:1px solid gray;
}

.important {
    margin-top: 20px;
    font-size: 14px;
    color: #d9534f;
}

.closing {
    margin-top: 30px;
    font-size: 14px;
    color: #333;
}

.disclaimer {
    font-size: 12px;
    color: #555;
    text-align: center;
    margin-top: 20px;
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

/* Add this to your existing CSS file or within a <style> tag */
@media screen and (max-width: 768px) {
    /* Adjusting container padding for mobile */
    .container {
        padding: 10px;
    }
    
    /* Stack the header elements vertically */
    header {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .logo {
        text-align: center;
        margin-bottom: 10px;
    }

    .company-info {
        text-align: center;
        margin-bottom: 20px;
    }

    /* Adjust title size */
    .welcome-title {
        font-size: 24px;
        text-align: center;
    }

    /* Modify greeting text size */
    .greeting {
        font-size: 18px;
        text-align: center;
    }

    .intro-text {
        font-size: 14px;
        line-height: 1.6;
        margin: 10px 0;
    }

    /* Table layout for smaller screens */
    .account-info {
        width: 100%;
        border-collapse: collapse;
    }

    .account-info th,
    .account-info td {
        padding: 8px;
        text-align: left;
        font-size: 14px;
    }

    .account-info th {
        width: 50%;
        text-align: left;
    }

    .important {
        font-size: 14px;
        color: red;
        font-weight: bold;
    }

    /* Adjust footer and disclaimer */
    .cpfooter {
        text-align: center;
        margin-top: 20px;
    }

    .disclaimer {
        font-size: 12px;
        color: #777;
    }
}

/* General table styles */
.account-info {
    width: 100%;
    border-collapse: collapse;
    margin: 10px 0;
    table-layout: fixed; /* Ensures the table columns don't overflow */
}

.account-info th,
.account-info td {
    padding: 10px;
    border: 1px solid #ddd; /* Adds a border to each cell */
    text-align: left;
    font-size: 14px;
    word-wrap: break-word; /* Ensures long text wraps within the cell */
}

.account-info th {
    width: 25%; /* Set a fixed width for th */
    background-color: #f4f4f4; /* Light background for the header */
}

.account-info td {
    width: 25%; /* Set a fixed width for td */
}

/* Responsive adjustments for smaller screens */
@media screen and (max-width: 768px) {
    .account-info th,
    .account-info td {
        font-size: 12px; /* Smaller font size on mobile */
        padding: 8px; /* Less padding on mobile */
    }

    /* Adjust table to take full width on small screens */
    .account-info {
        width: 100%;
    }

    /* Ensure text doesn't overflow */
    .account-info td {
        word-wrap: break-word;
    }
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
          <div class=" my-2">

                <div class="header">
                  <div class="row d-flex flex-wrap align-items-center justify-content-between">
                    <div class="col-md-6 col-12 d-flex justify-content-start">
                      <!--<span class="title text-truncate">Welcome Letter</span>-->
                    </div>
                    <div class="col-md-6 col-12 d-flex justify-content-md-end justify-content-start overflow-hidden">
                      <div class="breadcrumb text-nowrap text-truncate">
                        <!--<a href="./account.php" class="breadcrumb-link">ACCOUNT&nbsp;</a> / <span>&nbsp;Welcome Letter</span>-->
                      </div>
                    </div>
                  </div>
                </div>


<!---->

        <div class="container p-3 content-centers" style="margin-bottom:80px;">
        <header>
            <div class="logo">
                <h1>CP Solution</h1>
                <p>CORPORATION</p>
            </div>
            <div class="company-info">
                <h2>CP Solution PVT. LTD.</h2>
                <p>Customer Support: <a href="mailto:info@cp-solution.com">info@cp-solution.com</a></p>
            </div>
        </header>

        <h1 class="welcome-title">Welcome Letter</h1>
        <h2 class="greeting">HEARTIEST CONGRATULATION <span><?php echo $user_name; ?></span> WELCOME TO 'CP Solution PVT. LTD.' FAMILY</h2>

        <p class="intro-text">
            Dear Customer,
        </p>
        <p class="intro-text">
            Welcome to CP Solution PVT. LTD. We hope you will not only benefit by using our products & services but also create true wealth for your commitment and contribution towards adding right values in the society with us.
        </p>
         <p class="intro-text">
            We look forward to creating a long-term mutually beneficial working relationship with each other and a prosperous future. You are now a proud member of "CP Solution PVT. LTD." Group.
        </p>
        
        <p class="intro-text">
            Please find the below-mentioned details of your Plot Booking with CP Solution PVT. LTD. Group.
        </p>

        <h2 class="section-title text-center">ACCOUNT INFORMATION</h2>
        <table class="table table-bordered">
            <tr>
                <th>Member ID:</th>
                <td><%= request.getAttribute("userId") %></td>
                <th>Member Name:</th>
                <td><%= request.getAttribute("userName") %></td>
            </tr>
            <tr>
                <th>Address:</th>
                <td><%= request.getAttribute("address") %></td>
                <th>City:</th>
                <td><%= request.getAttribute("city") %></td>
            </tr>
            <tr>
                <th>State:</th>
                <td><%= request.getAttribute("state") %></td>
                <th>Pincode:</th>
                <td><%= request.getAttribute("pincode") %></td>
            </tr>
            <tr>
                <th>Mobile No.:</th>
                <td><%= request.getAttribute("contactNo") %></td>
                <th>Email:</th>
                <td><%= request.getAttribute("email") %></td>
            </tr>
            <tr>
                <th>Father's Name:</th>
                <td><%= request.getAttribute("fatherName") %></td>
                <th>Nominee Name:</th>
                <td><%= request.getAttribute("nomineeName") %></td>
            </tr>
            <tr>
                <th>Relation:</th>
                <td><%= request.getAttribute("relation") %></td>
                <th>Joining Date:</th>
                <td><%= request.getAttribute("joiningDate") %></td>
            </tr>
            <tr>
                <th>Package:</th>
                <td><%= request.getAttribute("package") %></td>
                <th>Price:</th>
                <td><%= request.getAttribute("price") %></td>
            </tr>
        </table>

        <p class="important text-danger">Important: Please be sure to change your password to ensure account security.</p>

        <p class="closing">
            Yours Sincerely,<br>
            <strong>CP Solution PVT. LTD. TEAM</strong><br>
            <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %>
        </p>

        <div class="text-center text-muted">
            <p class="disclaimer">(This is only a welcome letter; it is not considered a receipt.)</p>
        </div>
    </div>


<!---->
    
        
        
        
        
    </div>


          <!-- Footer -->
          <%@include file="footer.jsp" %>
        
          
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
