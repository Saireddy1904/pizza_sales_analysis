-- Category Breakdown Report
-- Sales analysis by pizza category

SELECT 
    pt.pizza_type_name as 'Category',
    COUNT(DISTINCT o.order_id) as 'Orders',
    COUNT(DISTINCT o.customer_id) as 'Customers',
    SUM(oi.quantity) as 'Items Sold',
    CONCAT('$', FORMAT(SUM(oi.total_price), 2)) as 'Total Revenue',
    CONCAT('$', FORMAT(ROUND(AVG(oi.unit_price), 2), 2)) as 'Avg Item Price',
    CONCAT('$', FORMAT(ROUND(SUM(oi.total_price) / COUNT(DISTINCT o.order_id), 2), 2)) as 'Revenue per Order',
    CONCAT(ROUND(SUM(oi.total_price) / (SELECT SUM(total_amount) FROM orders WHERE delivery_status != 'cancelled') * 100, 1), '%') as '% of Total Revenue'
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN pizzas p ON oi.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
WHERE o.delivery_status != 'cancelled'
GROUP BY pt.pizza_type_id, pt.pizza_type_name
ORDER BY SUM(oi.total_price) DESC;