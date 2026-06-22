-- Pizza Sales Analysis - Trend Analysis Queries
-- Version 1.0

-- Query 1: Hourly Sales Pattern
SELECT 
    HOUR(order_time) as hour,
    CONCAT(LPAD(HOUR(order_time), 2, '0'), ':00 - ', LPAD(HOUR(order_time), 2, '0'), ':59') as time_slot,
    COUNT(*) as order_count,
    SUM(total_amount) as hourly_revenue,
    ROUND(AVG(total_amount), 2) as avg_order_value,
    ROUND(SUM(total_amount) / COUNT(*), 2) as revenue_per_order
FROM orders
WHERE delivery_status != 'cancelled'
GROUP BY HOUR(order_time)
ORDER BY hour;

-- Query 2: Day of Week Analysis
SELECT 
    DAYNAME(order_date) as day_name,
    CASE WHEN DAYNAME(order_date) IN ('Saturday', 'Sunday') THEN 'Weekend' ELSE 'Weekday' END as day_type,
    COUNT(*) as order_count,
    SUM(total_amount) as daily_revenue,
    ROUND(AVG(total_amount), 2) as avg_order_value
FROM orders
WHERE delivery_status != 'cancelled'
GROUP BY DAYNAME(order_date), day_type
ORDER BY FIELD(DAYNAME(order_date), 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Query 3: Weekly Sales Trend
SELECT 
    DATE_FORMAT(order_date, '%Y-W%u') as week,
    DATE_FORMAT(MIN(order_date), '%Y-%m-%d') as week_start,
    DATE_FORMAT(MAX(order_date), '%Y-%m-%d') as week_end,
    COUNT(DISTINCT order_id) as weekly_orders,
    SUM(total_amount) as weekly_revenue,
    ROUND(AVG(total_amount), 2) as avg_order_value
FROM orders
WHERE delivery_status != 'cancelled'
GROUP BY DATE_FORMAT(order_date, '%Y-W%u')
ORDER BY week DESC;

-- Query 4: Month-over-Month Comparison
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') as month,
    COUNT(DISTINCT order_id) as orders,
    COUNT(DISTINCT customer_id) as unique_customers,
    SUM(total_amount) as revenue,
    ROUND(AVG(total_amount), 2) as avg_order_value,
    ROUND(SUM(total_amount) / COUNT(DISTINCT customer_id), 2) as revenue_per_customer
FROM orders
WHERE delivery_status != 'cancelled'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month DESC;

-- Query 5: Peak Days and Hours
SELECT 
    'Peak Day' as metric,
    DAYNAME(order_date) as value,
    COUNT(*) as frequency,
    SUM(total_amount) as total_revenue
FROM orders
WHERE delivery_status != 'cancelled'
GROUP BY DAYNAME(order_date)
ORDER BY total_revenue DESC
LIMIT 1
UNION ALL
SELECT 
    'Peak Hour',
    CONCAT(LPAD(HOUR(order_time), 2, '0'), ':00'),
    COUNT(*),
    SUM(total_amount)
FROM orders
WHERE delivery_status != 'cancelled'
GROUP BY HOUR(order_time)
ORDER BY SUM(total_amount) DESC
LIMIT 1;