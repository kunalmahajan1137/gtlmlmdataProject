<script>
let lastScrollPosition = 0;
const navbar = document.getElementById("navbar");

window.addEventListener("scroll", () => {
    const currentScrollPosition = window.pageYOffset;

    if (currentScrollPosition > lastScrollPosition) {
        // User is scrolling down: hide the navbar
        navbar.classList.add("hidden");
        navbar.classList.remove("fixed");
    } else {
        // User is scrolling up: show the navbar
        navbar.classList.remove("hidden");
        navbar.classList.add("fixed");
    }

    // Update the last scroll position
    lastScrollPosition = currentScrollPosition <= 0 ? 0 : currentScrollPosition; // Prevent negative scrolling
});


</script>

<style>
@media (max-width: 768px) {
  /* Navbar default styling */
.navbar {
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 1030;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

/* Hide navbar when scrolling down */
.navbar.hidden {
    transform: translateY(-100%);
}

/* Show navbar when scrolling up */
.navbar.fixed {
    transform: translateY(0);
}
}

</style>

<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>


<nav class="navbar navbar-expand-lg navbar-light bg-light-bg navbar-fixed-top"> 
    <div class="container-fluid">
        <!-- Sidebar Toggle Button -->
        <button type="button" id="sidebarCollapse" class="btn btn-info-bg">
            <i class="fas fa-bars"></i>
        </button>

        <!-- User Profile Dropdown -->
        <div class="dropdown">
            <a href="#" class="text-dark dropdown-toggle text-white" id="profileDropdown" data-bs-toggle="dropdown" aria-expanded="false" style="text-decoration: none;">
                <i class="fas fa-user-circle"></i>
                
                <%-- Fetch the logged-in user's name from session --%>
                <% 
                    String username = (String) session.getAttribute("user");
                    if (username != null) { 
                %>
                    <%= "Welcome, " + username %>
                <% 
                    } else { 
                    response.sendRedirect("../login.jsp");
                     } %>
            </a>

            <ul class="dropdown-menu dropdown-menu-end text-white" aria-labelledby="profileDropdown">
                <li><a class="dropdown-item" href="#" style="text-decoration: none; border-radius:5px;">My Product</a></li>
                <li><a class="dropdown-item" href="ViewProfileServlet" style="text-decoration: none; border-radius:5px;">Profile</a></li>

                <% if (username == null) { %>
                    <!-- Show login if user is not logged in -->
                    <li><a class="dropdown-item" href="../login.jsp" style="text-decoration: none; border-radius:5px;">Login</a></li>
                <% } else { %>
                    <!-- Show logout if user is logged in -->
                    <li><a href="LogoutServlet" class="dropdown-item">Logout</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
            

