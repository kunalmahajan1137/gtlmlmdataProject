<%-- 
    Document   : register
    Created on : 28 Mar, 2025, 12:43:07 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - Senzense Corporation</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

    </head>
    <body class="bg-light">
        <header class="bg-white shadow-sm py-3 mb-4">
            <div class="container d-flex justify-content-between align-items-center">
                <h1 class="text-success fw-bold">SENZENSE CORPORATION</h1>
                <nav>
                    <a href="#" class="text-dark text-decoration-none mx-2">Home</a>
                    <a href="#" class="text-dark text-decoration-none mx-2">About Us</a>
                    <a href="#" class="text-dark text-decoration-none mx-2">Services</a>
                    <a href="#" class="text-dark text-decoration-none mx-2">Contact</a>
                    <a href="#" class="text-dark text-decoration-none mx-2">Login</a>
                    <a href="#" class="text-dark text-decoration-none mx-2">Register</a>
                </nav>
            </div>
        </header>

        <section class="container">
            <div class="bg-white p-5 shadow rounded w-75 mx-auto">
                <h2 class="text-center mb-4">Register</h2>
                <div id="response"></div>
                <form id="registerForm" class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Sponsor Id:</label>
                        <input type="text" name="sponsor_id" placeholder="Sponsor Id*" class="form-control">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Sponsor Name:</label>
                        <input type="text" name="sponsor_name" placeholder="Sponsor Name*" class="form-control">
                    </div>
                     <div class="col-md-6">
                        <label class="form-label">Position:</label>
                        <input type="text" name="position" placeholder="Left" class="form-control" required>
                    </div>
                     <div class="col-md-6">
                        <label class="form-label">Name:</label>
                        <input type="text" name="name" placeholder="Name*" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Mobile:</label>
                        <input type="text" name="mobile" placeholder="Mobile*" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email:</label>
                        <input type="email" name="email" placeholder="Email*" class="form-control" required>
                    </div>
                   <div class="col-md-6">
                        <label class="form-label">Password:</label>
                        <input type="password" name="password" placeholder="New Password*" class="form-control" required>
                    </div>
                     <div class="col-md-6">
                        <label class="form-label">Confirm Password:</label>
                        <input type="password" name="confirm_password" placeholder="Re-Password*" class="form-control" required>
                    </div>
                    <div class="col-span-2 flex justify-center">
                        <button type="submit" class="bg-black text-white px-6 py-2 rounded w-full">REGISTER</button>
                    </div>
                </form>
               
             
                <p class="text-center mt-3">Already have an account? <a href="login.jsp" class="text-success">Login</a></p>
            </div>
        </section>

        

        <script>
            $(document).ready(function () {
                debugger;
                $("#registerForm").on("submit", function (event) {
                    event.preventDefault();

                    $.ajax({
                        url: "RegisterServlet",
                        type: "POST",
                        data: $(this).serialize(),
                        dataType: "json", // Expecting a JSON response
                        success: function (response) {
                            if (response.status === "success") {
                                $("#response").html("<p style='color: green;'>" + response.message + "</p>");
                                 setTimeout(function() {
                                window.location.href = "login.jsp"; // Redirect to login page
                            },2000);
                            } else {
                                $("#response").html("<p style='color: red;'>" + response.message + "</p>");
                            }
                        },
                        error: function () {
                            $("#response").html("<p style='color: red;'>Error occurred while registering.</p>");
                        }
                    });
                });
            });
        </script>



        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
