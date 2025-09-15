package com.ecommerce.dao;

import com.ecommerce.models.Product;
import com.ecommerce.utils.DatabaseUtil;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setCategory(rs.getString("category"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setImageUrl(rs.getString("image_url"));
                product.setCreatedAt(rs.getTimestamp("created_at"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category = ? ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setCategory(rs.getString("category"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setImageUrl(rs.getString("image_url"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setCategory(rs.getString("category"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setImageUrl(rs.getString("image_url"));
                return product;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (name, description, price, category, stock_quantity, image_url) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setBigDecimal(3, product.getPrice());
            stmt.setString(4, product.getCategory());
            stmt.setInt(5, product.getStockQuantity());
            stmt.setString(6, product.getImageUrl());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
