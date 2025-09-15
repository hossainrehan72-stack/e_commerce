<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.*" %>
<%@ include file="db.jsp" %>
<%
    // Debug: Print all request parameters
    
    System.out.println("Method: " + request.getMethod());
    System.out.println("Session ID: " + session.getId());
    System.out.println("Session Max Inactive: " + session.getMaxInactiveInterval());
    System.out.println("Session Creation Time: " + new java.util.Date(session.getCreationTime()));
    System.out.println("Session Last Access: " + new java.util.Date(session.getLastAccessedTime()));
    
    // Check session attributes
    String userRole = (String) session.getAttribute("role");
    String sessionUsername = (String) session.getAttribute("username");
    Integer userId = (Integer) session.getAttribute("user_id");
    
    System.out.println("User Role from session: " + userRole);
    System.out.println("Username from session: " + sessionUsername);
    System.out.println("User ID from session: " + userId);
    
    // If this is a POST request, let's see what's being submitted
    if ("POST".equals(request.getMethod())) {
        System.out.println("POST Parameters:");
        java.util.Enumeration<String> params = request.getParameterNames();
        while (params.hasMoreElements()) {
            String param = params.nextElement();
            System.out.println("  " + param + " = " + request.getParameter(param));
        }
    }
    
    // Check if user is logged in as admin
    if (userRole == null || !"admin".equals(userRole)) {
        System.out.println("REDIRECTING TO LOGIN - Role is: " + userRole);
        response.sendRedirect("login.jsp?msg=Session expired. Please login again.");
        return;
    }
    
    System.out.println("Admin access OK - continuing...");
    System.out.println("=========================");
    
    String username = (String) session.getAttribute("username");
    
    // Handle form submissions
    String action = request.getParameter("action");
    String message = "";
    
    if ("addProduct".equals(action)) {
        try {
            String name = request.getParameter("productName");
            String description = request.getParameter("productDesc");
            String price = request.getParameter("productPrice");
            String category = request.getParameter("productCategory");
            String stock = request.getParameter("productStock");
            String imageUrl = request.getParameter("productImage");
            
            // If no image URL provided, use a default placeholder
            if (imageUrl == null || imageUrl.trim().isEmpty()) {
                imageUrl = "images/products/placeholder.svg";
            }
            
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO products (name, description, price, category, stock_quantity, image_url) VALUES (?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, price);
            ps.setString(4, category);
            ps.setString(5, stock);
            ps.setString(6, imageUrl);
            ps.executeUpdate();
            message = "Product added successfully!";
        } catch(Exception e) {
            message = "Error adding product: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard - Sidhi's Store</title>
        <link rel="stylesheet" href="admin-style.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <header class="admin-header">
            <h1><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h1>
            <div>
                <span>Welcome, <%= username %></span>
                <a href="login.jsp" class="logout-btn">Logout</a>
            </div>
        </header>
        
        <div class="admin-container">
            <!-- KPI Dashboard -->
            <div class="kpi-grid">
                <div class="kpi-card">
                    <h3>Total Users</h3>
                    <div class="number">
<%
    try {
        PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) as count FROM users");
        ResultSet rs = ps.executeQuery();
        if(rs.next()) out.print(rs.getInt("count"));
    } catch(Exception e) { out.print("0"); }
%>
                    </div>
                </div>
                <div class="kpi-card">
                    <h3>Total Products</h3>
                    <div class="number">
<%
    try {
        PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) as count FROM products");
        ResultSet rs = ps.executeQuery();
        if(rs.next()) out.print(rs.getInt("count"));
    } catch(Exception e) { out.print("0"); }
%>
                    </div>
                </div>
                <div class="kpi-card">
                    <h3>Low Stock Items</h3>
                    <div class="number">
<%
    try {
        PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) as count FROM products WHERE stock_quantity <= 10");
        ResultSet rs = ps.executeQuery();
        if(rs.next()) out.print(rs.getInt("count"));
    } catch(Exception e) { out.print("0"); }
%>
                    </div>
                </div>
                <div class="kpi-card">
                    <h3>Categories</h3>
                    <div class="number">
<%
    try {
        PreparedStatement ps = con.prepareStatement("SELECT COUNT(DISTINCT category) as count FROM products");
        ResultSet rs = ps.executeQuery();
        if(rs.next()) out.print(rs.getInt("count"));
    } catch(Exception e) { out.print("0"); }
%>
                    </div>
                </div>
            </div>
            
            <!-- Navigation -->
            <div class="admin-nav">
                <div class="nav-tabs">
                    <button class="nav-tab active" onclick="showSection('users')">User Management</button>
                    <button class="nav-tab" onclick="showSection('products')">Product Management</button>
                    <button class="nav-tab" onclick="showSection('inventory')">Inventory</button>
                    <button class="nav-tab" onclick="showSection('orders')">Orders</button>
                    <button class="nav-tab" onclick="showSection('reports')">Reports</button>
                </div>
            </div>
            
            <% if (!message.isEmpty()) { %>
            <div style="background: #d1e7dd; color: #0f5132; padding: 1rem; border-radius: 4px; margin-bottom: 1rem;">
                <%= message %>
            </div>
            <% } %>
            
            <!-- User Management Section -->
            <div id="users" class="content-section active">
                <h2>User Management</h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Phone</th>
                            <th>Created</th>
                        </tr>
                    </thead>
                    <tbody>
<%
    try {
        PreparedStatement ps = con.prepareStatement("SELECT * FROM users ORDER BY created_at DESC");
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
%>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("username") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><span class="status status-<%= rs.getString("role").equals("admin") ? "completed" : "pending" %>"><%= rs.getString("role") %></span></td>
                            <td><%= rs.getString("phone") != null ? rs.getString("phone") : "N/A" %></td>
                            <td><%= rs.getTimestamp("created_at") %></td>
                        </tr>
<%
        }
    } catch(Exception e) {
        out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
                    </tbody>
                </table>
            </div>
            
            <!-- Product Management Section -->
            <div id="products" class="content-section">
                <h2>Product Management</h2>
                <div class="grid">
                    <div>
                        <h3>Add New Product</h3>
                        <form method="post">
                            <input type="hidden" name="action" value="addProduct">
                            <div class="form-group">
                                <label>Product Name:</label>
                                <input type="text" name="productName" required>
                            </div>
                            <div class="form-group">
                                <label>Description:</label>
                                <textarea name="productDesc" rows="3"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Price:</label>
                                <input type="number" name="productPrice" step="0.01" required>
                            </div>
                            <div class="form-group">
                                <label>Category:</label>
                                <select name="productCategory" required>
                                    <option value="electronics">Electronics</option>
                                    <option value="clothing">Clothing</option>
                                    <option value="books">Books</option>
                                    <option value="home">Home & Garden</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Stock Quantity:</label>
                                <input type="number" name="productStock" required>
                            </div>
                            <div class="form-group">
                                <label>Product Image URL (optional):</label>
                                <input type="text" name="productImage" placeholder="https://example.com/image.jpg or leave empty for default">
                                <small>Example: https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300</small>
                            </div>
                            <button type="submit" class="btn btn-primary">Add Product</button>
                        </form>
                    </div>
                    <div>
                        <h3>Existing Products</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>Price</th>
                                    <th>Category</th>
                                    <th>Stock</th>
                                </tr>
                            </thead>
                            <tbody>
<%
    try {
        PreparedStatement ps = con.prepareStatement("SELECT * FROM products ORDER BY created_at DESC LIMIT 10");
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            String imageUrl = rs.getString("image_url");
            if (imageUrl == null || imageUrl.isEmpty()) {
                imageUrl = "images/products/placeholder.svg";
            }
%>
                                <tr>
                                    <td><img src="<%= request.getContextPath() %>/<%= imageUrl %>" alt="Product" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;"></td>
                                    <td><%= rs.getString("name") %></td>
                                    <td>$<%= rs.getBigDecimal("price") %></td>
                                    <td><%= rs.getString("category") %></td>
                                    <td><%= rs.getInt("stock_quantity") %></td>
                                </tr>
<%
        }
    } catch(Exception e) {
        out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- Inventory Management -->
            <div id="inventory" class="content-section">
                <h2>Inventory Management</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Current Stock</th>
                            <th>Status</th>
                            <th>Category</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
<%
    try {
        PreparedStatement ps = con.prepareStatement("SELECT * FROM products ORDER BY stock_quantity ASC");
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            int stock = rs.getInt("stock_quantity");
            String stockStatus = stock < 5 ? "status-cancelled" : stock < 20 ? "status-pending" : "status-completed";
            String stockText = stock < 5 ? "Critical" : stock < 20 ? "Low" : "Good";
%>
                        <tr>
                            <td><%= rs.getString("name") %></td>
                            <td><%= stock %></td>
                            <td><span class="status <%= stockStatus %>"><%= stockText %></span></td>
                            <td><%= rs.getString("category") %></td>
                            <td>$<%= rs.getBigDecimal("price") %></td>
                        </tr>
<%
        }
    } catch(Exception e) {
        out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
                    </tbody>
                </table>
            </div>
            
            <!-- Order Management -->
            <div id="orders" class="content-section">
                <h2>Order Management</h2>
                <p>Order management functionality will be added when order system is implemented.</p>
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="5" style="text-align: center; color: #999;">No orders yet - coming soon!</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Reports Section -->
            <div id="reports" class="content-section">
                <h2>Reports & Analytics</h2>
                <div class="grid">
                    <div>
                        <h3>User Statistics</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>User Type</th>
                                    <th>Count</th>
                                </tr>
                            </thead>
                            <tbody>
<%
    try {
        PreparedStatement ps = con.prepareStatement("SELECT role, COUNT(*) as count FROM users GROUP BY role");
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
%>
                                <tr>
                                    <td><%= rs.getString("role") %></td>
                                    <td><%= rs.getInt("count") %></td>
                                </tr>
<%
        }
    } catch(Exception e) {
        out.println("<tr><td colspan='2'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
                            </tbody>
                        </table>
                    </div>
                    <div>
                        <h3>Product Categories</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>Category</th>
                                    <th>Products</th>
                                    <th>Total Stock</th>
                                </tr>
                            </thead>
                            <tbody>
<%
    try {
        PreparedStatement ps = con.prepareStatement(
            "SELECT category, COUNT(*) as product_count, SUM(stock_quantity) as total_stock FROM products GROUP BY category"
        );
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
%>
                                <tr>
                                    <td><%= rs.getString("category") %></td>
                                    <td><%= rs.getInt("product_count") %></td>
                                    <td><%= rs.getInt("total_stock") %></td>
                                </tr>
<%
        }
    } catch(Exception e) {
        out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            function showSection(sectionName) {
                // Hide all sections
                const sections = document.querySelectorAll('.content-section');
                sections.forEach(section => section.classList.remove('active'));
                
                // Remove active class from all tabs
                const tabs = document.querySelectorAll('.nav-tab');
                tabs.forEach(tab => tab.classList.remove('active'));
                
                // Show selected section
                document.getElementById(sectionName).classList.add('active');
                
                // Add active class to clicked tab
                event.target.classList.add('active');
            }
            
            function previewImage(input) {
                const preview = document.getElementById('imagePreview');
                if (input.files && input.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        preview.innerHTML = '<img src="' + e.target.result + '" style="width: 100px; height: 100px; object-fit: cover; border-radius: 4px;">';
                    }
                    reader.readAsDataURL(input.files[0]);
                } else {
                    preview.innerHTML = '';
                }
            }
        </script>
    </body>
</html>
