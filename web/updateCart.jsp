<%@ page import="java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String action = request.getParameter("action");
    String productIdStr = request.getParameter("product_id");
    
    // Get cart from session
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    if (cart == null) {
        cart = new HashMap<Integer, Integer>();
        session.setAttribute("cart", cart);
    }
    
    if ("clear".equals(action)) {
        // Clear entire cart
        cart.clear();
        response.sendRedirect("cart.jsp?cleared=true");
        return;
    }
    
    if (productIdStr != null) {
        try {
            int productId = Integer.parseInt(productIdStr);
            
            if ("increase".equals(action)) {
                // Increase quantity by 1
                if (cart.containsKey(productId)) {
                    cart.put(productId, cart.get(productId) + 1);
                }
                response.sendRedirect("cart.jsp?success=true");
                
            } else if ("decrease".equals(action)) {
                // Decrease quantity by 1, remove if reaches 0
                if (cart.containsKey(productId)) {
                    int currentQty = cart.get(productId);
                    if (currentQty > 1) {
                        cart.put(productId, currentQty - 1);
                        response.sendRedirect("cart.jsp?success=true");
                    } else {
                        cart.remove(productId);
                        response.sendRedirect("cart.jsp?removed=true");
                    }
                }
                
            } else if ("remove".equals(action)) {
                // Remove item completely
                cart.remove(productId);
                response.sendRedirect("cart.jsp?removed=true");
                
            } else if ("set".equals(action)) {
                // Set specific quantity
                String quantityStr = request.getParameter("quantity");
                if (quantityStr != null) {
                    int quantity = Integer.parseInt(quantityStr);
                    if (quantity > 0) {
                        cart.put(productId, quantity);
                    } else {
                        cart.remove(productId);
                    }
                }
                response.sendRedirect("cart.jsp?success=true");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("cart.jsp?error=invalid_data");
        }
    } else {
        response.sendRedirect("cart.jsp?error=missing_data");
    }
%>
