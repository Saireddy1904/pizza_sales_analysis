-- Monthly Summary Report
-- Month-over-month performance analysis

SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') as 'Month',
    COUNT(DISTINCT o.order_id) as 'Total Orders',
    COUNT(DISTINCT o.customer_id) as 'Unique Customers',
    SUM(oi.quantity) as 'Items Sold',
    CONCAT('$', FORMAT(SUM(o.total_amount), 2)) as 'Total Revenue',
    CONCAT('$', FORMAT(ROUND(AVG(o.total_amount), 2), 2)) as 'Avg Order Value',
    CONCAT('$', FORMAT(ROUND(SUM(o.total_amount) / COUNT(DISTINCT o.customer_id), 2), 2)) as 'Revenue per Customer',
    ROUND(COUNT(DISTINCT o.order_id) / COUNT(DISTINCT o.customer_id), 2) as 'Orders per Customer'
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.delivery_status != 'cancelled'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY DATE_FORMAT(o.order_date, '%Y-%m') DESC;