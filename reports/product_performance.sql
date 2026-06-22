-- Product Performance Report
-- Top performing pizzas with detailed metrics

SELECT 
    p.pizza_name as 'Pizza Name',
    pt.pizza_type_name as 'Type',
    CONCAT('$', FORMAT(p.price, 2)) as 'Price',
    COUNT(DISTINCT o.order_id) as 'Orders',
    SUM(oi.quantity) as 'Qty Sold',
    CONCAT('$', FORMAT(SUM(oi.total_price), 2)) as 'Revenue',
    ROUND(SUM(oi.total_price) / COUNT(DISTINCT o.order_id), 2) as 'Rev per Order',
    ROUND(SUM(oi.quantity) / COUNT(DISTINCT o.order_id), 2) as 'Avg Qty per Order'
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN pizzas p ON oi.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
WHERE o.delivery_status != 'cancelled'
GROUP BY p.pizza_id, p.pizza_name, pt.pizza_type_name, p.price
ORDER BY SUM(oi.total_price) DESC;