-- Create the ecommerce database
CREATE DATABASE ecommerce;

-- Use the ecommerce database
USE ecommerce;

-- Create the customers table
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    address TEXT
);

-- Create the orders table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Create the products table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);

-- Insert sample data into customers table
INSERT INTO customers (name, email, address) VALUES
('John Doe', 'john.doe@example.com', '123 Elm Street'),
('Jane Smith', 'jane.smith@example.com', '456 Oak Avenue'),
('Emily Johnson', 'emily.johnson@example.com', '789 Pine Lane');

-- Insert sample data into orders table
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-12-01', 150.75),
(2, '2024-12-05', 200.50),
(3, '2024-12-10', 320.20);

-- Insert sample data into products table
INSERT INTO products (name, price, description) VALUES
('Laptop', 1200.00, 'High-performance laptop'),
('Smartphone', 800.00, 'Latest model smartphone'),
('Headphones', 150.00, 'Noise-cancelling headphones');
