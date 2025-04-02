<?php
session_start();
error_reporting(0);
$mysponsorid="";
include('../includes/config.php');

?>
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

    /* Custom styling */
    .container {
      margin-top: 20px;
    }
    .form-container {
      background: #f8f9fa;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
    }
    .profile-img {
      width: 100%;
      height: auto;
      max-width: 200px;
      border-radius: 5px;
      border: 1px solid #ddd;
      margin: 0 auto;
    }
    .btn-submit {
      background-color: #17a2b8;
      color: white;
    }
    .table-container {
      margin-top: 20px;
      padding: 20px;
      background: #fff;
      border-radius: 5px;
      box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
    }
    .table-responsive {
      overflow-x: auto;
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
      <?php include('navbar.php');?> 
        <div class="content content-wrapper">
            <!--Top Navbar-->
      <?php include('topnavbar.php');?> 
            <!--Main Content page-->
          <div class="my-2">
<div class="header">
  <div class="row d-flex flex-wrap align-items-center justify-content-between">
    <div class="col-md-6 col-12 d-flex justify-content-start">
      <span class="title text-truncate">TopUp Wallet Request</span>
    </div>
    <div class="col-md-6 col-12 d-flex justify-content-md-end justify-content-start overflow-hidden">
      <div class="breadcrumb text-nowrap text-truncate">
        <a href="./account.php" class="breadcrumb-link">ACCOUNT&nbsp;</a> / <span>&nbsp;TOPUP WALLET REQUEST</span>
      </div>
    </div>
  </div>
</div>




<div class="container">
  <!-- Form Section -->
  <div class="form-container">
    <div class="row">
      <!-- Profile Image -->
      <div class="col-md-4 text-center">
        <img src="https://binary.senzense.com/Admin/assets/images/Dummy.png" alt="Profile Image" class="profile-img">
      </div>
      <!-- Form Fields -->
      <div class="col-md-8">
        <form>
          <div class="form-row">
            <div class="row mb-2">
                <div class="col-md-6">
                    <label for="memberId">Member ID:</label>
                    <input type="text" class="form-control" id="memberId" value="300001" disabled>
                </div>
                <div class="col-md-6">
                    <label for="name">Name:</label>
                     <input type="text" class="form-control" id="name" value="Akash Kumar" disabled>
                </div>
            </div>
              
              
           
          <div class="row mb-2">
            <div class="form-group col-md-6">
              <label for="amount">Amount:</label>
              <input type="number" class="form-control" id="amount" placeholder="Enter amount">
            </div>
            <div class="form-group col-md-6">
              <label for="payMode">Pay Mode:</label>
              <input type="text" class="form-control" id="payMode" value="Imps Transfer (Inr)">
            </div>
          </div>
          <div class="row mb-2">
            <div class="form-group col-md-6">
              <label for="transNo">Trans. No.:</label>
              <input type="text" class="form-control" id="transNo" placeholder="Transaction Number">
            </div>
            <div class="form-group col-md-6">
              <label for="paymentRemarks">Payment Remarks:</label>
              <textarea class="form-control" id="paymentRemarks" rows="1"></textarea>
            </div>
          </div>
          <div class="row mb-2">
            <div class="form-group col-md-6">
              <label for="receipt">Receipt:</label>
              <input type="file" class="form-control-file" id="receipt">
            </div>
            <div class="form-group col-md-6 align-self-end text-right">
              <button type="submit" class="btn btn-submit">Request For Wallet</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- Table Section -->
  <div class="table-container">
    <div class="d-flex justify-content-between align-items-center">
      <h5>Transaction History</h5>
      <div>
        <button class="btn btn-outline-primary btn-sm">Copy</button>
        <button class="btn btn-outline-primary btn-sm">CSV</button>
        <button class="btn btn-outline-primary btn-sm">Excel</button>
        <button class="btn btn-outline-primary btn-sm">Print</button>
      </div>
    </div>
    <div class="table-responsive">
      <table class="table table-bordered table-hover mt-3">
        <thead class="thead-light">
          <tr>
            <th>Sl No.</th>
            <th>Date</th>
            <th>MID</th>
            <th>Name</th>
            <th>Amount</th>
            <th>Pay Mode</th>
            <th>Transaction No.</th>
            <th>Status</th>
            <th>Payment Remarks</th>
            <th>Receipt</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>09/Oct/2024 11:02:42</td>
            <td>300001</td>
            <td>Akash Kumar</td>
            <td>500000.00</td>
            <td>Imps Transfer (Inr)</td>
            <td>123456</td>
            <td>Approved</td>
            <td>need fund</td>
            <td><img src="https://via.placeholder.com/50" alt="Receipt" class="img-fluid"></td>
          </tr>
          <tr>
            <td>2</td>
            <td>09/Oct/2024 11:14:40</td>
            <td>300001</td>
            <td>Akash Kumar</td>
            <td>100000.00</td>
            <td>Imps Transfer (Inr)</td>
            <td>666666</td>
            <td>Approved</td>
            <td>request</td>
            <td><img src="https://via.placeholder.com/50" alt="Receipt" class="img-fluid"></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>



        
    </div>


          <!-- Footer -->
          <?php include('footer.php');?> 
          
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
