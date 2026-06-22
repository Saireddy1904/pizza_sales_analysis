-- Pizza Sales Analysis - Sample Data
-- Version 1.0

-- Insert Pizza Types
INSERT INTO pizza_types (pizza_type_name, description) VALUES
('Classic', 'Traditional pizza recipes'),
('Veggie', 'Vegetable-based pizzas'),
('Chicken', 'Chicken toppings pizzas'),
('Meats', 'Meat lovers pizzas'),
('Supreme', 'Premium pizza combinations');

-- Insert Pizzas
INSERT INTO pizzas (pizza_name, pizza_type_id, price) VALUES
('Margherita', 1, 9.99),
('Pepperoni', 1, 10.99),
('Vegetarian', 2, 9.99),
('Spinach & Feta', 2, 11.99),
('BBQ Chicken', 3, 12.99),
('Grilled Chicken', 3, 11.99),
('Meat Supreme', 4, 14.99),
('The Meatlover', 4, 15.99),
('Supreme Deluxe', 5, 16.99),
('Italian Sausage', 1, 11.99);

-- Insert Sample Customers
INSERT INTO customers (customer_name, email, phone, city) VALUES
('John Smith', 'john.smith@email.com', '555-0101', 'New York'),
('Sarah Johnson', 'sarah.j@email.com', '555-0102', 'Los Angeles'),
('Michael Brown', 'mbrown@email.com', '555-0103', 'Chicago'),
('Emily Davis', 'emily.d@email.com', '555-0104', 'Houston'),
('Robert Wilson', 'rwilson@email.com', '555-0105', 'Phoenix'),
('Jennifer Martinez', 'jmartinez@email.com', '555-0106', 'Philadelphia'),
('David Anderson', 'danderson@email.com', '555-0107', 'San Antonio'),
('Lisa Taylor', 'ltaylor@email.com', '555-0108', 'San Diego'),
('James Thomas', 'jthomas@email.com', '555-0109', 'Dallas'),
('Mary Jackson', 'mjackson@email.com', '555-0110', 'Austin');

-- Insert Sample Orders (adjust dates as needed)
INSERT INTO orders (customer_id, order_date, order_time, total_amount, delivery_status) VALUES
(1, '2026-06-01', '11:30:00', 45.97, 'delivered'),
(2, '2026-06-01', '12:15:00', 32.98, 'delivered'),
(3, '2026-06-02', '18:45:00', 58.96, 'delivered'),
(4, '2026-06-02', '19:20:00', 41.97, 'delivered'),
(5, '2026-06-03', '12:00:00', 55.96, 'delivered'),
(6, '2026-06-03', '19:00:00', 67.95, 'delivered'),
(7, '2026-06-04', '11:45:00', 38.98, 'delivered'),
(8, '2026-06-04', '18:30:00', 49.97, 'delivered'),
(9, '2026-06-05', '12:30:00', 62.94, 'delivered'),
(10, '2026-06-05', '19:15:00', 45.97, 'delivered');

-- Insert Sample Order Items
INSERT INTO order_items (order_id, pizza_id, pizza_size, quantity, unit_price, total_price) VALUES
(1, 1, 'Large', 2, 9.99, 19.98),
(1, 3, 'Medium', 1, 9.99, 9.99),
(1, 5, 'Large', 1, 12.99, 12.99),
(2, 2, 'Large', 2, 10.99, 21.98),
(2, 4, 'Medium', 1, 11.99, 11.99),
(3, 6, 'Large', 2, 11.99, 23.98),
(3, 9, 'Large', 2, 16.99, 33.98),
(4, 8, 'Large', 2, 15.99, 31.98),
(4, 3, 'Medium', 1, 9.99, 9.99),
(5, 7, 'Large', 2, 14.99, 29.98),
(5, 5, 'Large', 1, 12.99, 12.99),
(5, 10, 'Large', 1, 11.99, 11.99),
(6, 9, 'XL', 2, 16.99, 33.98),
(6, 2, 'Large', 2, 10.99, 21.98),
(6, 6, 'Large', 1, 11.99, 11.99),
(7, 1, 'Large', 1, 9.99, 9.99),
(7, 4, 'Medium', 2, 11.99, 23.98),
(7, 5, 'Large', 1, 12.99, 12.99),
(8, 3, 'Large', 1, 9.99, 9.99),
(8, 8, 'Large', 2, 15.99, 31.98),
(8, 10, 'Medium', 1, 11.99, 11.99),
(9, 7, 'Large', 2, 14.99, 29.98),
(9, 6, 'Large', 2, 11.99, 23.98),
(9, 2, 'Large', 1, 10.99, 10.99),
(10, 9, 'Large', 2, 16.99, 33.98),
(10, 5, 'Large', 1, 12.99, 12.99);