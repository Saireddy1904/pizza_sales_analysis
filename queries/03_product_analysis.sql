-- Pizza Sales Analysis - Product Analysis Queries
-- Version 1.0

-- Query 1: Top 10 Pizzas by Revenue
SELECT 
    p.pizza_id,
    p.pizza_name,
    pt.pizza_type_name,
    COUNT(DISTINCT o.order_id) as order_count,
    SUM(oi.quantity) as total_sold,
    SUM(oi.total_price) as total_revenue,
    ROUND(AVG(oi.unit_price), 2) as avg_price,
    ROUND(SUM(oi.total_price) / COUNT(DISTINCT o.order_id), 2) as revenue_per_order
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN pizzas p ON oi.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
WHERE o.delivery_status != 'cancelled'
GROUP BY p.pizza_id, p.pizza_name, pt.pizza_type_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Query 2: Top 10 Pizzas by Quantity Sold
SELECT 
    p.pizza_id,
    p.pizza_name,
    pt.pizza_type_name,
    SUM(oi.quantity) as total_quantity,
    COUNT(DISTINCT o.order_id) as order_count,
    SUM(oi.total_price) as total_revenue,
    ROUND(p.price, 2) as current_price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN pizzas p ON oi.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
WHERE o.delivery_status != 'cancelled'
GROUP BY p.pizza_id, p.pizza_name, pt.pizza_type_name, p.price
ORDER BY total_quantity DESC
LIMIT 10;

-- Query 3: Least Popular Pizzas
SELECT 
    p.pizza_id,
    p.pizza_name,
    pt.pizza_type_name,
    COUNT(DISTINCT o.order_id) as order_count,
    SUM(oi.quantity) as total_quantity,
    SUM(oi.total_price) as total_revenue,
    ROUND(p.price, 2) as price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN pizzas p ON oi.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
WHERE o.delivery_status != 'cancelled'
GROUP BY p.pizza_id, p.pizza_name, pt.pizza_type_name, p.price
HAVING COUNT(DISTINCT o.order_id) > 0
ORDER BY order_count ASC
LIMIT 10;

-- Query 4: Pizza Performance by Size
SELECT 
    p.pizza_name,
    oi.pizza_size,
    COUNT(*) as frequency,
    SUM(oi.quantity) as total_quantity,
    SUM(oi.total_price) as revenue,
    ROUND(AVG(oi.unit_price), 2) as avg_price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN pizzas p ON oi.pizza_id = p.pizza_id
WHERE o.delivery_status != 'cancelled'
GROUP BY p.pizza_name, oi.pizza_size
ORDER BY p.pizza_name, revenue DESC;