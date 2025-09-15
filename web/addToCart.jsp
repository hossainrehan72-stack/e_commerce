<%@ page import="java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Get product ID and quantity from the request
    String productIdStr = request.getParameter("product_id");
    String quantityStr = request.getParameter("quantity");
    
    if (productIdStr != null && quantityStr != null) {
        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);
            
            // Ensure quantity is at least 1
            if (quantity < 1) {
                quantity = 1;
            }
            
            // Get or create cart from session
            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
            if (cart == null) {
                cart = new HashMap<Integer, Integer>();
                session.setAttribute("cart", cart);
            }
            
            // Add or update item in cart
            if (cart.containsKey(productId)) {
                // If item already exists, add to existing quantity
                cart.put(productId, cart.get(productId) + quantity);
            } else {
                // If new item, add with specified quantity
                cart.put(productId, quantity);
            }
            
            // Redirect back to user page with success message
            String category = request.getParameter("category");
            if (category != null) {
                response.sendRedirect("user.jsp?category=" + category + "&added=true");
            } else {
                response.sendRedirect("user.jsp?added=true");
            }
            
        } catch (NumberFormatException e) {
            // Invalid product ID or quantity
            response.sendRedirect("user.jsp?error=invalid_data");
        }
    } else {
        // Missing parameters
        response.sendRedirect("user.jsp?error=missing_data");
    }
%>
