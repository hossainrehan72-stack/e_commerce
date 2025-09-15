<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="db.jsp" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sidhi's Store - Premium Online Shopping</title>
    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
   <link rel="stylesheet" href="user_style.css">
   <style>
        /* Image placeholder styling */
        .image-placeholder {
            transition: all 0.3s ease;
        }
        
        .product-img {
            transition: opacity 0.3s ease;
        }
        
        .product-card .image-placeholder {
            margin-bottom: 1rem;
        }
        
        /* Loading states */
        .loading-image {
            opacity: 0.7;
            filter: blur(1px);
        }
        
        .loaded-image {
            opacity: 1;
            filter: none;
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
                <a href="cart.jsp" class="nav-btn nav-btn-cart">
                    <i class="fas fa-shopping-cart"></i> Cart
                    <%
                        // Simple cart count calculation
                        Map<Integer, Integer> navCart = (Map<Integer, Integer>) session.getAttribute("cart");
                        int cartCount = 0;
                        if (navCart != null && !navCart.isEmpty()) {
                            for (Integer qty : navCart.values()) {
                                cartCount += qty;
                            }
                        }
                    %>
                    <% if (cartCount > 0) { %>
                        <span class="badge bg-danger rounded-pill ms-2"><%= cartCount %></span>
                    <% } %>
                </a>
                <a href="logout.jsp" class="nav-btn nav-btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="main-container">
        <div class="container">
        <%
            String selectedCategory = request.getParameter("category");

            if (selectedCategory == null) {
        %>
        <!-- Hero Section -->
        <div class="hero-section fade-in">
            <div class="hero-title">
                <i class="fas fa-sparkles" style="color: var(--secondary-color);"></i>
                Welcome to Sidhi's Store
            </div>
            <div class="hero-subtitle">
                Discover amazing products across different categories. Your perfect shopping experience starts here!
            </div>
        </div>
        
        <!-- Category Section -->
        <div class="category-section">
            <h2 class="section-title">Shop by Category</h2>
            <div class="row g-4">
                <%
                    try {
                        String sql = "SELECT DISTINCT category FROM products";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                            String catName = rs.getString("category");

                            // Enhanced icons and descriptions for categories
                            String icon = "fa-box";
                            String description = "Explore our collection";
                            
                            if ("Electronics".equalsIgnoreCase(catName)) {
                                icon = "fa-laptop";
                                description = "Latest tech & gadgets";
                            } else if ("Books".equalsIgnoreCase(catName)) {
                                icon = "fa-book-open";
                                description = "Knowledge & entertainment";
                            } else if ("Clothing".equalsIgnoreCase(catName)) {
                                icon = "fa-tshirt";
                                description = "Fashion & style";
                            } else if ("Home".equalsIgnoreCase(catName)) {
                                icon = "fa-home";
                                description = "Comfort & decor";
                            } else if ("Sports".equalsIgnoreCase(catName)) {
                                icon = "fa-dumbbell";
                                description = "Fitness & outdoor";
                            } else if ("Beauty".equalsIgnoreCase(catName)) {
                                icon = "fa-heart";
                                description = "Beauty & wellness";
                            } else if ("Toys".equalsIgnoreCase(catName)) {
                                icon = "fa-gamepad";
                                description = "Fun & games";
                            }
                %>
                    <div class="col-lg-3 col-md-4 col-sm-6 fade-in">
                        <a href="user.jsp?category=<%= catName %>" style="text-decoration:none; color:inherit;">
                            <div class="category-card">
                                <i class="fas <%= icon %> category-icon"></i>
                                <div class="category-title"><%= catName %></div>
                                <div class="category-desc"><%= description %></div>
                            </div>
                        </a>
                    </div>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger' role='alert'><i class='fas fa-exclamation-triangle'></i> Error loading categories: " + e.getMessage() + "</div>");
                    }
                %>
            </div>
        </div>

        <%
            } else {
        %>
        <!-- Products Section -->
        <div class="fade-in">
            <a href="user.jsp" class="back-btn">
                <i class="fas fa-arrow-left"></i> Back to Categories
            </a>
            
            <div class="text-center mb-5">
                <h2 class="section-title"><%= selectedCategory %> Collection</h2>
                <p class="text-muted">Discover amazing products in <%= selectedCategory.toLowerCase() %> category</p>
            </div>
            
            <div class="row g-4">
                <%
                    try {
                        String sql = "SELECT * FROM products WHERE category=?";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.setString(1, selectedCategory);
                        ResultSet rs = ps.executeQuery();

                        boolean hasProducts = false;
                        while (rs.next()) {
                            hasProducts = true;
                            int productId = rs.getInt("id");
                            String name = rs.getString("name");
                            String desc = rs.getString("description");
                            double price = rs.getDouble("price");
                            String image = rs.getString("image_url");
                %>
                    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                        <div class="product-card fade-in">
                            <div class="position-relative overflow-hidden">
                                <img src="<%= image %>" class="product-img w-100" alt="<%= name %>" 
                                     onerror="this.src='images/products/placeholder.svg'; this.onerror=null;"
                                     style="min-height: 250px; object-fit: cover;">
                            </div>
                            <div class="product-body">
                                <h5 class="product-title"><%= name %></h5>
                                <p class="product-desc"><%= desc %></p>
                                <div class="product-price">₹ <%= String.format("%.2f", price) %></div>
                                <div class="d-flex align-items-center gap-2 mb-3">
                                    <label for="qty-<%= productId %>" class="text-muted">Qty</label>
                                    <input id="qty-<%= productId %>" type="number" name="quantity" min="1" value="1" class="form-control" style="width:90px;">
                                </div>
                                <div class="d-grid gap-2">
                                    <form method="post" action="addToCart.jsp" class="w-100 d-grid" id="addToCartForm-<%= productId %>">
                                        <input type="hidden" name="product_id" value="<%= productId %>">
                                        <input type="hidden" name="quantity" value="1" id="hiddenQty-<%= productId %>">
                                        <input type="hidden" name="category" value="<%= selectedCategory %>">
                                        <button type="submit" class="add-to-cart-btn w-100">
                                            <i class="fas fa-cart-plus"></i> Add to Cart
                                        </button>
                                    </form>
                                    <form method="post" action="checkout.jsp" class="w-100 d-grid" id="buyNowForm-<%= productId %>">
                                        <input type="hidden" name="buy_now_product_id" value="<%= productId %>">
                                        <input type="hidden" name="quantity" value="1" id="hiddenQtyBuyNow-<%= productId %>">
                                        <button type="submit" class="btn btn-outline-primary" style="border-radius:50px;">
                                            <i class="fas fa-bolt"></i> Buy Now
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                <%
                        }
                        if (!hasProducts) {
                %>
                    <div class="col-12">
                        <div class="empty-state">
                            <i class="fas fa-box-open"></i>
                            <h4>No Products Found</h4>
                            <p>Sorry, we couldn't find any products in the <%= selectedCategory %> category at the moment.</p>
                            <a href="user.jsp" class="back-btn mt-3">
                                <i class="fas fa-arrow-left"></i> Browse Other Categories
                            </a>
                        </div>
                    </div>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <div class="col-12">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle"></i>
                            <strong>Error!</strong> Unable to load products: <%= e.getMessage() %>
                        </div>
                    </div>
                <%
                    }
                %>
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
        // Smooth scrolling for navigation
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
        
        // Add loading state to buttons
        document.querySelectorAll('button[type="submit"]').forEach(button => {
            button.addEventListener('click', function() {
                const originalText = this.innerHTML;
                this.innerHTML = '<span class="loading"></span> Adding...';
                this.disabled = true;
                
                // Re-enable button after form submission (fallback)
                setTimeout(() => {
                    this.innerHTML = originalText;
                    this.disabled = false;
                }, 3000);
            });
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
        
        // Animate elements on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -100px 0px'
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
        
        // Image loading enhancement
        document.querySelectorAll('img').forEach(img => {
            // Add loading class for better UX
            img.addEventListener('loadstart', function() {
                this.style.opacity = '0.7';
            });
            
            img.addEventListener('load', function() {
                this.style.opacity = '1';
            });
        });
        
        // Add hover effects with JavaScript for better performance
        document.querySelectorAll('.category-card, .product-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = this.classList.contains('category-card') ? 
                    'translateY(-10px) scale(1.02)' : 'translateY(-8px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });
        });
        
        // Success notification function
        function showNotification(message, type = 'success') {
            const notification = document.createElement('div');
            notification.className = alert alert-${type} alert-dismissible fade show position-fixed;
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
        
        // Quantity synchronization for all products
        function setupQuantitySync() {
            document.querySelectorAll('input[id^="qty-"]').forEach(qtyInput => {
                const productId = qtyInput.id.replace('qty-', '');
                const hiddenQty = document.getElementById('hiddenQty-' + productId);
                const hiddenQtyBuyNow = document.getElementById('hiddenQtyBuyNow-' + productId);
                
                if (hiddenQty && hiddenQtyBuyNow) {
                    const sync = () => {
                        const value = qtyInput.value || 1;
                        hiddenQty.value = value;
                        hiddenQtyBuyNow.value = value;
                        console.log('Synced quantity for product ' + productId + ': ' + value);
                    };
                    
                    qtyInput.addEventListener('input', sync);
                    qtyInput.addEventListener('change', sync);
                    sync(); // Initial sync
                }
            });
        }
        
        // Setup quantity sync after DOM is loaded
        document.addEventListener('DOMContentLoaded', setupQuantitySync);
        
        // Also setup after any dynamic content is loaded
        setTimeout(setupQuantitySync, 1000);
        
        // Enhanced form submission debugging
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('form[action="addToCart.jsp"]').forEach(form => {
                form.addEventListener('submit', function(e) {
                    const formData = new FormData(form);
                    console.log('Submitting form with data:');
                    for (let [key, value] of formData.entries()) {
                        console.log(key + ': ' + value);
                    }
                });
            });
        });
        
        // Show notification if there's a success message
        <% if (request.getParameter("added") != null) { %>
            <% String productName = request.getParameter("product_name"); %>
            showNotification('<i class="fas fa-check-circle"></i> <%= productName != null ? productName : "Item" %> added to cart successfully!');
        <% } else if (request.getParameter("error") != null) { %>
            <% 
                String error = request.getParameter("error");
                String errorMessage = "Error: Please try again.";
                String available = request.getParameter("available");
                
                if ("missing_product_id".equals(error)) {
                    errorMessage = "Product ID is missing. Please select a valid product.";
                } else if ("missing_quantity".equals(error)) {
                    errorMessage = "Quantity is missing. Please specify how many items you want.";
                } else if ("missing_data".equals(error)) {
                    errorMessage = "Missing required data. Please select a product and quantity.";
                } else if ("invalid_number_format".equals(error)) {
                    errorMessage = "Invalid product ID or quantity format. Please enter valid numbers.";
                } else if ("invalid_data".equals(error)) {
                    errorMessage = "Invalid product or quantity data. Please try again.";
                } else if ("product_not_found".equals(error)) {
                    errorMessage = "Product not found in our catalog. It may have been discontinued.";
                } else if ("insufficient_stock".equals(error)) {
                    if (available != null) {
                        errorMessage = "Insufficient stock! Only " + available + " items available.";
                    } else {
                        errorMessage = "Insufficient stock for this product.";
                    }
                } else if ("database_connection".equals(error)) {
                    errorMessage = "Database connection error. Please try again later.";
                } else if ("database_error".equals(error)) {
                    errorMessage = "Database error occurred. Please try again.";
                } else if ("unexpected_error".equals(error)) {
                    errorMessage = "An unexpected error occurred. Please try again later.";
                } else if ("general_error".equals(error)) {
                    errorMessage = "An error occurred. Please try again later.";
                }
            %>
            showNotification('<i class="fas fa-exclamation-triangle"></i> <%= errorMessage %>', 'danger');
        <% } %>
    </script>
</body>
</html>