<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Sidhi's Store</title>
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
        
        /* Cart Header */
        .cart-header {
            text-align: center;
            margin-bottom: 3rem;
            padding: 2rem 0;
        }
        
        .cart-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 1rem;
        }
        
        .cart-subtitle {
            font-size: 1.1rem;
            color: #64748b;
        }
        
        /* Cart Item Cards */
        .cart-item {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
        }
        
        .cart-item:hover {
            transform: translateY(-2px);
            box-shadow: var(--card-hover-shadow);
        }
        
        .product-image {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 15px;
            border: 2px solid #f1f5f9;
        }
        
        .product-info h5 {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }
        
        .product-price {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--success-color);
        }
        
        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin: 1rem 0;
        }
        
        .quantity-btn {
            width: 35px;
            height: 35px;
            border: none;
            border-radius: 50%;
            background: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .quantity-btn:hover {
            background: var(--secondary-color);
            transform: scale(1.1);
        }
        
        .quantity-input {
            width: 60px;
            text-align: center;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            padding: 0.5rem;
            font-weight: 600;
        }
        
        .remove-btn {
            background: var(--danger-color);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .remove-btn:hover {
            background: #dc2626;
            transform: translateY(-2px);
        }
        
        /* Cart Summary */
        .cart-summary {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
            position: sticky;
            top: 100px;
        }
        
        .summary-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            text-align: center;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.8rem 0;
            border-bottom: 1px solid #f1f5f9;
        }
        
        .summary-row:last-child {
            border-bottom: none;
        }
        
        .summary-row.total {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--dark-color);
            border-top: 2px solid #e2e8f0;
            margin-top: 1rem;
            padding-top: 1rem;
        }
        
        .checkout-btn {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
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
        
        .checkout-btn:hover {
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
        }
        
        .continue-shopping {
            background: transparent;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }
        
        .continue-shopping:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            text-decoration: none;
        }
        
        /* Empty Cart */
        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
            color: #64748b;
        }
        
        .empty-cart i {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            color: #cbd5e1;
        }
        
        .empty-cart h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--dark-color);
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .cart-title {
                font-size: 2rem;
            }
            
            .product-image {
                width: 80px;
                height: 80px;
            }
            
            .cart-item {
                padding: 1rem;
            }
            
            .main-container {
                padding-top: 70px;
            }
        }
        
        .fade-in {
            animation: fadeIn 0.6s ease-in;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
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
                <a href="user.jsp" class="nav-btn nav-btn-secondary">
                    <i class="fas fa-arrow-left"></i> Continue Shopping
                </a>
                <a href="logout.jsp" class="nav-btn nav-btn-primary">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="main-container">
        <div class="container">
            <!-- Cart Header -->
            <div class="cart-header fade-in">
                <h1 class="cart-title">
                    <i class="fas fa-shopping-cart" style="color: var(--secondary-color);"></i>
                    Your Shopping Cart
                </h1>
                <p class="cart-subtitle">Review your items and proceed to checkout</p>
            </div>

            <%
                // Get session cart items (we'll use session for simplicity, but in production you'd use database)
                java.util.Map<Integer, Integer> cart = (java.util.Map<Integer, Integer>) session.getAttribute("cart");
                double totalAmount = 0.0;
                int totalItems = 0;
                
                if (cart != null && !cart.isEmpty()) {
                    totalItems = cart.values().stream().mapToInt(Integer::intValue).sum();
            %>
            
            <div class="row">
                <!-- Cart Items -->
                <div class="col-lg-8 col-md-7">
                    <%
                        for (java.util.Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                            int productId = entry.getKey();
                            int quantity = entry.getValue();
                            
                            try {
                                String sql = "SELECT * FROM products WHERE id = ?";
                                PreparedStatement ps = con.prepareStatement(sql);
                                ps.setInt(1, productId);
                                ResultSet rs = ps.executeQuery();
                                
                                if (rs.next()) {
                                    String name = rs.getString("name");
                                    String desc = rs.getString("description");
                                    double price = rs.getDouble("price");
                                    String image = rs.getString("image_url");
                                    double itemTotal = price * quantity;
                                    totalAmount += itemTotal;
                    %>
                    
                    <div class="cart-item fade-in">
                        <div class="row align-items-center">
                            <div class="col-md-3">
                                <img src="<%= image %>" alt="<%= name %>" class="product-image"
                                     onerror="this.src='https://via.placeholder.com/120x120?text=No+Image';">
                            </div>
                            <div class="col-md-6">
                                <div class="product-info">
                                    <h5><%= name %></h5>
                                    <p class="text-muted mb-2"><%= desc %></p>
                                    <div class="product-price">₹ <%= String.format("%.2f", price) %></div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="d-flex flex-column align-items-end">
                                    <div class="quantity-controls">
                                        <form method="post" action="updateCart.jsp" style="display: inline;">
                                            <input type="hidden" name="product_id" value="<%= productId %>">
                                            <input type="hidden" name="action" value="decrease">
                                            <button type="submit" class="quantity-btn">
                                                <i class="fas fa-minus"></i>
                                            </button>
                                        </form>
                                        <input type="text" value="<%= quantity %>" class="quantity-input" readonly>
                                        <form method="post" action="updateCart.jsp" style="display: inline;">
                                            <input type="hidden" name="product_id" value="<%= productId %>">
                                            <input type="hidden" name="action" value="increase">
                                            <button type="submit" class="quantity-btn">
                                                <i class="fas fa-plus"></i>
                                            </button>
                                        </form>
                                    </div>
                                    <div class="mt-2">
                                        <strong class="text-success">₹ <%= String.format("%.2f", itemTotal) %></strong>
                                    </div>
                                    <form method="post" action="updateCart.jsp" class="mt-2">
                                        <input type="hidden" name="product_id" value="<%= productId %>">
                                        <input type="hidden" name="action" value="remove">
                                        <button type="submit" class="remove-btn">
                                            <i class="fas fa-trash"></i> Remove
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <%
                                }
                            } catch (Exception e) {
                                out.println("<div class='alert alert-danger'>Error loading product: " + e.getMessage() + "</div>");
                            }
                        }
                    %>
                    
                    <div class="text-center mt-4">
                        <a href="user.jsp" class="continue-shopping">
                            <i class="fas fa-arrow-left"></i> Continue Shopping
                        </a>
                    </div>
                </div>
                
                <!-- Cart Summary -->
                <div class="col-lg-4 col-md-5">
                    <div class="cart-summary fade-in">
                        <h3 class="summary-title">Order Summary</h3>
                        
                        <div class="summary-row">
                            <span>Items (<%= totalItems %>)</span>
                            <span>₹ <%= String.format("%.2f", totalAmount) %></span>
                        </div>
                        
                        <div class="summary-row">
                            <span>Shipping</span>
                            <span class="text-success">Free</span>
                        </div>
                        
                        <div class="summary-row">
                            <span>Tax (18% GST)</span>
                            <span>₹ <%= String.format("%.2f", totalAmount * 0.18) %></span>
                        </div>
                        
                        <div class="summary-row total">
                            <span>Total</span>
                            <span>₹ <%= String.format("%.2f", totalAmount + (totalAmount * 0.18)) %></span>
                        </div>
                        
                        <form method="post" action="checkout.jsp">
                            <input type="hidden" name="total_amount" value="<%= totalAmount + (totalAmount * 0.18) %>">
                            <button type="submit" class="checkout-btn">
                                <i class="fas fa-credit-card"></i> Proceed to Checkout
                            </button>
                        </form>
                        
                        <div class="text-center mt-3">
                            <small class="text-muted">
                                <i class="fas fa-shield-alt"></i> 
                                Secure 256-bit SSL encryption
                            </small>
                        </div>
                        
                        <form method="post" action="updateCart.jsp" class="mt-3">
                            <input type="hidden" name="action" value="clear">
                            <button type="submit" class="btn btn-outline-danger w-100" 
                                    onclick="return confirm('Are you sure you want to clear your cart?')">
                                <i class="fas fa-trash"></i> Clear Cart
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            
            <%
                } else {
            %>
            
            <!-- Empty Cart -->
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="empty-cart fade-in">
                        <i class="fas fa-shopping-cart"></i>
                        <h3>Your cart is empty</h3>
                        <p>Looks like you haven't added anything to your cart yet.</p>
                        <a href="user.jsp" class="continue-shopping">
                            <i class="fas fa-arrow-left"></i> Start Shopping
                        </a>
                    </div>
                </div>
            </div>
            
            <%
                }
            %>

        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript for Enhanced UX -->
    <script>
        // Smooth scrolling and animations
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
            
            // Observe all fade-in elements
            document.querySelectorAll('.fade-in').forEach(el => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(20px)';
                el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                observer.observe(el);
            });
            
            // Navbar scroll effect
            window.addEventListener('scroll', function() {
                const navbar = document.querySelector('.custom-navbar');
                if (window.scrollY > 50) {
                    navbar.style.background = 'rgba(255, 255, 255, 0.98)';
                    navbar.style.boxShadow = '0 8px 25px rgba(0, 0, 0, 0.15)';
                } else {
                    navbar.style.background = 'rgba(255, 255, 255, 0.95)';
                    navbar.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.1)';
                }
            });
            
            // Add loading state to buttons
            document.querySelectorAll('button[type="submit"]').forEach(button => {
                button.addEventListener('click', function() {
                    if (!this.classList.contains('btn-outline-danger')) {
                        const originalText = this.innerHTML;
                        this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                        this.disabled = true;
                        
                        // Re-enable button after a delay (fallback)
                        setTimeout(() => {
                            this.innerHTML = originalText;
                            this.disabled = false;
                        }, 3000);
                    }
                });
            });
            
            // Quantity input validation
            document.querySelectorAll('.quantity-input').forEach(input => {
                input.addEventListener('change', function() {
                    const value = parseInt(this.value);
                    if (value < 1 || isNaN(value)) {
                        this.value = 1;
                    }
                });
            });
        });
        
        // Success notification function
        function showNotification(message, type = 'success') {
            const notification = document.createElement('div');
            notification.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
            notification.style.top = '100px';
            notification.style.right = '20px';
            notification.style.zIndex = '9999';
            notification.innerHTML = `
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            
            document.body.appendChild(notification);
            
            // Auto remove after 3 seconds
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.remove();
                }
            }, 3000);
        }
        
        // Show notification if there's a success message
        <% if (request.getParameter("success") != null) { %>
            showNotification('<i class="fas fa-check-circle"></i> Item updated successfully!');
        <% } else if (request.getParameter("removed") != null) { %>
            showNotification('<i class="fas fa-trash"></i> Item removed from cart!', 'warning');
        <% } else if (request.getParameter("cleared") != null) { %>
            showNotification('<i class="fas fa-trash"></i> Cart cleared successfully!', 'info');
        <% } %>
    </script>
</body>
</html>

