-- Daily Sales Report
-- Generates comprehensive daily sales metrics

SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m-%d') as Date,
    DAYNAME(o.order_date) as Day,
    COUNT(DISTINCT o.order_id) as 'Total Orders',
    COUNT(DISTINCT o.customer_id) as 'Unique Customers',
    CONCAT('$', FORMAT(SUM(o.total_amount), 2)) as 'Total Revenue',
    CONCAT('$', FORMAT(ROUND(AVG(o.total_amount), 2), 2)) as 'Avg Order Value',
    SUM(oi.quantity) as 'Items Sold',
    CONCAT('$', FORMAT(MIN(o.total_amount), 2)) as 'Min Order',
    CONCAT('$', FORMAT(MAX(o.total_amount), 2)) as 'Max Order'
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.delivery_status != 'cancelled'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m-%d'), DAYNAME(o.order_date)
ORDER BY o.order_date DESC;