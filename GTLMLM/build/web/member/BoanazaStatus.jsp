<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
include('../includes/config.php');

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Boanaza Status</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css" rel="stylesheet">
  <link href="https://cdn.datatables.net/buttons/2.3.2/css/buttons.dataTables.min.css" rel="stylesheet">

    <link rel="stylesheet" href="style.css">
    <style>
    /* Global Styling */
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f6f9;
    }

    .container {
      margin-top: 0px;
      background-color: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
    }

    h3 {
      font-weight: 600;
      color: #333;
    }

    /* Button Styling */
    .btn-primary {
      background-color: #4b6cb7;
      border: none;
      color: #fff;
      font-weight: 500;
      margin-right: 10px;
      transition: background-color 0.3s ease;
    }

    .btn-primary:hover {
      background-color: #3a5aa6;
    }

    /* DataTable Styling */
    #incomeTable {
      border-collapse: collapse;
      width: 100%;
    }

    #incomeTable th, #incomeTable td {
      text-align: center;
      padding: 12px;
      vertical-align: middle;
    }

    #incomeTable thead th {
      background-color: #4b6cb7;
      color: #fff;
      border-bottom: 2px solid #4b6cb7;
    }

    #incomeTable tbody tr {
      transition: background-color 0.2s ease;
    }

    #incomeTable tbody tr:hover {
      background-color: #f1f5fc;
    }

    #incomeTable tbody td {
      border-top: 1px solid #e1e5eb;
    }

    /* Table Footer */
    .dataTables_info {
      color: #666;
    }

    /* Custom Pagination Styling */
    .dataTables_paginate {
      display: flex;
      justify-content: center;
      margin-top: 15px;
    }

    .dataTables_paginate .paginate_button {
      color: #4b6cb7 !important;
      background-color: #fff !important;
      border: 1px solid #4b6cb7;
      padding: 5px 10px;
      border-radius: 5px;
      margin: 0 3px;
      transition: all 0.3s ease;
    }

    .dataTables_paginate .paginate_button:hover {
      background-color: #4b6cb7 !important;
      color: #fff !important;
    }

    .dataTables_paginate .paginate_button.current {
      background-color: #4b6cb7 !important;
      color: #fff !important;
    }

    /* Search Box */
    .dataTables_filter input {
      border-radius: 20px;
      padding: 8px 20px;
      border: 1px solid #ccc;
      transition: border-color 0.3s ease;
      margin-left: 5px;
    }

    .dataTables_filter input:focus {
      border-color: #4b6cb7;
      outline: none;
    }

    .dataTables_filter label {
      font-weight: 500;
      color: #333;
    }
input[type="text"],
input[type="date"],
input[type="email"],
input[type="number"],
select,
textarea {
    font-size: 0.9rem;
    color: #555;
    border-radius: 6px;
    border: 1px solid #d9dee4;
    padding: 0.6rem;
    transition: border-color 0.3s;
    /*width:200px;*/
}

input[type="text"]:focus,
input[type="date"]:focus,
input[type="email"]:focus,
input[type="number"]:focus,
select:focus,
textarea:focus {
    border-color: #00a2a2;
    box-shadow: 0 0 0 0.2rem rgba(0, 194, 194, 0.2);
    outline: none;
}

.container-fluid {
    overflow-x: hidden;
}

.table-responsive {
    overflow-x: auto; /* Ensures that tables scroll horizontally if needed without affecting the layout */
}

.row {
    margin-right: 0;
    margin-left: 0;
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
      <?php include('navbar.php');?> 
        <div class="content content-wrapper">
            <!--Top Navbar-->
      <?php include('topnavbar.php');?> 
            <!--Main Content page-->

<div class="header">
  <div class="row d-flex flex-wrap align-items-center justify-content-between">
    <div class="col-md-6 col-12 d-flex justify-content-start">
      <!--<span class="title text-truncate">Right Downline</span>-->
    </div>
    <div class="col-md-6 col-12 d-flex justify-content-md-end justify-content-start overflow-hidden">
      <div class="breadcrumb text-nowrap text-truncate ">
        <!--<a href="./account.php" class="breadcrumb-link text-capitalize ">ACCOUNT&nbsp;</a> / <span class="text-uppercase">&nbsp;Right Downline</span>-->
      </div>
    </div>
  </div>
</div>
<!--<hr>-->


 <div class="container" style="margin-top:20px;">
  <!--<h3 class="">Current Income View</h3>-->
  <div class="table-responsive">
    <table id="incomeTable" class="table table-striped table-bordered">
      <thead>
        <tr>
          <th>Sl No.</th>
          <th>Reward Level </th>
          <th>Reward Pairs</th>
          <th>My Pairs</th>
          <th>Reward</th>
          <th>Status </th>
        </tr>
      </thead>
      <tbody>
       <!--<tr><td>1</td><td>Reward - COOLER</td><td>50</td><td>0</td><td>COOLER</td><td>Achieved</td></tr>-->
       <!--<tr><td>2</td><td>Reward - COOLER</td><td>50</td><td>0</td><td>COOLER</td><td>Achieved</td></tr>-->
       <!--<tr><td>3</td><td>Reward - COOLER</td><td>50</td><td>0</td><td>COOLER</td><td>Achieved</td></tr>-->
       <!--<tr><td>4</td><td>Reward - COOLER</td><td>50</td><td>0</td><td>COOLER</td><td>Achieved</td></tr>-->
        
      </tbody>
    </table>
  </div>
</div>
        
        
        
        
        
          <!-- Footer -->
          <?php include('footer.php');?> 
          
        </div>
    </div>

   
<!-- Bootstrap, jQuery, DataTables, and Buttons extension JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.2/js/buttons.print.min.js"></script>

<script>
  $(document).ready(function() {
    $('#incomeTable').DataTable({
      "pagingType": "full_numbers",
      "searching": false,
      "info": true,
      "lengthChange": false,
      dom: 'Bfrtip', // Adds the buttons
      buttons: [
        'copy', 'csv', 'excel', 'print'
      ]
    });
  });
</script>
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
