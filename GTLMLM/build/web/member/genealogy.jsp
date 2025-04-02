<?php
session_start();
error_reporting(0);
error_reporting(E_ALL);
ini_set('display_errors', 1);
$mysponsorid="";
include('../includes/config.php');

$query=mysqli_query($con,"select * from users where id='".$_SESSION['id']."'");
while($row=mysqli_fetch_array($query))
{
    $mysponsorid= $row['user_id'];

}

//echo $mysponsorid;
try{
   $sponsorQuery = "
        SELECT COUNT(user_id) as userCount 
        FROM users 
        WHERE referral = ?
    ";

    // Prepare the query to prevent SQL injection
    $stmt = $con->prepare($sponsorQuery);
    $stmt->bind_param("s", $mysponsorid); // Bind sponsor ID as a string
    $stmt->execute();
    $stmt->bind_result($userCount);
    $stmt->fetch();
    $stmt->close(); // Close the prepared statement

    // Output the number of users referred by the sponsor
    if ($userCount > 0) {
        //echo "Total users referred by '$mysponsorid': $userCount<br>";
    } else {
       // echo "No matching users found.<br>";
    }
// Calculate referral income based on the count
    $referralIncome = 0;
    $ActiveIncome = 0 ;
    if ($userCount == 1) {
        $referralIncome = 200; // Income for 1 referral
    } elseif ($userCount == 2) {
        $referralIncome = 200 * 2; // 200 for each of the 2 users
    } elseif ($userCount >= 3) {
        $referralIncome = 200 * 2 + (($userCount - 2) * 200); // 200 for first 2 users, 400 for each additional user
        $ActiveIncome =  ($userCount - 2) * 200; // 200 for first 2 users, 400 for each additional user
    }

    // Update the referral income in IncomeDetails table for the sponsor
    $updateQuery = "UPDATE IncomeDetails SET ReferIncome = ?, ActiveIncome = ? WHERE user_id = ?";
    $stmtUpdate = $con->prepare($updateQuery);
    $stmtUpdate->bind_param("iis", $referralIncome,$ActiveIncome, $mysponsorid); // Bind referral income as int, mysponsorid as string
    if ($stmtUpdate->execute()) {
       // echo "Referral income for user_id '$mysponsorid' updated successfully to $referralIncome.<br>";
    } else {
        echo "Error updating referral income: " . $stmtUpdate->error . "<br>";
    }

    $stmtUpdate->close(); // Close the prepared statement

} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}




if (isset($_POST['memberId'])) {
    $memberId = $_POST['memberId'];

    // Check if the member ID exists
    $query = mysqli_query($con, "SELECT * FROM users WHERE user_id='$memberId'");
    if (mysqli_num_rows($query) > 0) {
        // Generate genealogy tree for the given member ID
        if (!function_exists('displayTeam')) {
    function displayTeam($sponsorId, $con) {
        echo '<ul>';
        $positions = ['Left', 'Right'];

        foreach ($positions as $position) {
            $query = mysqli_query($con, "SELECT * FROM users WHERE sponsorid='$sponsorId' AND position='$position'");
            if (mysqli_num_rows($query) > 0) {
                while ($row = mysqli_fetch_assoc($query)) {
                    $bgClass = ($row['memberpayed'] === 'PAID') ? 'bg-light-green' : 'bg-light-red';

                    echo '<li>';
                    echo '<div class="admin-node ' . $bgClass . '" 
             data-name="' . $row['name'] . '" 
             data-id="' . $row['user_id'] . '" 
             data-role="' . $position . '"
             data-contactno="' . $row['contactno'] . '"
             data-memberpayed="' . $row['memberpayed'] . '"
             data-regDate="' . $row['regDate'] . '"
             onclick="showDetails(this)">';

             echo '<div class="admin-logo"><i class="fa-regular fa-user"></i></div>';

                    // echo '<div class="admin-node ' . $bgClass . '" 
                    //          data-name="' . $row['name'] . '" 
                    //          data-id="' . $row['user_id'] . '" 
                    //          data-role="' . $position . '"
                    //          data-contactno="' . $row['contactno'] . '"
                    //          data-memberpayed="' . $row['memberpayed'] . '"
                    //          data-regDate="' . $row['regDate'] . '"
                    //          onclick="showDetails(this)">';
                    // echo '<img src="https://cdn3.iconfinder.com/data/icons/black-easy/512/538474-user_512x512.png" class="admin-logo" alt="User">';
                    echo '<span class="admin-name">' . $row['name'] . '</span>';
                    echo '</div>';
                    displayTeam($row['user_id'], $con);
                    echo '</li>';
                }
            } else {
                echo '<li>';
                echo '<div class="admin-node empty-node">
                        <img src="https://cdn3.iconfinder.com/data/icons/black-easy/512/538474-user_512x512.png" class="admin-logo" alt="Empty Node">
                        <span class="admin-name">Empty</span>
                      </div>';
                echo '</li>';
            }
        }
        echo '</ul>';
    }
}


        // Call the function to display genealogy
        displayTeam($memberId, $con);
    } else {
        echo '<p>Member ID not found.</p>';
    }
}









?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Genealogy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.3.2/css/buttons.dataTables.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    

  <!--<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">-->
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f6f9;
       margin: 0;
    padding: 0;
    border-box:box-shadow;
    
    }


.header {
  padding: 15px; /* optional padding for better alignment */
  margin-top:50px;
}

.header .breadcrumb,
.header .title {
  max-width: 100%; /* Ensure the text remains within  bounds */
  overflow: hidden; /* Prevent overflow */
  text-overflow: ellipsis; /* Adds ellipsis to overflowing text */
  white-space: nowrap; /* Prevents wrapping */
}



.tree {
    text-align: center;
    position: relative;
    padding: 0px 0;
}

/* Main tree structure */
.tree ul {
    padding-top: 20px;
    position: relative;
    display: flex;
    justify-content: center; /* Center the child nodes */
    list-style-type: none;
    margin-right: 0px;
}

/* Connecting lines between nodes */
.tree ul::before {
    content: '';
    position: absolute;
    top: 0; /* Starts at the parent node */
    left: 50%;
    /*border-left: 2px solid red;*/
    height: 20px;
    z-index: -1;
}

/* Styling for individual list items (nodes) */
.tree li {
    list-style-type: none;
    text-align: center;
    position: relative;
    padding: 20px 10px 0;
}

/* Horizontal lines connecting siblings */
.tree li::before,
.tree li::after {
    content: '';
    position: absolute;
    top: 0;
    width: 50%;
    border-top: 2px solid #007bff;
    height: 20px;
}

.tree li::before {
    right: 50%;
    border-right: 2px solid #007bff; /* Left connection line */
}

.tree li::after {
    left: 50%;
    border-left: 2px solid #007bff;
}

/* Remove lines for single child nodes */
.tree li:only-child::before,
.tree li:only-child::after {
    display: none;
}

.tree li:only-child {
    padding-top: 0px;
}

/* Center alignment for root node and leaf nodes */
.tree li:first-child::before,
.tree li:last-child::after {
    border: 0;
}

/* Additional styling for child nodes */
.tree li > ul::before {
    content: '';
    position: absolute;
    top: 0; /* Starts at the parent node */
    left: 52%;
    border-left: 2px solid #007bff;
    /*height: 102px;*/
}

/* Styling for the admin node (box) */
.admin-node {
    /*padding: 5px;*/
    text-align: center;
    /*border: 2px solid #007bff;*/
    /*border-radius: 8px;*/
    /*background-color: #f9f9f9;*/
    display: inline-block;
    transition: transform 0.3s ease;
    /*box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.1);*/
    /*max-width:130px;*/
    /*min-width:100px;*/
    /*min-height:90px;*/
    /*max-height:80px;*/
    margin: 0 auto; /* Ensures it's centered */
    position: relative; /* To handle absolute positioning of child elements */
    font-size:15px !important;
    
}

/* Hover effect for admin node */
.admin-node:hover {
    transform: scale(1.05); /* Hover effect to zoom */
}

/* Admin logo (profile image) */
.admin-logo {
    display: block;
    margin: 0 auto 10px;
    max-width: 30px;
    height: 30px;
    border-radius: 50%;
    /*border: 2px solid #007bff;*/
}

/* Admin name */
.admin-name {
    font-size: 15px;
    /*font-weight: bold;*/
    /*color: #007bff;*/
    color:white;
    margin-top: 10px;
}

/* Left-side node styling */
.left-node .admin-node {
    background-color: #e8f5e9;
    border-color: #4caf50;
    width:400px !important;
    
    
}

.left-node .admin-name {
    color: black;
     width:400px !important;
     margin-left:200px;
    
}

/* Right-side node styling */
.right-node .admin-node {
    background-color: #ffebee;
    border-color: black;
}

.right-node .admin-name {
    color: black;
}

/* Responsiveness */


/* Modal Styles */
.modal {
    display: none; /* Hidden by default */
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1050;
    background: white;
    border-radius: 8px;
    box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
    width: 400px;
    max-width: 90%;
    height:400px;
}

.modal-dialog {
    display: flex;
    flex-direction: column;
}

.modal-header {
    padding: 10px;
    border-bottom: 1px solid #ddd;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-title {
    font-size: 18px;
    margin: 0;
}

.modal-body {
    padding: 15px;
    font-size: 15px;
}

.modal-footer {
    padding: 10px;
    border-top: 1px solid #ddd;
    display: flex;
    justify-content: flex-end;
}

.modal-footer .btn {
    background: #007bff;
    color: black;
    padding: 5px 10px;
    border: none;
    cursor: pointer;
    border-radius: 4px;
}

.modal-footer .btn:hover {
    background: #0056b3;
}

.close {
    cursor: pointer;
    background: none;
    border: none;
    font-size: 20px;
}


@media screen and (max-width: 768px) {
    .tree {
        overflow-x: auto; 
        overflow-y: auto;
        white-space: nowrap; 
        padding-left:00px;
    }

    .tree ul {
        flex-wrap: nowrap;
        /*margin-right:-100px;*/
    }

    .tree li {
        display: inline-block;
        vertical-align: top;
        
    }

    .admin-node {
        padding: 10px;
        margin: 0 auto;
    }

    .admin-logo {
        width: 30px;
        height: 30px;
    }

    .admin-name {
        font-size: 15px;
    }
   
}


/* Wrapper for horizontal scrolling */
.tree-wrapper {
    overflow-x: auto; /* Allow horizontal scrolling */
    overflow-y: hidden; /* Disable vertical scrolling */
    white-space: nowrap; /* Prevent wrapping of the tree */
    width: 100%; /* Ensure it spans the full viewport width */
}

/* Mobile-specific styles */
@media (max-width: 768px) {
    .tree-wrapper {
        overflow-x: auto; /* Ensure horizontal scrolling on mobile */
        padding: 10px; /* Add some padding for better spacing */
    }

    .tree.container1 {
        transform: scale(0.65); /* Scale tree to 59% for mobile view */
        transform-origin: top left; /* Adjust scaling origin */
        width: max-content; /* Prevent tree from shrinking to the wrapper size */
    }
}



/* Left position background */
/*.bg-left {*/
/*    background-color: #e8f5e9;*/
/*    border-color: #4caf50;  */
/*}*/


/*.bg-right {*/
/*    background-color: #ffebee; */
/*    border-color: #f44336;   */
/*}*/




/* Admin logo */
.admin-logo {
    display: block;
    margin: 0 auto 10px;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    /*border: 2px solid #007bff;*/
}

/* Admin name */
.admin-name {
    font-size: 15px;
    /*font-weight: bold;*/
    color: #007bff;
    margin-top: 10px;
}

.admin-node.bg-light-green {
    /*background-color: lightgreen;*/
    color:lightgreen;
    padding: 2px;
    /*border:1px solid green;*/
    /*width:35px;*/
    /*height:35px;*/
    /*border-radius: 10%;*/
    /*text-align: center;*/
    /*align-items: center;*/
    transition: background-color 0.3s ease, box-shadow 0.3s ease;
    cursor: pointer;
    
}

.admin-node.bg-light-red {
    /*background-color: lightcoral;*/
    color:lightcoral;
    padding: 2px;
    /*border:1px solid red;*/
    /*width:35px;*/
    /*height:35px;*/
    /*border-radius: 50%;*/
    /*margin-right    :200px;*/
    /*text-align: center;*/
    /*align-items: center;*/
    transition: background-color 0.3s ease, box-shadow 0.3s ease;
    cursor: pointer;
}


  </style>
  
</head>
<body>
    
    <script>
        function searchGenealogy() {
    const memberId = document.getElementById('searchMemberId').value.trim();
    console.log('Searching genealogy for Member ID:', memberId);
    if (!memberId) {
        alert('Please enter a valid Member ID.');
        return;
    }

    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'GenealogyForMember.php', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

    xhr.onload = function () {
        console.log('Response received:', this.responseText); // Log the server response
        if (this.status === 200) {
            document.getElementById('genealogyTree').innerHTML = this.responseText;
        } else {
            alert('Error fetching genealogy. Please try again.');
        }
    };

    xhr.onerror = function () {
        alert('AJAX request failed.');
    };

    xhr.send('memberId=' + encodeURIComponent(memberId));
}

    </script>
    
    <!-- Sidebar -->
    <div class="d-flex">
     <!--Navbar-->
      <?php  include('navbar.php');?> 
        <div class="content content-wrapper">
            <!--Top Navbar-->
      <?php  include('topnavbar.php');?> 
            <!--Main Content page-->

                <div class="header">
                  <div class="row d-flex flex-wrap align-items-center justify-content-between">
                    <div class="col-md-6 col-12 d-flex justify-content-start">
                      <!--<span class="title text-truncate">My Genealogy</span>-->
                    </div>
                    <div class="col-md-6 col-12 d-flex justify-content-md-end justify-content-start overflow-hidden">
                      <div class="breadcrumb text-nowrap text-truncate ">
                        <!--<a href="./account.php" class="breadcrumb-link text-capitalize ">ACCOUNT&nbsp;</a> / <span class="text-uppercase">&nbsp;My Genealogy</span>-->
                      </div>
                    </div>
                  </div>
                </div>

<!--<p>Note:- In Green: Left Side Member <br>Note:- In Red: Right Side Member </p>-->

   <?php
$query=mysqli_query($con,"select * from users where id='".$_SESSION['id']."'");
while($row=mysqli_fetch_array($query))
{
?>

 <input type="hidden"
                                                            class="form-control unicase-form-control text-input"
                                                            value="<?php $mysponsorid= $row['user_id'];?>" id="user_id"
                                                            name="user_id" required="required">
                                                            
                                                             <?php } ?>

     
<div class="">
  <!-- start tree structure -->
<div class="">
    

    <!-- Add a wrapper div around the tree -->
<div class="tree-wrapper">
<div class="tree container1">
    <!-- Search Functionality -->
    <div class="search-container">
        <!--<input type="text" id="searchMemberId" placeholder="Enter Member ID" />-->
        <!--<button onclick="searchGenealogy()">Search</button>-->
    </div>
    
    <ul id="genealogyTree">
        <li>
            <!-- Main Admin Node -->
            <div class="admin-node"
                 data-name="<?php echo $userRow['name'] ?? 'User Name'; ?>"
                 data-id="<?php echo $mysponsorid; ?>"
                 data-role="Admin"
                 onclick="showDetails(this)" style="margin-left:40px;">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpBFbCgb0ajYdgdzEXKZ3Kg7y1Lc3upM0IDg&s" 
                     class="admin-logo" alt="Admin">
                <span class="admin-name">
                    <?php
                    $userQuery = mysqli_query($con, "SELECT name FROM users WHERE user_id='$mysponsorid'");
                    echo mysqli_num_rows($userQuery) > 0 
                         ? mysqli_fetch_assoc($userQuery)['name'] 
                         : "User Name";
                    ?>
                </span>
            </div>

            <!-- Recursive Function -->
            <?php
            function displayTeam($sponsorId, $con, $currentDepth = 1, $maxDepth = 3) {
                if ($currentDepth > $maxDepth) return;

                echo '<ul>';
                $positions = ['Left', 'Right'];

                foreach ($positions as $position) {
                    $query = mysqli_query($con, "SELECT * FROM users WHERE sponsorid='$sponsorId' AND position='$position'");
                    if (mysqli_num_rows($query) > 0) {
                        while ($row = mysqli_fetch_assoc($query)) {
                            $bgClass = ($row['memberpayed'] === 'PAID') ? 'bg-light-green' : 'bg-light-red';
                            
                            
                            echo '<li>';
echo '<div class="admin-node ' . $bgClass . '" 
             data-name="' . htmlspecialchars($row['name']) . '" 
             data-id="' . htmlspecialchars($row['user_id']) . '" 
             data-role="' . htmlspecialchars($position) . '"
             data-contactno="' . htmlspecialchars($row['contactno']) . '"
             data-memberpayed="' . htmlspecialchars($row['memberpayed']) . '"
             data-regDate="' . htmlspecialchars($row['regDate']) . '"
             onclick="showDetails(this)">';

// Replacing img with the new icon
echo '<i class="fa-solid fa-user admin-logo" style="font-size: 24px;"></i>';

// Displaying the admin name
echo '<span class="admin-name" style="font-size: 14px; color:black;">' . htmlspecialchars($row['name']) . '</span>';

echo '</div>';

// Recursively calling the displayTeam function
displayTeam($row['user_id'], $con, $currentDepth + 1, $maxDepth);

echo '</li>';


                        //     echo '<li>';
                        //     echo '<div class="admin-node ' . $bgClass . '" 
                        //                  data-name="' . $row['name'] . '" 
                        //                  data-id="' . $row['user_id'] . '" 
                        //                  data-role="' . $position . '"
                        //                  data-contactno="' . $row['contactno'] . '"
                        //                  data-memberpayed="' . $row['memberpayed'] . '"
                        //                  data-regDate="' . $row['regDate'] . '"
                        //                  onclick="showDetails(this)">';
                        //     echo '<img src="https://cdn3.iconfinder.com/data/icons/black-easy/512/538474-user_512x512.png" class="admin-logo" alt="User">';
                        //   echo '<span class="admin-name" style="font-size: 14px; color:black;">' . htmlspecialchars($row['name']) . '</span>';
                        //     echo '</div>';
                        //     displayTeam($row['user_id'], $con, $currentDepth + 1, $maxDepth);
                        //     echo '</li>';
                        }
                    } else {
                        echo '<li>';
                        echo '<div class="admin-node empty-node">
                                <img src="https://cdn3.iconfinder.com/data/icons/black-easy/512/538474-user_512x512.png" class="admin-logo" alt="Empty Node">
                                <span class="admin-name">Empty</span>
                              </div>';
                        echo '</li>';
                    }
                }
                echo '</ul>';
            }

            // Display genealogy for the default sponsor ID
            if (isset($mysponsorid)) {
                displayTeam($mysponsorid, $con);
            } else {
                echo '<p>Sponsor ID not set.</p>';
            }
            ?>
        </li>
    </ul>
</div>

</div>

</div>
</div>
</div>

<!-- close My Team -->







<!-- User Details Modal -->
<div id="userDetailsModal" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">User Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal()">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p><strong>Name:</strong> <span id="modalName"></span></p>
                <p><strong>ID:</strong> <span id="modalID"></span></p>
                <p><strong>Role:</strong> <span id="modalRole"></span></p>
                <p><strong>Mobile Number:</strong> <span id="modalcontactno"></span></p>
                <p><strong>Member Status:</strong> <span id="modalmemberpayed"></span></p>
                <p><strong>Joining Date :</strong> <span id="modalregDate"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn" onclick="closeModal()" style="background-color: #13274F; color:white;">Close</button>
            </div>
        </div>
    </div>
</div>



    
</div>







                        

</div> 
        
        
          <!-- Footer -->
  
        </div>
        
    </div>
     <?php include('footer.php');?> 

   
<!-- Bootstrap, jQuery, DataTables, and Buttons extension JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.2/js/buttons.print.min.js"></script>


<script>


     document.getElementById('sidebarCollapse').addEventListener('click', function () {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('collapsed');
            document.querySelector('.content').classList.toggle('collapsed');
        });



// Function to populate and show modal with user details
function showDetails(element) {
    const name = element.getAttribute('data-name');
    const id = element.getAttribute('data-id');
    const role = element.getAttribute('data-role');
    const contactno = element.getAttribute('data-contactno');
    const memberpayed = element.getAttribute('data-memberpayed');
    const regDate = element.getAttribute('data-regDate');

    document.getElementById('modalName').innerText = name;
    document.getElementById('modalID').innerText = id;
    document.getElementById('modalRole').innerText = role;
    document.getElementById('modalcontactno').innerText = contactno;
    document.getElementById('modalmemberpayed').innerText = memberpayed;
    document.getElementById('modalregDate').innerText = regDate;

    // Display the modal
    document.getElementById('userDetailsModal').style.display = 'block';
}

// Function to close the modal
function closeModal() {
    document.getElementById('userDetailsModal').style.display = 'none';
}

</script>

</body>
</html>

</body>
</html>
