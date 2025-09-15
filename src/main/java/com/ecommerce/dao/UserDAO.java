package com.ecommerce.dao;

import com.ecommerce.models.User;
import com.ecommerce.utils.DatabaseUtil;
import java.sql.*;

public class UserDAO {
    
    public User getUserByEmailAndPassword(String email, String password, String role) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND role = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.setString(3, role);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setPhone(rs.getString("phone"));
                user.setGender(rs.getString("gender"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, password, role, phone, email, gender) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getRole());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getEmail());
            stmt.setString(6, user.getGender());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setPhone(rs.getString("phone"));
                user.setGender(rs.getString("gender"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
