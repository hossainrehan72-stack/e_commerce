-- E-commerce Database Initialization Script
-- Run this script to create the database and populate with sample data

CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    phone VARCHAR(20),
    gender VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(100) NOT NULL,
    stock_quantity INT DEFAULT 0,
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample users (password is plain text for now - will be hashed later)
INSERT IGNORE INTO users (username, email, password, role, phone, gender) VALUES
('Admin User', 'admin@store.com', 'admin123', 'admin', '1234567890', 'other'),
('John Doe', 'john@email.com', 'password123', 'user', '9876543210', 'male'),
('Jane Smith', 'jane@email.com', 'password123', 'user', '5555555555', 'female');

-- Insert sample products
INSERT IGNORE INTO products (name, description, price, category, stock_quantity, image_url) VALUES
('MacBook Pro', 'Apple MacBook Pro 13-inch with M2 chip', 1299.99, 'electronics', 15, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'),
('iPhone 15', 'Latest iPhone with advanced camera system', 999.99, 'electronics', 25, 'https://images.unsplash.com/photo-1556656793-08538906a9f8?w=400'),
('Wireless Headphones', 'Noise-canceling wireless headphones', 199.99, 'electronics', 50, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400'),
('Smart Watch', 'Fitness tracking smart watch', 249.99, 'electronics', 30, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400'),
('Gaming Laptop', 'High-performance gaming laptop', 1599.99, 'electronics', 8, 'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?w=400'),

('Men T-Shirt', 'Comfortable cotton t-shirt for men', 29.99, 'clothing', 100, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400'),
('Women Jeans', 'Stylish denim jeans for women', 79.99, 'clothing', 60, 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=400'),
('Sneakers', 'Comfortable running sneakers', 129.99, 'clothing', 45, 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400'),
('Winter Jacket', 'Warm winter jacket for cold weather', 199.99, 'clothing', 20, 'https://images.unsplash.com/photo-1544966503-7cc5ac882d5f?w=400'),
('Formal Shirt', 'Professional formal shirt', 59.99, 'clothing', 35, 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=400'),

('Programming Book', 'Learn Java programming from basics', 49.99, 'books', 75, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=400'),
('Fiction Novel', 'Best-selling mystery novel', 19.99, 'books', 120, 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400'),
('Self-Help Book', 'Motivational self-improvement book', 24.99, 'books', 90, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400'),
('Cookbook', 'Delicious recipes for healthy cooking', 34.99, 'books', 40, 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400'),
('Science Textbook', 'Comprehensive physics textbook', 89.99, 'books', 25, 'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400'),

('Plant Pot', 'Beautiful ceramic plant pot', 24.99, 'home', 80, 'https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=400'),
('Table Lamp', 'Modern LED table lamp', 79.99, 'home', 35, 'https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=400'),
('Throw Pillow', 'Comfortable decorative pillow', 19.99, 'home', 150, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400'),
('Garden Tools Set', 'Complete gardening tools kit', 149.99, 'home', 20, 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400'),
('Wall Clock', 'Elegant wall clock for home decor', 39.99, 'home', 60, 'https://images.unsplash.com/photo-1563861826100-9cb868fdbe1c?w=400');

SELECT 'Database initialized successfully!' as message;
