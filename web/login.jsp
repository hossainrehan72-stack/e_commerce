<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
    String loginMessage = "";
    if (request.getParameter("login") != null) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String securityKey = request.getParameter("securityKey");

        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email=? AND password=? AND role=?");
            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, role);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Save login info in session
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("role", rs.getString("role"));
                session.setAttribute("user_id", rs.getInt("id"));

                if ("admin".equals(role)) {
                    // Check Admin Security Key
                    if (securityKey == null || !securityKey.equals("129")) { 
                        loginMessage = "Invalid Admin Security Key.";
                    } else {
                        response.sendRedirect("admin.jsp");
                    }
                } else {
                    response.sendRedirect("user.jsp");
                }
            } else {
                loginMessage = "Invalid credentials or role.";
            }
        } catch (Exception e) {
            loginMessage = "Error: " + e.getMessage();
        }
    }

    String msg = (String) request.getAttribute("msg");
    String urlMsg = request.getParameter("msg"); 
    if (msg == null && urlMsg != null) {
        msg = urlMsg;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>

<body>
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <div class="logo">
                    <i class="fas fa-shopping-cart"></i>
                    <h1>rehan's online store</h1>
                </div>
                <h2>Welcome Back!</h2>
                <p> Sign in to continue your shopping journey</p>
                <p style="color:red;"><%= loginMessage%> <%= (msg != null ? msg : "")%></p>
            </div>

            <form class="login-form" id="loginForm" method="post" action="login.jsp" novalidate>

                <!-- Email -->
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-container">
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" id="email" name="email" placeholder="Enter your email address" required>
                    </div>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-container">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required>
                        <button type="button" class="password-toggle" id="passwordToggle">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <!-- Role -->
                <div class="form-group">
                    <label for="role">Login as</label>
                    <div class="role-options">
                        <input type="radio" id="user" name="role" value="user" checked> <label for="user">User</label>
                        <input type="radio" id="admin" name="role" value="admin"> <label for="admin">Admin</label>
                    </div>
                </div>

                <!-- Admin Security Key -->
                <div id="keyField" style="display:none;">
                    <input type="text" name="securityKey" placeholder="Admin Security Key">
                </div>

                <div class="form-options">
                    <div class="remember-me">
                        <input type="checkbox" id="rememberMe" name="rememberMe">
                        <label for="rememberMe">Remember me</label>
                    </div>
                    <a href="#" class="forgot-password">Forgot password?</a>
                </div>

                <button type="submit" class="login-btn" id="loginBtn" name="login">
                    <span class="btn-text">Sign In</span>
                    <i class="fas fa-spinner fa-spin btn-loader" style="display: none;"></i>
                </button>

                <div class="signup-link">
                    <p>Don't have an account? <a href="register.jsp">Register User</a></p>
                </div>
            </form>
        </div>
    </div>

    <!-- JS for toggling Security Key -->
    <script>
        const userRadio = document.getElementById("user");
        const adminRadio = document.getElementById("admin");
        const keyField = document.getElementById("keyField");

        adminRadio.addEventListener("change", function () {
            if (adminRadio.checked) {
                keyField.style.display = "block";
            }
        });

        userRadio.addEventListener("change", function () {
            if (userRadio.checked) {
                keyField.style.display = "none";
            }
        });
    </script>
</body>
</html>
