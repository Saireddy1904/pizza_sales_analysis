-- Pizza Sales Analysis - Basic Queries
-- Version 1.0

-- Query 1: Total number of orders
SELECT 
    COUNT(*) as total_orders,
    COUNT(DISTINCT customer_id) as unique_customers,
    DATE_FORMAT(MIN(order_date), '%Y-%m-%d') as first_order_date,
    DATE_FORMAT(MAX(order_date), '%Y-%m-%d') as last_order_date
FROM orders;

-- Query 2: All pizzas with their types and prices
SELECT 
    p.pizza_id,
    p.pizza_name,
    pt.pizza_type_name,
    p.price,
    p.is_active
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY pt.pizza_type_name, p.pizza_name;

-- Query 3: Recent orders
SELECT 
    o.order_id,
    c.customer_name,
    o.order_date,
    o.order_time,
    o.total_amount,
    o.delivery_status
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC, o.order_time DESC
LIMIT 20;

-- Query 4: Order details with pizza information
SELECT 
    o.order_id,
    c.customer_name,
    DATE_FORMAT(o.order_date, '%Y-%m-%d') as order_date,
    TIME_FORMAT(o.order_time, '%H:%i:%s') as order_time,
    p.pizza_name,
    oi.pizza_size,
    oi.quantity,
    oi.unit_price,
    oi.total_price,
    pt.pizza_type_name
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN pizzas p ON oi.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
LEFT JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_id DESC
LIMIT 50;