-- E-commerce Database Setup Script
-- Run this script in MySQL to create the required database and tables

CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') NOT NULL DEFAULT 'user',
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE NOT NULL,
    gender ENUM('male', 'female', 'other', 'prefer-not'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert a default admin user (password: admin123)
INSERT INTO users (username, password, role, phone, email, gender) VALUES 
('admin', 'admin123', 'admin', '1234567890', 'admin@store.com', 'other'),
('testuser', 'user123', 'user', '9876543210', 'user@store.com', 'male');

-- Products table (for future use)
CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(100),
    stock_quantity INT DEFAULT 0,
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample products
INSERT INTO products (name, description, price, category, stock_quantity, image_url) VALUES 
('Laptop', 'High-performance laptop', 999.99, 'electronics', 10, 'https://via.placeholder.com/300'),
('T-Shirt', 'Comfortable cotton t-shirt', 29.99, 'clothing', 50, 'https://via.placeholder.com/300'),
('Book', 'Programming guide', 49.99, 'books', 25, 'https://via.placeholder.com/300');

-- Cart table (for future use)
CREATE TABLE IF NOT EXISTS cart (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    quantity INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Show created tables
SHOW TABLES;
