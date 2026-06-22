-- Pizza Sales Analysis - Revenue Analysis Queries
-- Version 1.0

-- Query 1: Total Revenue Metrics
SELECT 
    SUM(total_amount) as total_revenue,
    COUNT(DISTINCT order_id) as total_orders,
    COUNT(DISTINCT customer_id) as unique_customers,
    ROUND(AVG(total_amount), 2) as average_order_value,
    MIN(total_amount) as min_order_value,
    MAX(total_amount) as max_order_value
FROM orders
WHERE delivery_status != 'cancelled';

-- Query 2: Revenue by Pizza Type
SELECT 
    pt.pizza_type_name,
    COUNT(DISTINCT o.order_id) as order_count,
    SUM(oi.quantity) as total_items_sold,
    SUM(oi.total_price) as total_revenue,
    ROUND(AVG(oi.unit_price), 2) as avg_price_per_item,
    ROUND(SUM(oi.total_price) / COUNT(DISTINCT o.order_id), 2) as revenue_per_order
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN pizzas p ON oi.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
WHERE o.delivery_status != 'cancelled'
GROUP BY pt.pizza_type_id, pt.pizza_type_name
ORDER BY total_revenue DESC;

-- Query 3: Revenue by Pizza Size
SELECT 
    oi.pizza_size,
    COUNT(*) as order_item_count,
    SUM(oi.quantity) as total_quantity,
    SUM(oi.total_price) as total_revenue,
    ROUND(AVG(oi.unit_price), 2) as avg_price,
    ROUND(AVG(oi.total_price), 2) as avg_item_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.delivery_status != 'cancelled'
GROUP BY oi.pizza_size
ORDER BY total_revenue DESC;

-- Query 4: Daily Revenue
SELECT 
    DATE_FORMAT(order_date, '%Y-%m-%d') as date,
    DAYNAME(order_date) as day_of_week,
    COUNT(DISTINCT order_id) as total_orders,
    SUM(total_amount) as daily_revenue,
    ROUND(AVG(total_amount), 2) as avg_order_value
FROM orders
WHERE delivery_status != 'cancelled'
GROUP BY DATE_FORMAT(order_date, '%Y-%m-%d'), DAYNAME(order_date)
ORDER BY order_date DESC;

-- Query 5: Monthly Revenue Summary
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') as month,
    COUNT(DISTINCT order_id) as total_orders,
    COUNT(DISTINCT customer_id) as unique_customers,
    SUM(total_amount) as monthly_revenue,
    ROUND(AVG(total_amount), 2) as avg_order_value,
    SUM(total_amount) / COUNT(DISTINCT customer_id) as revenue_per_customer
FROM orders
WHERE delivery_status != 'cancelled'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month DESC;