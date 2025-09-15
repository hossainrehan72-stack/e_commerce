<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="db.jsp" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Sidhi's Store</title>
    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #6366f1;
            --secondary-color: #8b5cf6;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --dark-color: #1f2937;
            --light-bg: #f8fafc;
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --card-hover-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            line-height: 1.6;
        }
        
        .main-container {
            background: var(--light-bg);
            min-height: 100vh;
            padding-top: 80px;
        }
        
        /* Enhanced Navbar */
        .custom-navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(20px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1030;
            padding: 1rem 0;
            transition: all 0.3s ease;
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: var(--primary-color) !important;
            text-decoration: none;
        }
        
        .navbar-brand i {
            margin-right: 0.5rem;
            color: var(--secondary-color);
        }
        
        .nav-btn {
            margin: 0 0.25rem;
            border-radius: 50px;
            padding: 0.5rem 1.2rem;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .nav-btn-primary {
            background: var(--primary-color);
            color: white;
            border: 2px solid var(--primary-color);
        }
        
        .nav-btn-primary:hover {
            background: transparent;
            color: var(--primary-color);
            transform: translateY(-2px);
        }
        
        .nav-btn-secondary {
            background: transparent;
            color: var(--dark-color);
            border: 2px solid var(--dark-color);
        }
        
        .nav-btn-secondary:hover {
            background: var(--dark-color);
            color: white;
            transform: translateY(-2px);
        }
        
        /* Checkout Steps */
        .checkout-steps {
            display: flex;
            justify-content: center;
            margin-bottom: 3rem;
        }
        
        .step {
            display: flex;
            align-items: center;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            background: #e2e8f0;
            color: #64748b;
            margin: 0 0.5rem;
            transition: all 0.3s ease;
        }
        
        .step.active {
            background: var(--primary-color);
            color: white;
        }
        
        .step.completed {
            background: var(--success-color);
            color: white;
        }
        
        .checkout-card {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
            margin-bottom: 2rem;
        }
        
        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #f1f5f9;
            padding-bottom: 0.5rem;
        }
        
        .form-label {
            font-weight: 500;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }
        
        .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            padding: 0.8rem 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(99, 102, 241, 0.25);
        }
        
        .order-summary {
            background: #f8fafc;
            border: 2px solid #e2e8f0;
            border-radius: 15px;
            padding: 1.5rem;
        }
        
        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .order-total {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--success-color);
            border-top: 2px solid #e2e8f0;
            padding-top: 1rem;
            margin-top: 1rem;
        }
        
        .place-order-btn {
            background: linear-gradient(135deg, var(--success-color), #059669);
            border: none;
            color: white;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            width: 100%;
            margin-top: 1.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .place-order-btn:hover {
            background: linear-gradient(135deg, #059669, var(--success-color));
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(16, 185, 129, 0.3);
        }
        
        .order-success {
            text-align: center;
            padding: 3rem 2rem;
        }
        
        .success-icon {
            font-size: 4rem;
            color: var(--success-color);
            margin-bottom: 1rem;
        }
        
        .fade-in {
            animation: fadeIn 0.6s ease-in;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @media (max-width: 768px) {
            .checkout-steps {
                flex-wrap: wrap;
            }
            
            .step {
                margin: 0.25rem;
                font-size: 0.9rem;
            }
            
            .main-container {
                padding-top: 70px;
            }
        }
    </style>
</head>
<body>
    <!-- Enhanced Navbar -->
    <nav class="navbar navbar-expand-lg custom-navbar">
        <div class="container">
            <a class="navbar-brand" href="user.jsp">
                <i class="fas fa-shopping-bag"></i> Sidhi's Store
            </a>
            <div class="d-flex align-items-center">
                <a href="cart.jsp" class="nav-btn nav-btn-secondary">
                    <i class="fas fa-shopping-cart"></i> Cart
                </a>
                <a href="logout.jsp" class="nav-btn nav-btn-primary">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="main-container">
        <div class="container">
            <%
                // Handle order placement
                if ("POST".equals(request.getMethod()) && request.getParameter("place_order") != null) {
                    // Get form data
                    String fullName = request.getParameter("full_name");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("address");
                    String city = request.getParameter("city");
                    String state = request.getParameter("state");
                    String zipCode = request.getParameter("zip_code");
                    String paymentMethod = request.getParameter("payment_method");
                    String totalAmountStr = request.getParameter("total_amount");
                    
                    try {
                        double totalAmount = Double.parseDouble(totalAmountStr);
                        
                        // Generate order ID
                        String orderId = "ORD" + System.currentTimeMillis();
                        
                        // Insert order into database
                        String sql = "INSERT INTO orders (order_id, customer_name, email, phone, address, city, state, zip_code, total_amount, payment_method, order_status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Placed', NOW())";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.setString(1, orderId);
                        ps.setString(2, fullName);
                        ps.setString(3, email);
                        ps.setString(4, phone);
                        ps.setString(5, address);
                        ps.setString(6, city);
                        ps.setString(7, state);
                        ps.setString(8, zipCode);
                        ps.setDouble(9, totalAmount);
                        ps.setString(10, paymentMethod);
                        ps.executeUpdate();
                        
                        // Clear cart after successful order
                        session.removeAttribute("cart");
                        
                        // Show success message
                        %>
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="checkout-card fade-in order-success">
                                    <div class="success-icon">
                                        <i class="fas fa-check-circle"></i>
                                    </div>
                                    <h2 class="mb-3" style="color: var(--success-color);">Order Placed Successfully!</h2>
                                    <p class="mb-3">Thank you for your order. Your order ID is: <strong><%= orderId %></strong></p>
                                    <p class="text-muted mb-4">You will receive a confirmation email shortly.</p>
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                                        <a href="user.jsp" class="btn btn-primary" style="border-radius: 50px; padding: 0.8rem 2rem;">
                                            <i class="fas fa-shopping-bag"></i> Continue Shopping
                                        </a>
                                        <a href="orders.jsp" class="btn btn-outline-primary" style="border-radius: 50px; padding: 0.8rem 2rem;">
                                            <i class="fas fa-list"></i> View Orders
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                        
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>Error placing order: " + e.getMessage() + "</div>");
                    }
                } else {
                    // Show checkout form
                    
                    // Get items for checkout
                    Map<Integer, Integer> checkoutItems = new HashMap<>();
                    double totalAmount = 0.0;
                    int totalItems = 0;
                    
                    // Check if it's a direct buy now
                    String buyNowProductId = request.getParameter("buy_now_product_id");
                    String quantityStr = request.getParameter("quantity");
                    
                    if (buyNowProductId != null && quantityStr != null) {
                        // Direct buy now
                        int productId = Integer.parseInt(buyNowProductId);
                        int quantity = Integer.parseInt(quantityStr);
                        checkoutItems.put(productId, quantity);
                    } else {
                        // Cart checkout
                        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
                        if (cart != null) {
                            checkoutItems = cart;
                        }
                    }
                    
                    if (checkoutItems.isEmpty()) {
                        %>
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="checkout-card text-center">
                                    <h3>No items to checkout</h3>
                                    <p>Your cart is empty or there was an error.</p>
                                    <a href="user.jsp" class="btn btn-primary">Continue Shopping</a>
                                </div>
                            </div>
                        </div>
                        <%
                    } else {
            %>
            
            <!-- Checkout Steps -->
            <div class="checkout-steps fade-in">
                <div class="step active">
                    <i class="fas fa-shopping-cart me-2"></i> Review Order
                </div>
                <div class="step">
                    <i class="fas fa-truck me-2"></i> Shipping Info
                </div>
                <div class="step">
                    <i class="fas fa-credit-card me-2"></i> Payment
                </div>
            </div>
            
            <form method="post" action="checkout.jsp">
                <div class="row">
                    <!-- Checkout Form -->
                    <div class="col-lg-8">
                        <!-- Shipping Information -->
                        <div class="checkout-card fade-in">
                            <h3 class="section-title">
                                <i class="fas fa-truck"></i> Shipping Information
                            </h3>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="full_name" class="form-label">Full Name *</label>
                                    <input type="text" class="form-control" id="full_name" name="full_name" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label">Email Address *</label>
                                    <input type="email" class="form-control" id="email" name="email" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="phone" class="form-label">Phone Number *</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="zip_code" class="form-label">ZIP Code *</label>
                                    <input type="text" class="form-control" id="zip_code" name="zip_code" required>
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="address" class="form-label">Street Address *</label>
                                    <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="city" class="form-label">City *</label>
                                    <input type="text" class="form-control" id="city" name="city" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="state" class="form-label">State *</label>
                                    <input type="text" class="form-control" id="state" name="state" required>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Payment Information -->
                        <div class="checkout-card fade-in">
                            <h3 class="section-title">
                                <i class="fas fa-credit-card"></i> Payment Method
                            </h3>
                            <div class="row">
                                <div class="col-12">
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="radio" name="payment_method" id="cod" value="Cash on Delivery" checked>
                                        <label class="form-check-label" for="cod">
                                            <i class="fas fa-money-bill-wave me-2"></i> Cash on Delivery
                                        </label>
                                    </div>
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="radio" name="payment_method" id="online" value="Online Payment">
                                        <label class="form-check-label" for="online">
                                            <i class="fas fa-credit-card me-2"></i> Online Payment (UPI/Card)
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Order Summary -->
                    <div class="col-lg-4">
                        <div class="checkout-card fade-in">
                            <h3 class="section-title">
                                <i class="fas fa-receipt"></i> Order Summary
                            </h3>
                            <div class="order-summary">
                                <%
                                    for (Map.Entry<Integer, Integer> entry : checkoutItems.entrySet()) {
                                        int productId = entry.getKey();
                                        int quantity = entry.getValue();
                                        
                                        try {
                                            String sql = "SELECT * FROM products WHERE id = ?";
                                            PreparedStatement ps = con.prepareStatement(sql);
                                            ps.setInt(1, productId);
                                            ResultSet rs = ps.executeQuery();
                                            
                                            if (rs.next()) {
                                                String name = rs.getString("name");
                                                double price = rs.getDouble("price");
                                                double itemTotal = price * quantity;
                                                totalAmount += itemTotal;
                                                totalItems += quantity;
                                %>
                                <div class="order-item">
                                    <div>
                                        <strong><%= name %></strong><br>
                                        <small class="text-muted">Qty: <%= quantity %> × ₹<%= String.format("%.2f", price) %></small>
                                    </div>
                                    <div class="text-end">
                                        <strong>₹<%= String.format("%.2f", itemTotal) %></strong>
                                    </div>
                                </div>
                                <%
                                            }
                                        } catch (Exception e) {
                                            out.println("<div class='alert alert-danger'>Error loading product: " + e.getMessage() + "</div>");
                                        }
                                    }
                                    
                                    double tax = totalAmount * 0.18;
                                    double finalTotal = totalAmount + tax;
                                %>
                                
                                <div class="order-item">
                                    <span>Subtotal (<%= totalItems %> items)</span>
                                    <span>₹<%= String.format("%.2f", totalAmount) %></span>
                                </div>
                                <div class="order-item">
                                    <span>Tax (18% GST)</span>
                                    <span>₹<%= String.format("%.2f", tax) %></span>
                                </div>
                                <div class="order-item">
                                    <span>Shipping</span>
                                    <span class="text-success">Free</span>
                                </div>
                                <div class="order-item order-total">
                                    <span>Total Amount</span>
                                    <span>₹<%= String.format("%.2f", finalTotal) %></span>
                                </div>
                            </div>
                            
                            <input type="hidden" name="total_amount" value="<%= finalTotal %>">
                            <input type="hidden" name="place_order" value="true">
                            <button type="submit" class="place-order-btn">
                                <i class="fas fa-lock"></i> Place Order
                            </button>
                            
                            <div class="text-center mt-3">
                                <small class="text-muted">
                                    <i class="fas fa-shield-alt"></i> 
                                    100% Secure Checkout
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            
            <%
                    }
                }
            %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Fade in animations
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };
            
            const observer = new IntersectionObserver(function(entries) {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);
            
            document.querySelectorAll('.fade-in').forEach(el => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(20px)';
                el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                observer.observe(el);
            });
            
            // Form validation
            const form = document.querySelector('form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const requiredFields = form.querySelectorAll('[required]');
                    let isValid = true;
                    
                    requiredFields.forEach(field => {
                        if (!field.value.trim()) {
                            field.classList.add('is-invalid');
                            isValid = false;
                        } else {
                            field.classList.remove('is-invalid');
                        }
                    });
                    
                    if (!isValid) {
                        e.preventDefault();
                        alert('Please fill in all required fields.');
                    } else {
                        // Show loading state
                        const button = form.querySelector('.place-order-btn');
                        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing Order...';
                        button.disabled = true;
                    }
                });
            }
        });
    </script>
</body>
</html>
