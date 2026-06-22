-- Pizza Sales Analysis - Customer Analysis Queries
-- Version 1.0

-- Query 1: Top 10 Customers by Revenue
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(o.order_id) as order_count,
    SUM(o.total_amount) as total_spent,
    ROUND(AVG(o.total_amount), 2) as avg_order_value,
    DATE_FORMAT(MAX(o.order_date), '%Y-%m-%d') as last_order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.delivery_status != 'cancelled'
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC
LIMIT 10;

-- Query 2: Top 10 Customers by Order Frequency
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(o.order_id) as total_orders,
    SUM(o.total_amount) as total_spent,
    ROUND(AVG(o.total_amount), 2) as avg_order_value,
    DATE_FORMAT(MIN(o.order_date), '%Y-%m-%d') as first_order_date,
    DATE_FORMAT(MAX(o.order_date), '%Y-%m-%d') as last_order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.delivery_status != 'cancelled'
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_orders DESC
LIMIT 10;

-- Query 3: Customer Order Distribution
SELECT 
    'Total Customers' as metric,
    COUNT(DISTINCT customer_id) as count
FROM customers
UNION ALL
SELECT 
    'Customers with Orders',
    COUNT(DISTINCT customer_id)
FROM orders
WHERE delivery_status != 'cancelled'
UNION ALL
SELECT 
    'Average Orders per Customer',
    ROUND(COUNT(*) / COUNT(DISTINCT customer_id), 2)
FROM orders
WHERE delivery_status != 'cancelled';

-- Query 4: Customer Spending Distribution
SELECT 
    CASE 
        WHEN total_amount < 20 THEN 'Under $20'
        WHEN total_amount BETWEEN 20 AND 40 THEN '$20-$40'
        WHEN total_amount BETWEEN 40 AND 60 THEN '$40-$60'
        WHEN total_amount BETWEEN 60 AND 80 THEN '$60-$80'
        ELSE 'Over $80'
    END as spending_range,
    COUNT(*) as order_count,
    ROUND(AVG(total_amount), 2) as avg_spending
FROM orders
WHERE delivery_status != 'cancelled'
GROUP BY spending_range
ORDER BY FIELD(spending_range, 'Under $20', '$20-$40', '$40-$60', '$60-$80', 'Over $80');