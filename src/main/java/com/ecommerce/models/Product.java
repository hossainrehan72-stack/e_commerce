package com.ecommerce.models;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Product model class representing a product in the e-commerce system
 */
public class Product {
    private int id;
    private String name;
    private String description;
    private BigDecimal price;
    private String category;
    private int stockQuantity;
    private String imageUrl;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Default constructor
    public Product() {}
    
    // Constructor for creating new product
    public Product(String name, String description, BigDecimal price, String category, 
                   int stockQuantity, String imageUrl) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.category = category;
        this.stockQuantity = stockQuantity;
        this.imageUrl = imageUrl;
    }
    
    // Full constructor
    public Product(int id, String name, String description, BigDecimal price, String category, 
                   int stockQuantity, String imageUrl, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.category = category;
        this.stockQuantity = stockQuantity;
        this.imageUrl = imageUrl;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    
    // Utility methods
    public boolean isInStock() {
        return stockQuantity > 0;
    }
    
    public boolean isLowStock() {
        return stockQuantity > 0 && stockQuantity <= 10;
    }
    
    @Override
    public String toString() {
        return "Product{id=" + id + ", name='" + name + "', price=" + price + 
               ", category='" + category + "', stock=" + stockQuantity + "}";
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Product product = (Product) obj;
        return id == product.id;
    }
    
    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }
}
