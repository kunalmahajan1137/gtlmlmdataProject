<nav id="sidebar" class="bg-dark-bg sidebar">
            <div class="sidebar-header p-3 d-flex justify-content-between align-items-center">
                <img height="50" width="120" src="../member/IMAGE/logo.png" alt="CP Solution Logo">
                
            </div>
    <ul class="list-unstyled components">
   <li class="active"><a href="./account.jsp" class="text-light"><i class="bi bi-house"></i> Dashboard</a></li>

    <!-- Collapsible Account Section -->
    <li class="sidebar-item">
        <a href="#accountSubmenu" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle text-light">
            <i class="bi bi-person"></i>
            <!--Account-->
            My Profile 
        </a>
        <ul class="collapse list-unstyled ml-3" id="accountSubmenu">
            <li><a href="ViewProfileServlet" class="text-light ps-4">My Profile</a></li>
            <li><a href="EditProfileServlet" class="text-light ps-4">Edit Profile</a></li>
            <li><a href="./Upload_KYC.jsp" class="text-light ps-4">User KYC</a></li>
            <li><a href="./NomineeDetails.jsp" class="text-light ps-4">Nominee Details </a></li>
            <li><a href="./Change_member_password.jsp" class="text-light ps-4">Change Password</a></li>
            <li><a href="WelcomeServlet" class="text-light ps-4">Welcome Letter</a></li>
        </ul>
    </li>
    
    <!--<li>-->
    <!--    <a href="#Activationmenu" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle text-light">-->
    <!--        <i class="bi bi-box-arrow-in-right"> </i> Activation-->
    <!--    </a>-->
    <!--    <ul class="collapse list-unstyled" id="Activationmenu">-->
    <!--        <li><a href="./Request_Fund.jsp" class="text-light ps-4">Wallet Request</a></li>-->
           
    <!--    </ul>   -->
            
    <!--</li>-->
    
    
    <li>
        <a  href="#Incomemenubtn" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle text-light">
            <i class="bi bi-currency-dollar"></i> Income
        </a>
         <ul class="collapse list-unstyled" id="Incomemenubtn">
             <li><a href="./walletamount.jsp" class="text-light ps-4">Wallet Amounts</a></li>
            <li><a href="./Income_Details.jsp" class="text-light ps-4">Income Detail</a></li>
            <li><a href="./Binary_income.jsp" class="text-light ps-4">Refer income</a></li>
             <li><a href="./Directincomereport.jsp" class="text-light ps-4 ">Active Income</a></li>
            <li><a href="./Level_Income.jsp" class="text-light ps-4">Level Income</a></li>
            <li><a href="./Running_Income_View.jsp" class="text-light ps-4 text-muted">Auto Pull Income</a></li>
        </ul>   
        
    </li>
    
    
    <li>
        <a href="#MyTeammenubtn" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle text-light">
            <i class="bi bi-people"></i> My Team
       </a>
       
       <ul class="collapse list-unstyled" id="MyTeammenubtn">
            <li><a href="./genealogy.jsp" class="text-light ps-4">My Genealogy</a></li>
             <li><a href="./DownlineLevelwisePoint.jsp" class="text-light ps-4">Level wise Downline</a></li>
            <li><a href="./downlineLeft.jsp" class="text-light ps-4">Left Downline</a></li>
            <li><a href="./downlineright.jsp" class="text-light ps-4">Right Downline</a></li>
            <li><a href="./MyDirect.jsp" class="text-light ps-4">Direct Members </a></li>
            <li><a href="./My_Reffral_Link.jsp" class="text-light ps-4">My Referral Link</a></li>
        </ul> 
    </li>
    
    
    
    <!--<li>-->
    <!--    <a href="#Packageubtn" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle text-light">-->
    <!--        <i class="bi bi-gift"></i> Package-->
    <!--    </a>-->
    <!--     <ul class="collapse list-unstyled" id="Packageubtn">-->
    <!--        <li><a href="./Upgrade_Id.jsp" class="text-light ps-4">Buy Now / Activation</a></li>-->
           
    <!--    </ul> -->
    <!--</li>-->
    
    
    
    <li>
        <a href="#Paymentbtn" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle text-light">
            <i class="bi bi-wallet2"></i> Payment
        </a>
        <ul class="collapse list-unstyled" id="Paymentbtn">
            <li><a href="./Payment_Details.jsp" class="text-light ps-4">Withdraw Request</a></li>
            <li><a href="./rptTransaction.jsp" class="text-light ps-4">All Transaction</a></li>
            <li><a href="./walletstatement.jsp" class="text-light ps-4">Income Statement</a></li>
           
        </ul> 
    </li>
    
  
    
    <li>
        <a href="#Rewardbtn" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle text-light">
            <i class="bi bi-trophy"></i> Reward
        </a>
         <ul class="collapse list-unstyled" id="Rewardbtn">
            <li><a href="./BoanazaStatus.jsp" class="text-light ps-4">Reward Status</a></li>
           
        </ul> 
    </li>
    
    <li>
        <a href="#Mettingdbtn" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle text-light">
            <i class="fa fa-video-camera"></i> Metting
        </a>
         <ul class="collapse list-unstyled" id="Mettingdbtn">
            <li><a href="./scheduledmeetings.jsp" class="text-light ps-4">Scheduled Metting </a></li>
            <li><a href="./meetings.jsp" class="text-light ps-4">Request Metting </a></li>
        </ul> 
    </li>
    
  
     
    <!--<li>-->
    <!--    <a href="#Supportbtn" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle text-light">-->
    <!--        <i class="bi bi-wallet2"></i> Support-->
    <!--    </a>-->
    <!--    <ul class="collapse list-unstyled" id="Supportbtn">-->
    <!--        <li><a href="./Complains.jsp" class="text-light ps-4">My Complain</a></li>-->
    <!--        <li><a href="./Suggestion.jsp" class="text-light ps-4">My Suggestion</a></li>-->
    <!--    </ul> -->
    <!--</li>-->
    
    <!--<li><a href="#" class="text-light"><i class="bi bi-box-arrow-right"></i> Logout</a></li>-->
    
  
                            <li><a href="../mainlogin.jsp" class="dropdown-item"><i class="bi bi-box-arrow-right"></i>Login</a></li>
                        
                            <li><a href="../logout.jsp" class="dropdown-item"><i class="bi bi-box-arrow-right"></i>Logout</a></li>
                       
</ul>
 </nav>
 
 <script>
      document.addEventListener("DOMContentLoaded", function () {
    // Get the current URL path
    const currentPath = window.location.pathname;

    // Select all nav-link elements
    const navLinks = document.querySelectorAll(".nav-link");

    navLinks.forEach(link => {
      // Get the path from the href attribute
      const linkPath = new URL(link.href).pathname;

      // Check if the link's path matches the current path
      if (linkPath === currentPath) {
        link.classList.add("text-warning"); // Add yellow color
        link.classList.add("active"); // Optionally add an active class
      } else {
        link.classList.remove("text-warning"); // Remove yellow color from non-active links
        link.classList.remove("active"); // Remove active class from non-active links
      }
    });
  });

 </script>
 