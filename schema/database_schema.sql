-- Pizza Sales Analysis - MySQL Database Schema
-- Version 1.0
-- Created: June 2026

-- Drop existing tables if they exist (for fresh installation)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS pizzas;
DROP TABLE IF EXISTS pizza_types;

-- Create pizza_types table
CREATE TABLE pizza_types (
    pizza_type_id INT AUTO_INCREMENT PRIMARY KEY,
    pizza_type_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create pizzas table
CREATE TABLE pizzas (
    pizza_id INT AUTO_INCREMENT PRIMARY KEY,
    pizza_name VARCHAR(100) NOT NULL,
    pizza_type_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pizza_type_id) REFERENCES pizza_types(pizza_type_id)
);

-- Create customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(50),
    postal_code VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    delivery_status ENUM('pending', 'processing', 'delivered', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    INDEX idx_order_date (order_date),
    INDEX idx_order_time (order_time)
);

-- Create order_items table
CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id INT NOT NULL,
    pizza_size VARCHAR(20) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id),
    INDEX idx_pizza_id (pizza_id),
    INDEX idx_order_id (order_id)
);

-- Create indexes for better query performance
CREATE INDEX idx_pizza_type_id ON pizzas(pizza_type_id);
CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_pizza_size ON order_items(pizza_size);

echo 'Database schema created successfully!';