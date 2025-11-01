/* ==========================================================
   📊 FINAL CASE STUDY: BUSINESS ANALYSIS USING SQL
   Tables: customers, orders, order_items, products
   Goal: End-to-end SQL analysis combining joins, CTEs, 
   window functions, and business metrics
   ========================================================== */

/* --------------------------------------------
   🧩 Step 1. Total Revenue & Orders Overview
   -------------------------------------------- */
SELECT 
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    SUM(o.total_amount) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM orders AS o
WHERE o.order_status = 'Completed';


/* --------------------------------------------
   💳 Step 2. Revenue by Payment Method
   -------------------------------------------- */
SELECT 
    payment_method,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(100.0 * SUM(total_amount) / SUM(SUM(total_amount)) OVER(), 2) AS revenue_percent
FROM orders
WHERE order_status = 'Completed'
GROUP BY payment_method
ORDER BY total_revenue DESC;


/* --------------------------------------------
   🧍 Step 3. Repeat Customer Rate
   -------------------------------------------- */
WITH customer_orders AS (
    SELECT 
        customer_id,
        COUNT(order_id) AS total_orders
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
)
SELECT 
    COUNT(CASE WHEN total_orders > 1 THEN 1 END) * 100.0 / COUNT(*) AS repeat_customer_rate_percent
FROM customer_orders;


/* --------------------------------------------
   📦 Step 4. Top 5 Products by Revenue
   -------------------------------------------- */
SELECT 
    p.product_name,
    p.category,
    SUM((p.price - p.cost) * oi.quantity) AS gross_margin
FROM order_items AS oi
JOIN products AS p 
    ON oi.product_id = p.product_id
JOIN orders AS o 
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_name, p.category
ORDER BY gross_margin DESC
LIMIT 5;


/* --------------------------------------------
   🗓️ Step 5. Monthly KPIs – Revenue Trend
   -------------------------------------------- */
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM orders
WHERE order_status = 'Completed'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;


/* --------------------------------------------
   🔁 Step 6. Year-over-Year (YoY) Revenue Growth
   -------------------------------------------- */
WITH monthly_revenue AS (
    SELECT 
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        SUM(total_amount) AS revenue
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT 
    year,
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY year, month) AS prev_revenue,
    ROUND((revenue - LAG(revenue) OVER (ORDER BY year, month)) * 100.0 / LAG(revenue) OVER (ORDER BY year, month), 2) AS yoy_growth_percent
FROM monthly_revenue;


/* --------------------------------------------
   🧠 Step 7. Pareto (80/20 Rule) – Top Customers by Revenue
   -------------------------------------------- */
WITH customer_revenue AS (
    SELECT 
        c.customer_id,
        c.name,
        SUM(o.total_amount) AS total_revenue
    FROM customers AS c
    JOIN orders AS o 
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id, c.name
),
revenue_rank AS (
    SELECT 
        *,
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC) AS cum_revenue,
        SUM(total_revenue) OVER () AS total_rev
    FROM customer_revenue
)
SELECT 
    name,
    total_revenue,
    ROUND(cum_revenue * 100.0 / total_rev, 2) AS cum_percent
FROM revenue_rank
WHERE cum_revenue <= 0.8 * total_rev
ORDER BY total_revenue DESC;


/* --------------------------------------------
   🧾 Step 8. Combined Summary Snapshot
   -------------------------------------------- */
WITH metrics AS (
    SELECT 
        COUNT(DISTINCT o.order_id) AS total_orders,
        COUNT(DISTINCT o.customer_id) AS unique_customers,
        SUM(o.total_amount) AS total_revenue
    FROM orders AS o
    WHERE o.order_status = 'Completed'
)
SELECT 
    total_orders,
    unique_customers,
    total_revenue,
    ROUND(total_revenue / total_orders, 2) AS avg_order_value,
    ROUND(total_revenue / unique_customers, 2) AS revenue_per_customer
FROM metrics;

-- ✅ End of Final_Case_Study.sql
