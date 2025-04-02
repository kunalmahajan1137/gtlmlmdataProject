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


if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['memberId'])) {
    $memberId = mysqli_real_escape_string($con, $_POST['memberId']);

    // Query to get the user information based on the searched member ID
    $query = mysqli_query($con, "SELECT * FROM users WHERE user_id='$memberId'");

    if (mysqli_num_rows($query) > 0) {
        $user = mysqli_fetch_assoc($query);
        echo '<ul>';
        echo '<li>';
        echo '<div class="admin-node" data-name="' . $user['name'] . '" data-id="' . $user['user_id'] . '" data-role="Admin" onclick="showDetails(this)">';
        echo '<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpBFbCgb0ajYdgdzEXKZ3Kg7y1Lc3upM0IDg&s" class="admin-logo" alt="Admin">';
        echo '<span class="admin-name">' . $user['name'] . '</span>';
        echo '</div>';

        // Call to the recursive display function to show genealogy
        displayTeam($user['user_id'], $con);
        echo '</li>';
        echo '</ul>';
    } else {
        echo '<p>Member not found.</p>';
    }
} else {
    echo '<p>Invalid request.</p>';
}

function displayTeam($sponsorId, $con, $currentDepth = 1, $maxDepth = 2) {
    if ($currentDepth > $maxDepth) return;

    $positions = ['Left', 'Right'];

    // Only assign the id="genealogyTree" to the top-level <ul>
    if ($currentDepth === 1) {
        echo '<ul id="genealogyTree">';
    } else {
        echo '<ul>';
    }

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
                         onclick="showDetails(this)">';
                echo '<img src="https://cdn3.iconfinder.com/data/icons/black-easy/512/538474-user_512x512.png" class="admin-logo" alt="User">';
                echo '<span class="admin-name">' . $row['name'] . '</span>';
                echo '</div>';

                // Recursively render child nodes
                displayTeam($row['user_id'], $con, $currentDepth + 1, $maxDepth);

                echo '</li>';
            }
        } else {
            // Create an empty node if no member is found
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
    

  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f6f9;
       margin: 0;
    padding: 0;
    
    }

  
    .navbar-fixed-top {
            /*position: fixed;*/
           position: fixed;
            top: 0;
            width: 100%;
            z-index: 1030;
          
            /*z-index: 1030;*/
        }
        
        .footer {
            background-color: #f8f9fa;
            padding: 20px 0;
            text-align: center;
            border-top: 1px solid #ddd;
        }
        
        .footer-fixed-top{
              /*position: fixed;*/
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
    padding: 20px 0;
}

/* Main tree structure */
.tree ul {
    padding-top: 20px;
    position: relative;
    display: flex;
    justify-content: center; /* Center the child nodes */
    list-style-type: none;
    margin: 0;
}

/* Connecting lines between nodes */
.tree ul::before {
    content: '';
    position: absolute;
    top: 0; /* Starts at the parent node */
    left: 50%;
    /*border-left: 2px solid red;*/
    height: 30px;
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
    padding-top: 0;
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
    left: 50%;
    border-left: 2px solid #007bff;
    height: 22px;
}

/* Styling for the admin node (box) */
.admin-node {
    padding: 15px;
    text-align: center;
    border: 2px solid #007bff;
    border-radius: 8px;
    background-color: #f9f9f9;
    display: inline-block;
    transition: transform 0.3s ease;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    margin: 0 auto; /* Ensures it's centered */
    position: relative; /* To handle absolute positioning of child elements */
}

/* Hover effect for admin node */
.admin-node:hover {
    transform: scale(1.05); /* Hover effect to zoom */
}

/* Admin logo (profile image) */
.admin-logo {
    display: block;
    margin: 0 auto 10px;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    border: 2px solid #007bff;
}

/* Admin name */
.admin-name {
    font-size: 16px;
    font-weight: bold;
    color: #007bff;
    margin-top: 10px;
}

/* Left-side node styling */
.left-node .admin-node {
    background-color: #e8f5e9;
    border-color: #4caf50;
}

.left-node .admin-name {
    color: #4caf50;
}

/* Right-side node styling */
.right-node .admin-node {
    background-color: #ffebee;
    border-color: #f44336;
}

.right-node .admin-name {
    color: #f44336;
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
    font-size: 14px;
}

.modal-footer {
    padding: 10px;
    border-top: 1px solid #ddd;
    display: flex;
    justify-content: flex-end;
}

.modal-footer .btn {
    background: #007bff;
    color: white;
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


/*@media screen and (max-width: 768px) {*/
/*    .tree {*/
/*        overflow-x: auto; */
/*        overflow-y: auto;*/
/*        white-space: nowrap; */
/*        padding-left:00px;*/
/*    }*/

/*    .tree ul {*/
/*        flex-wrap: nowrap;*/

/*    }*/

/*    .tree li {*/
/*        display: inline-block;*/
/*        vertical-align: top;*/
        
/*    }*/

/*    .admin-node {*/
/*        padding: 10px;*/
/*        margin: 0 auto;*/
/*    }*/

/*    .admin-logo {*/
/*        width: 40px;*/
/*        height: 40px;*/
/*    }*/

/*    .admin-name {*/
/*        font-size: 14px;*/
/*    }*/
   
/*}*/


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
        transform: scale(0.59); /* Scale tree to 59% for mobile view */
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
    width: 60px;
    height: 60px;
    border-radius: 50%;
    border: 2px solid #007bff;
}

/* Admin name */
.admin-name {
    font-size: 16px;
    font-weight: bold;
    color: #007bff;
    margin-top: 10px;
}

.admin-node.bg-light-green {
    background-color: lightgreen;
    color:black;
}

.admin-node.bg-light-red {
    background-color: lightcoral;
    color:black;
}




/* Container for the search bar */
.search-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 20px 0;
    gap: 10px;
}

.search-label {
    font-size: 16px;
    font-weight: bold;
}

.search-input {
    padding: 10px;
    width: 300px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
}

.search-button {
    padding: 10px 20px;
    font-size: 14px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.search-button:hover {
    background-color: #0056b3;
}



.no-data-message {
    text-align: center;
    color: #888;
    font-size: 16px;
}

/* Admin Node Styling */
.admin-node {
    text-align: center;
    margin: 0px auto;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 8px;
    max-width: 200px;
    background-color: #f1f1f1;
}

.admin-logo {
    width: 50px;
    height: 50px;
    margin-bottom: 10px;
}

.admin-name {
    display: block;
    font-weight: bold;
    font-size: 14px;
    color: #333;
}

/* Empty Node Styling */
.empty-node {
    text-align: center;
    color: #aaa;
    font-size: 14px;
}






  </style>
  
</head>
<body>
    
    <script>
   // Flag to check if the tree is already loaded
    let isTreeLoaded = false;

    // Function to load the genealogy tree for a given member ID
    function loadGenealogyTree(memberId) {
        // Avoid multiple AJAX requests if tree is already loaded
        if (isTreeLoaded) return;
        isTreeLoaded = true;

        document.getElementById('genealogyTree').innerHTML = '<p>Loading...</p>';

        // Perform an AJAX request
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'GenealogyForMember.php', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        xhr.onload = function () {
            if (this.status === 200) {
                // Update the genealogy tree with the response
                document.getElementById('genealogyTree').innerHTML = this.responseText;
            } else {
                alert('Error fetching genealogy. Please try again.');
                document.getElementById('genealogyTree').innerHTML = '<p>Error occurred while fetching data.</p>';
            }
        };

        xhr.onerror = function () {
            alert('Failed to fetch genealogy data.');
            document.getElementById('genealogyTree').innerHTML = '<p>Failed to load genealogy data.</p>';
        };

        // Send the request with the Member ID
        xhr.send('memberId=' + encodeURIComponent(memberId));
    }

    // Function to handle the search functionality
    function searchGenealogy() {
        const memberId = document.getElementById('searchMemberId').value.trim();

        if (!memberId) {
            alert('Please enter a valid Member ID.');
            return;
        }

        // Reset the flag and load the tree for the searched member
        isTreeLoaded = false;
        loadGenealogyTree(memberId); // Load genealogy for the searched member
    }

    // When the page loads, if a member is already set (mysponsorid), load their genealogy tree
    window.onload = function() {
        // Check if a default sponsor ID (mysponsorid) exists
        const defaultMemberId = "<?php echo $mysponsorid ?? ''; ?>"; // PHP variable inserted into JS

        if (defaultMemberId) {
            // Only load if the tree isn't already loaded
            if (!isTreeLoaded) {
                loadGenealogyTree(defaultMemberId); // Load genealogy for the default sponsor ID
            }
        }
    }

    </script>
    
    <!-- Sidebar -->
    <div class="d-flex">
     <!--Navbar-->
      <?php  include('navbar.php');?> 
        <div class="content content-wrapper">
            <!--Top Navbar-->
      <?php  //include('topnavbar.php');?> 
            <!--Main Content page-->

                <!--<div class="header">-->
                <!--  <div class="row d-flex flex-wrap align-items-center justify-content-between">-->
                <!--    <div class="col-md-6 col-12 d-flex justify-content-start">-->
                <!--      <span class="title text-truncate">My Genealogy</span>-->
                <!--    </div>-->
                <!--    <div class="col-md-6 col-12 d-flex justify-content-md-end justify-content-start overflow-hidden">-->
                <!--      <div class="breadcrumb text-nowrap text-truncate ">-->
                <!--        <a href="./account.php" class="breadcrumb-link text-capitalize ">ACCOUNT&nbsp;</a> / <span class="text-uppercase">&nbsp;My Genealogy</span>-->
                <!--      </div>-->
                <!--    </div>-->
                <!--  </div>-->
                <!--</div>-->
<hr>
<!--<p>Note:- In Green: Left Side Member <br>Note:- In Red: Right Side Member </p>-->


     

  <!-- start tree structure -->

    

    <!-- Add a wrapper div around the tree -->
<div class="tree-wrapper">

<div class="tree container1">
    <!-- Search Functionality -->
    <div class="search-container">
        <label for="searchMemberId" class="search-label">Search Member ID:</label>
        <input type="text" id="searchMemberId" class="search-input" placeholder="Enter Member ID">
        <button class="search-button" onclick="searchGenealogy()">Search</button>
    </div>

    <!-- Genealogy Tree will be displayed here -->
   
   <div class="tree-structure">
        <ul id="genealogyTree">
        <!-- Tree will be automatically loaded if a sponsor ID is available -->
    </ul>
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
                <button type="button" class="btn btn-secondary" onclick="closeModal()">Close</button>
            </div>
        </div>
    </div>
</div>

 
<!-- Footer -->

     <?php //include('footer.php');?> 


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
