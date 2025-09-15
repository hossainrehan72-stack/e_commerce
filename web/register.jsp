<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
    String regMessage = "";
    final String ADMIN_KEY = "129"; // keep simple but centralized
    
    if (request.getParameter("register") != null) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");
        String securityKey = request.getParameter("securityKey");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        
        // Basic validation
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            regMessage = "Please fill in all required fields.";
        } else if ("admin".equals(role) && (securityKey == null || !ADMIN_KEY.equals(securityKey))) {
            regMessage = "Invalid Admin Security Key!";
        } else {
            try {
                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO users(username, password, role, phone, email, gender) VALUES (?, ?, ?, ?, ?, ?)"
                );
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, role);
                ps.setString(4, phone);
                ps.setString(5, email);
                ps.setString(6, gender);
                
                int rows = ps.executeUpdate();
                
                if (rows > 0) {
                    request.setAttribute("msg", "Registration Successful! Please login.");
%>
<jsp:forward page="login.jsp"/>
<%
                }
            } catch (SQLIntegrityConstraintViolationException e) {
                regMessage = "Username or email already exists!";
            } catch (Exception e) {
                regMessage = "Error: " + e.getMessage();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Account - rehan's Online Store</title>
        <link rel="stylesheet" href="register-style.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">


    </head>
    <body>
        <div class="register-container">
            <div class="register-card">
                <div class="register-header">
                    <div class="logo">
                        <i class="fas fa-shopping-cart"></i>
                        <h1>rehan's Online Store</h1>
                    </div>
                    <h2>Join us</h2>
                    <p>Create your account here!</p>
                    <p style="color:red;"><%= regMessage%></p>
                </div>

                <form class="register-form" id="registerForm" method="post" action="register.jsp" novalidate>
                    <!-- Username -->
                    <div class="form-group">
                        <label for="username">Enter your name</label>
                        <div class="input-container">
                            <i class="fas fa-user input-icon"></i>
                            <input type="text" id="username" name="username" placeholder="Enter your name" required>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <div class="input-container">
                            <i class="fas fa-envelope input-icon"></i>
                            <input type="email" id="email" name="email" placeholder="Enter your email address" required>
                        </div>
                    </div>

                    <!-- Phone -->
                    <div class="form-group">
                        <label for="phone">Phone Number (Optional)</label>
                        <div class="input-container">
                            <i class="fas fa-phone input-icon"></i>
                            <input type="tel" id="phone" name="phone" placeholder="Enter your phone number">
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="input-container">
                            <i class="fas fa-lock input-icon"></i>
                            <input type="password" id="password" name="password" placeholder="Create a strong password" required>
                            <button type="button" class="password-toggle" id="passwordToggle">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Gender -->
                    <div class="form-group">
                        <label for="gender">Gender</label>
                        <div class="gender-options">
                            <input type="radio" id="male" name="gender" value="male"> <label for="male">? Male</label>
                            <input type="radio" id="female" name="gender" value="female"> <label for="female">? Female</label>
                            <input type="radio" id="other" name="gender" value="other"> <label for="other">? Other</label>
                            <input type="radio" id="prefer-not" name="gender" value="prefer-not"> <label for="prefer-not">? Prefer not to say</label>
                        </div>
                    </div>
                    <select name="role" id="role" onchange="toggleKeyField()" required>
                        <option value="user">User</option>
                        <option value="admin">Admin</option>
                    </select>

                    <div id="keyField" style="display:none;">
                        <input type="text" name="securityKey" placeholder="Admin Security Key">
                    </div>



                    <!-- Submit -->
                    <button type="submit" class="register-btn" id="registerBtn" name="register">
                        <span class="btn-text">Create My Account</span>
                        <i class="fas fa-spinner fa-spin btn-loader" style="display:none;"></i>
                    </button>

                    <div class="login-link">
                        <p>Already have an account? <a href="login.jsp">Sign in here</a> ?</p>
                    </div>



                </form>
            </div>
            <div class="benefits-section">
                <h3>Why Join rehan's onilne store? </h3>
                <div class="benefits-list">
                    <div class="benefit-item">

                        <div class="benefit-content">
                            <h4>Welcome Bonus</h4>
                            <p>Get 20% off your first order when you join!</p>
                        </div>
                    </div>

                    <div class="benefit-item">

                        <div class="benefit-content">
                            <h4>Order Tracking</h4>
                            <p>Track your packages in real-time from order to delivery</p>
                        </div>
                    </div>
                    <div class="benefit-item">

                        <div class="benefit-content">
                            <h4>Exclusive Deals</h4>
                            <p>Greate  discounts </p>
                        </div>
                    </div>
                    <div class="benefit-item">

                        <div class="benefit-content">
                            <h4>Rewards</h4>
                            <p>Earn points with every purchase and unlock rewards</p>
                        </div>
                    </div>
                    <div class="benefit-item">

                        <div class="benefit-content">
                            <h4>24/7 Support</h4>
                            <p>Our friendly team is always here to help you</p>
                        </div>
                    </div>
                </div>
            </div>


    </body>
</html>
