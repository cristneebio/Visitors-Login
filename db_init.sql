-- =============================================
-- CCDI Visitor Inquiry Logging System
-- Complete & Fixed Database Initialization Script
-- Works perfectly on MySQL 8.0+ / MariaDB 10.4+
-- =============================================

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS visitor_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE visitor_db;

-- Drop tables if they exist (optional - for fresh reinstall)
DROP TABLE IF EXISTS visitors;
DROP TABLE IF EXISTS users;

-- Users table (for admin/staff login)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Visitors table
CREATE TABLE visitors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    visitor_name VARCHAR(255) NOT NULL,
    visit_date DATE NOT NULL,
    visit_time TIME NOT NULL,
    address VARCHAR(255),
    contact VARCHAR(50),
    school_office VARCHAR(255),
    purpose ENUM('Inquiry', 'Exam', 'Visit', 'Other') DEFAULT 'Inquiry',
    created_by INT NULL,  -- Allow NULL when user is deleted
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Proper foreign key with correct syntax
    CONSTRAINT fk_created_by 
        FOREIGN KEY (created_by) 
        REFERENCES users(id) 
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Insert default admin user
-- Username: admin@example.com
-- Password: Password123!  (hashed with PHP password_hash() -> bcrypt)
INSERT IGNORE INTO users (fullname, email, password_hash) VALUES
('Administrator', 'admin@example.com', '$2y$10$e0NRKxv1oZk6Y1sQeGZKkOSy9i3nX1E2f0c5oG8q6zKqf0JYJ6f6e');

-- Insert sample visitors (will work now because user ID 1 exists)
INSERT INTO visitors (
    visitor_name,
    visit_date,
    visit_time,
    address,
    contact,
    school_office,
    purpose,
    created_by
) VALUES
('Maria Clara Santos',   CURDATE(), CURTIME(), 'Bibincahan, Sorsogon City',     '09123456789', 'DepEd Sorsogon', 'Visit',    1),
('John Lloyd Cruz',      CURDATE(), CURTIME(), 'Talisay, Sorsogon City',        '09987654321', 'CCDI',           'Exam',     1),
('Catherine Bernardo',   CURDATE(), CURTIME(), 'Cambulaga, Sorsogon City',      '09234567890', 'Guidance Office','Other',    1);

-- Optional: Show success message (for phpMyAdmin or tools that support it)
SELECT 'Database "visitor_db" created successfully with sample data!' AS status;