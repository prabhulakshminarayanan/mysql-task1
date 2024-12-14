--Retrieve all customers who have placed an order in the last 30 days.
SELECT * FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
    WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
);

SELECT DISTINCT c.id, c.name, c.email, c.address
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

--Get the total amount of all orders placed by each customer.
SELECT customer_id, SUM(total_amount) AS total_amount
FROM orders
GROUP BY customer_id;

SELECT c.id AS customer_id, c.name AS customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name;

--Update the price of Product C to 45.00.
UPDATE products
SET price = 45.00
WHERE name = 'Headphones';

--Add a new column discount to the products table.
ALTER TABLE products
ADD COLUMN discount DECIMAL(5, 2) DEFAULT 0.00;

--Retrieve the top 3 products with the highest price.
SELECT id, name, price, description
FROM products
ORDER BY price DESC
LIMIT 3;

--Get the names of customers who have ordered Product A.
-- we need a new table order_products 
CREATE TABLE order_products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

SELECT DISTINCT c.name AS customer_name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.name = 'Headphones';

--Join the orders and customers tables to retrieve the customer's name and order date for each order.
SELECT c.name AS customer_name, o.order_date
FROM customers c
JOIN orders o ON c.id = o.customer_id;

--Retrieve the total amount greater than 150 of each order, including the customer's name and order date.
SELECT c.name AS customer_name, o.order_date, SUM(oi.quantity * p.price) AS total_amount
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY c.name, o.order_date;
having total_amount > 150;

--Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table.
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
insert into order_items (order_id, product_id, quantity)
SELECT id, product_id, quantity FROM orders;

--Retrieve average total for all orders
SELECT AVG(total_amount) AS average_total_amount
FROM orders;






