package com.ecommerce.servlets;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.models.Product;
import com.ecommerce.utils.DatabaseUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    
    private ProductDAO productDAO;
    
    @Override
    public void init() {
        DatabaseUtil.initialize(getServletContext());
        productDAO = new ProductDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String category = request.getParameter("category");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            List<Product> products;
            
            if ("category".equals(action) && category != null) {
                products = productDAO.getProductsByCategory(category);
            } else {
                products = productDAO.getAllProducts();
            }
            
            // Simple JSON response
            out.print("[");
            for (int i = 0; i < products.size(); i++) {
                Product p = products.get(i);
                if (i > 0) out.print(",");
                out.print("{");
                out.print("\"id\":" + p.getId() + ",");
                out.print("\"name\":\"" + escapeJson(p.getName()) + "\",");
                out.print("\"description\":\"" + escapeJson(p.getDescription()) + "\",");
                out.print("\"price\":" + p.getPrice() + ",");
                out.print("\"category\":\"" + escapeJson(p.getCategory()) + "\",");
                out.print("\"stock\":" + p.getStockQuantity() + ",");
                out.print("\"imageUrl\":\"" + escapeJson(p.getImageUrl()) + "\"");
                out.print("}");
            }
            out.print("]");
            
        } catch (Exception e) {
            response.setStatus(500);
            out.print("{\"error\":\"Failed to fetch products\"}");
            e.printStackTrace();
        }
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}
