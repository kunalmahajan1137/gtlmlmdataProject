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
    <title>My Complain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css" rel="stylesheet">
  <link href="https://cdn.datatables.net/buttons/2.3.2/css/buttons.dataTables.min.css" rel="stylesheet">

    <link rel="stylesheet" href="style.css">
    <style>

/* General body styling */
body {
    background-color: #f8f9fc; /* Light gray background */
    font-family: Arial, sans-serif;
}

/* Container and Card Styling */
.card {
    border: none;
    border-radius: 10px;
}

/* Submit Button Styling */
.submit-btn {
    background-color: #20c997; /* Greenish color to match design */
    border: none;
    font-weight: bold;
    color: #ffffff;
}

/* Output Display Styling */
.output-area {
    height: 200px; /* Set height to create a large white area */
    background-color: #ffffff;
    border: 1px solid #dee2e6;
    border-radius: 10px;
    overflow-y: auto;
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
      <span class="title text-truncate">My Complain</span>
    </div>
    <div class="col-md-6 col-12 d-flex justify-content-md-end justify-content-start overflow-hidden">
      <div class="breadcrumb text-nowrap text-truncate ">
        <a href="./account.php" class="breadcrumb-link text-capitalize ">ACCOUNT&nbsp;</a> / <span class="text-uppercase">&nbsp;My Complain</span>
      </div>
    </div>
  </div>
</div>
<hr>

     <div class="container my-5">
        <!-- Complain Form Section -->
        <div class="card p-4 mb-4 shadow-sm">
            <form id="complainForm">
                <div class="form-group">
                    <label for="complainText">Complain</label>
                    <textarea class="form-control" id="complainText" rows="3" placeholder="Enter your complaint here..."></textarea>
                </div>
                <button type="submit" class="btn btn-primary submit-btn">Submit</button>
            </form>
        </div>

        <!-- Output Display Section -->
        <div class="card p-4 shadow-sm">
            <div id="outputDisplay" class="output-area">
                <!-- Displayed content will go here -->
            </div>
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
 document.getElementById('complainForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent page reload on form submit
    
    // Get the complaint text value
    const complainText = document.getElementById('complainText').value;

    // Display the complaint text in the output area
    const outputDisplay = document.getElementById('outputDisplay');
    outputDisplay.innerHTML = `<p>${complainText}</p>`;
    
    // Clear the textarea after submission
    document.getElementById('complainText').value = '';
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
