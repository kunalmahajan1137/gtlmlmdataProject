<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Senzense Corporation</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
</head>
<body class="bg-gray-100">
    <header class="bg-white shadow-md py-4">
        <div class="container mx-auto flex justify-between items-center px-6">
            <h1 class="text-green-600 text-2xl font-bold">SENZENSE CORPORATION</h1>
            <nav>
                <ul class="flex space-x-6 text-gray-700 font-semibold">
                    <li><a href="index.jsp" class="hover:text-green-600">Home</a></li>
                    <li><a href="register.jsp" class="hover:text-green-600">Register</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="container mx-auto py-16">
        <div class="max-w-md mx-auto bg-white p-8 shadow-lg rounded-lg">
            <h2 class="text-center text-2xl font-semibold mb-6">Login</h2>
            <div id="response"></div>
            <form id="loginForm">
                <input type="email" name="email" placeholder="Email" class="w-full px-4 py-2 mb-4 border rounded-md" required>
                <input type="password" name="password" placeholder="Password" class="w-full px-4 py-2 mb-4 border rounded-md" required>
                <button type="submit" class="w-full bg-black text-white py-2 rounded-md font-semibold">LOGIN</button>
            </form>
            <div class="text-center mt-4">
                <p class="text-sm">Don't have an account? <a href="register.jsp" class="text-blue-600">Sign Up</a></p>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            $("#loginForm").on("submit", function (event) {
                event.preventDefault();

                $.ajax({
                    url: "LoginServlet",
                    type: "POST",
                    data: $(this).serialize(),
                    dataType: "json",
                    success: function (response) {
                        if (response.status === "success") {
                            $("#response").html("<p style='color: green;'>" + response.message + "</p>");
                            setTimeout(function() {
                                window.location.href = response.redirect;
                            }, 2000);
                        } else {
                            $("#response").html("<p style='color: red;'>" + response.message + "</p>");
                        }
                    },
                    error: function () {
                        $("#response").html("<p style='color: red;'>Error occurred while logging in.</p>");
                    }
                });
            });
        });
    </script>
</body>
</html>
