package com.ecommerce.models;

import java.sql.Timestamp;

/**
 * User model class representing a user in the e-commerce system
 */
public class User {
    private int id;
    private String username;
    private String email;
    private String password;
    private String role;
    private String phone;
    private String gender;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Default constructor
    public User() {}
    
    // Constructor for creating new user
    public User(String username, String email, String password, String role, String phone, String gender) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.role = role;
        this.phone = phone;
        this.gender = gender;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    
    @Override
    public String toString() {
        return "User{id=" + id + ", username='" + username + "', email='" + email + "', role='" + role + "'}";
    }
}
