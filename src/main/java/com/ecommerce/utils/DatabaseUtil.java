package com.ecommerce.utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import javax.servlet.ServletContext;

/**
 * Database utility class for managing database connections
 * Implements proper resource management and configuration loading
 */
public class DatabaseUtil {
    private static String DB_DRIVER;
    private static String DB_URL;
    private static String DB_USERNAME;
    private static String DB_PASSWORD;
    private static boolean initialized = false;
    
    /**
     * Initialize database configuration from properties file
     */
    public static void initialize(ServletContext context) {
        if (!initialized) {
            try (InputStream input = context.getResourceAsStream("/WEB-INF/classes/database.properties")) {
                Properties props = new Properties();
                props.load(input);
                
                DB_DRIVER = props.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");
                DB_URL = props.getProperty("db.url", "jdbc:mysql://localhost:3306/ecommerce?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true");
                DB_USERNAME = props.getProperty("db.username", "root");
                DB_PASSWORD = props.getProperty("db.password", "root@123");
                
                // Load the JDBC driver
                Class.forName(DB_DRIVER);
                initialized = true;
                
            } catch (IOException | ClassNotFoundException e) {
                System.err.println("Failed to initialize database configuration: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Get database connection
     * @return Connection object
     * @throws SQLException if connection cannot be established
     */
    public static Connection getConnection() throws SQLException {
        if (!initialized) {
            throw new SQLException("Database not initialized. Call initialize() first.");
        }
        return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
    }
    
    /**
     * Close database connection safely
     * @param connection Connection to close
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
    
    /**
     * Test database connection
     * @return true if connection is successful, false otherwise
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Database connection test failed: " + e.getMessage());
            return false;
        }
    }
}
