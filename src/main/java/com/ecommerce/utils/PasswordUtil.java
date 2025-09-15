package com.ecommerce.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Utility class for secure password hashing and verification
 * Uses SHA-256 with salt for security
 */
public class PasswordUtil {
    private static final String HASH_ALGORITHM = "SHA-256";
    private static final int SALT_LENGTH = 16;
    
    /**
     * Generate a random salt
     * @return Base64 encoded salt
     */
    private static String generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[SALT_LENGTH];
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }
    
    /**
     * Hash password with salt
     * @param password Plain text password
     * @param salt Base64 encoded salt
     * @return Base64 encoded hash
     * @throws NoSuchAlgorithmException if hashing algorithm is not available
     */
    private static String hashPassword(String password, String salt) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance(HASH_ALGORITHM);
        md.update(Base64.getDecoder().decode(salt));
        byte[] hashedPassword = md.digest(password.getBytes());
        return Base64.getEncoder().encodeToString(hashedPassword);
    }
    
    /**
     * Hash a password with a new salt
     * @param password Plain text password
     * @return Formatted string: salt:hash
     */
    public static String hashPassword(String password) {
        try {
            String salt = generateSalt();
            String hash = hashPassword(password, salt);
            return salt + ":" + hash;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Password hashing failed", e);
        }
    }
    
    /**
     * Verify password against stored hash
     * @param password Plain text password to verify
     * @param storedHash Stored hash in format salt:hash
     * @return true if password matches, false otherwise
     */
    public static boolean verifyPassword(String password, String storedHash) {
        try {
            String[] parts = storedHash.split(":");
            if (parts.length != 2) {
                return false;
            }
            
            String salt = parts[0];
            String hash = parts[1];
            String hashedInput = hashPassword(password, salt);
            
            return hash.equals(hashedInput);
        } catch (NoSuchAlgorithmException e) {
            System.err.println("Password verification failed: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Check if password meets security requirements
     * @param password Password to validate
     * @return true if password is valid, false otherwise
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        boolean hasUpper = password.chars().anyMatch(Character::isUpperCase);
        boolean hasLower = password.chars().anyMatch(Character::isLowerCase);
        boolean hasDigit = password.chars().anyMatch(Character::isDigit);
        
        return hasUpper && hasLower && hasDigit;
    }
}
