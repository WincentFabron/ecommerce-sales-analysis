-- KPI Summary
SELECT 
    ROUND(SUM(total_order_value), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(total_order_value) / COUNT(DISTINCT order_id), 2) AS avg_order_value,
    ROUND(
        COUNT(DISTINCT CASE WHEN delivery_status = 'Delayed' THEN order_id END) * 100.0
        / COUNT(DISTINCT order_id),
        2
    ) AS delay_rate
FROM ecommerce_main;


-- Monthly Sales
SELECT 
    strftime('%Y-%m', order_purchase_timestamp) AS month,
    ROUND(SUM(total_order_value), 2) AS revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(total_order_value) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM ecommerce_main
GROUP BY month
ORDER BY month;


-- Top 10 Product Categories
SELECT 
    product_category_name,
    ROUND(SUM(total_order_value), 2) AS revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM ecommerce_main
WHERE product_category_name IS NOT NULL
GROUP BY product_category_name
ORDER BY revenue DESC
LIMIT 10;


-- Top 10 States by Revenue
SELECT 
    customer_state,
    ROUND(SUM(total_order_value), 2) AS revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM ecommerce_main
GROUP BY customer_state
ORDER BY revenue DESC
LIMIT 10;


-- Delivery Status vs Review Score
SELECT 
    delivery_status,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    ROUND(AVG(delivery_days), 2) AS avg_delivery_days
FROM ecommerce_main
WHERE review_score IS NOT NULL
GROUP BY delivery_status;