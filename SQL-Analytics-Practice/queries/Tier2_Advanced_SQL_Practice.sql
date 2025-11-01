-------------------------------------------------------
-- 🚀 Tier 2 – Advanced & Business-Oriented SQL (26–50)
-------------------------------------------------------

-- 26. For each customer, compute first_order_date and last_order_date from orders.
select 
    c.name, 
    min(o.order_date) as first_order_date, 
    max(o.order_date) as last_order_date
from customers as c
join orders as o 
    on c.customer_id = o.customer_id
group by c.name;


-- 27. Use a window SUM() OVER to compute a running total of total_amount ordered by order_date.
select 
    order_date,
    total_amount, 
    sum(total_amount) over(order by order_date) as running_total
from orders;


-- 28. For each customer, use ROW_NUMBER() to retrieve the second most recent order (if exists).
with cte as (
    select 
        c.name, 
        o.order_date, 
        row_number() over(partition by c.name order by o.order_date desc) as rn
    from customers as c
    join orders as o 
        on c.customer_id = o.customer_id
)
select * 
from cte
where rn = 2;


-- 29. Using LAG(), calculate the difference in days between consecutive orders per customer.
select 
    c.name, 
    o.order_date,
    lag(order_date) over(partition by c.name order by o.order_date) as previous_order, 
    datediff(o.order_date, lag(order_date) over(partition by c.name order by o.order_date)) as diff_days
from customers as c
join orders as o 
    on c.customer_id = o.customer_id;


-- 30. Compute a 3-month rolling sum of total revenue by month (using window functions).
select 
    date_format(order_date, '%Y-%m') as order_month,
    sum(total_amount) as monthly_total,
    sum(sum(total_amount)) over(order by date_format(order_date, '%Y-%m') 
        rows between 2 preceding and current row) as rolling_3_month_total
from orders
group by order_month;


-- 31. Use NTILE(4) to assign products into quartiles by price; show quartile number.
select 
    product_name,
    price, 
    ntile(4) over(order by price) as price_quartile
from products;


-- 32. Return category and the product with the highest profit margin (price - cost) per category.
with cte as (
    select 
        category,
        product_name, 
        (price - cost) as profit_margin, 
        dense_rank() over(partition by category order by price - cost desc) as rnk
    from products
)
select * 
from cte
where rnk = 1;


-- 33. Using CASE WHEN, classify orders as ‘Low’, ‘Medium’, or ‘High’ value based on total_amount.
select 
    total_amount,
    case
        when total_amount < 500 then 'Low'
        when total_amount < 1000 then 'Medium'
        else 'High'
    end as order_value_category
from orders;


-- 34. Use COALESCE (or IFNULL) to show each customer’s last_order_date or their signup_date if null.
select 
    c.name,
    coalesce(max(o.order_date), c.signup_date) as last_activity_date
from customers as c
left join orders as o 
    on c.customer_id = o.customer_id
group by c.name, c.signup_date;


-- 35. Write a CREATE VIEW statement for vw_customer_lifetime showing customer_id, name, signup_date, total_spend, and order_count.
create view vw_customer_lifetime as
select 
    c.customer_id, 
    c.name, 
    c.signup_date, 
    sum(o.total_amount) as total_spend, 
    count(o.order_id) as order_count
from customers as c
join orders as o 
    on c.customer_id = o.customer_id
group by c.customer_id, c.name, c.signup_date;

select * 
from vw_customer_lifetime
order by name;


-- 36. Write a CREATE INDEX statement to speed up queries filtering by order_date in the orders table.
create index idx_orders_order_date on orders(order_date);

explain select *
from orders
where order_date between '2025-01-01' and '2025-03-31';


-- 37. Show how to use EXPLAIN to view the execution plan of a query that finds top customers.
create index idx_order_customer_id on orders(customer_id);

explain
select 
    c.customer_id, 
    c.name, 
    sum(total_amount) as total_spent
from customers as c
join orders as o 
    on c.customer_id = o.customer_id
group by c.customer_id, c.name 
order by total_spent desc
limit 5;


-- 38. For each category, list the top 3 products by total quantity sold (use window functions or subqueries).
with cte as (
    select 
        p.category, 
        p.product_name, 
        o.quantity,
        dense_rank() over(partition by p.category order by o.quantity desc) as rnk
    from order_items as o
    join products as p 
        on o.product_id = p.product_id
)
select * 
from cte
where rnk <= 3;


-- 39. Compute Month-over-Month (MoM) revenue growth for the last 12 months.
with cte as (
    select 
        date_format(order_date, '%Y-%m') as sales_month, 
        sum(total_amount) as current_month_revenue
    from orders
    where order_date >= date_sub(curdate(), interval 12 month)
    group by sales_month
),
previous as (
    select 
        *, 
        lag(current_month_revenue) over(order by sales_month) as previous_month_revenue
    from cte
)
select 
    sales_month, 
    current_month_revenue, 
    previous_month_revenue, 
    concat(round(((current_month_revenue - previous_month_revenue) / previous_month_revenue) * 100, 2), '%') as mom_growth
from previous;


-- 40. Build a cohort analysis: for customers who signed up in Jan 2024, show how many placed orders in month 0, 1, and 2 after signup.
with cte as (
    select 
        c.customer_id, 
        date_format(c.signup_date, '%Y-%m') as cohort_month,  
        timestampdiff(month, c.signup_date, o.order_date) as months_since_signup
    from customers as c
    join orders as o 
        on c.customer_id = o.customer_id
)
select 
    cohort_month, 
    months_since_signup, 
    count(distinct customer_id) as customers_active
from cte
where cohort_month = '2024-01' 
  and months_since_signup in (0, 1, 2)
group by cohort_month, months_since_signup
order by months_since_signup;


-- 41. Using CTEs + window functions, find customers who make up 80% of total revenue (Pareto 80/20 rule).
with customer_revenue as (
    select 
        c.customer_id, 
        c.name, 
        coalesce(sum(o.total_amount), 0) as revenue
    from customers as c
    left join orders as o 
        on c.customer_id = o.customer_id
    group by c.customer_id, c.name
),
total as (
    select sum(revenue) as total_revenue from customer_revenue
),
ranked as (
    select 
        cr.*, 
        sum(cr.revenue) over(order by cr.revenue desc) as cumulative_revenue
    from customer_revenue as cr
)
select 
    r.customer_id, 
    r.name, 
    r.revenue, 
    round(r.cumulative_revenue / (select total_revenue from total), 4) as cumulative_pct
from ranked as r
where (r.cumulative_revenue / (select total_revenue from total)) <= 0.80;


-- 42. For each month, list the top customer(s) by revenue — include ties if any.
with month_customer as (
    select 
        date_format(o.order_date, '%Y-%m') as sales_month,
        c.customer_id, 
        c.name,
        sum(o.total_amount) as revenue
    from orders as o
    join customers as c 
        on o.customer_id = c.customer_id
    group by sales_month, c.customer_id, c.name
),
ranked as (
    select 
        mc.*, 
        dense_rank() over(partition by mc.sales_month order by mc.revenue desc) as rnk
    from month_customer as mc
)
select 
    sales_month, 
    customer_id, 
    name, 
    revenue
from ranked
where rnk = 1
order by sales_month;


-- 43. Compute Year-over-Year (YoY) revenue growth for each month comparing 2025 vs 2024.
with monthly_rev as (
    select 
        year(o.order_date) as yr,
        month(o.order_date) as mon,
        date_format(o.order_date, '%Y-%m') as ym,
        sum(o.total_amount) as revenue
    from orders as o
    where year(o.order_date) in (2024, 2025)
    group by yr, mon, ym
),
rev_2024 as (
    select mon, revenue as rev_2024 from monthly_rev where yr = 2024
),
rev_2025 as (
    select mon, revenue as rev_2025 from monthly_rev where yr = 2025
)
select 
    date_format(str_to_date(concat('2025-', lpad(r5.mon, 2, '0'), '-01'), '%Y-%m-%d'), '%Y-%m') as month,
    coalesce(r5.rev_2025, 0) as revenue_2025,
    coalesce(r4.rev_2024, 0) as revenue_2024,
    case
        when coalesce(r4.rev_2024, 0) = 0 then null
        else round(((coalesce(r5.rev_2025, 0) - r4.rev_2024) / r4.rev_2024) * 100, 2)
    end as yoy_pct_change
from rev_2025 r5
left join rev_2024 r4 
    on r5.mon = r4.mon
order by month;


-- 44. Use UNION to merge orders (as ‘Order’ type) and customers (as ‘Signup’ type) and show the combined activity timeline per customer.
select 
    o.customer_id,
    o.order_date as activity_date,
    'Order' as activity_type,
    o.total_amount as amount
from orders as o
union all
select 
    c.customer_id,
    c.signup_date as activity_date,
    'Signup' as activity_type,
    null as amount
from customers as c
order by customer_id, activity_date;


-- 45. Write two queries — one using EXISTS, one using IN — to find customers who purchased product_id = 'P100'.

-- Using IN
select distinct 
    c.customer_id, 
    c.name
from customers as c
where c.customer_id in (
    select o.customer_id
    from orders as o
    join order_items as oi 
        on o.order_id = oi.order_id
    where oi.product_id = 'P100'
);

-- Using EXISTS
select distinct 
    c.customer_id, 
    c.name
from customers as c
where exists (
    select 1
    from orders as o
    join order_items as oi 
        on o.order_id = oi.order_id
    where oi.product_id = 'P100'
      and o.customer_id = c.customer_id
);


-- 46. Create a query that flags churned customers (those whose last_order_date is >180 days before today).
select 
    c.customer_id, 
    c.name, 
    max(o.order_date) as last_order_date,
    case
        when max(o.order_date) is null and c.signup_date < curdate() - interval 180 day then 'Churned'
        when max(o.order_date) < curdate() - interval 180 day then 'Churned'
        else 'Active'
    end as churn_flag
from customers as c
left join orders as o 
    on c.customer_id = o.customer_id
group by c.customer_id, c.name, c.signup_date
order by churn_flag desc, last_order_date;


-- 47. Calculate retention rate per signup cohort: for each signup month, show % of customers with at least one order 3 months later.
with cohorts as (
    select 
        c.customer_id,
        date_format(c.signup_date, '%Y-%m') as cohort_month,
        c.signup_date
    from customers as c
),
orders_month3 as (
    select distinct 
        co.cohort_month,
        co.customer_id
    from cohorts as co
    join orders as o 
        on co.customer_id = o.customer_id
        and timestampdiff(month, co.signup_date, o.order_date) = 3
),
cohort_sizes as (
    select 
        cohort_month,
        count(customer_id) as cohort_size
    from cohorts
    group by cohort_month
),
cohort_retained as (
    select 
        cohort_month,
        count(customer_id) as retained_count
    from orders_month3
    group by cohort_month
)
select 
    cs.cohort_month,
    cs.cohort_size,
    coalesce(cr.retained_count, 0) as retained_count,
    round(coalesce(cr.retained_count, 0) / cs.cohort_size * 100, 2) as retention_pct_month_3
from cohort_sizes as cs
left join cohort_retained as cr 
    on cs.cohort_month = cr.cohort_month
order by cs.cohort_month;


-- 48. Using order_items and products, compute gross margin per order: SUM((price - cost) * quantity).
select 
    oi.order_id,
    sum((p.price - p.cost) * oi.quantity) as gross_margin
from order_items as oi
join products as p 
    on oi.product_id = p.product_id
group by oi.order_id
order by gross_margin desc;


-- 49. Write a single SQL script (with CTEs) that returns for a given date range: total revenue, revenue by payment_method, unique customers, repeat-customer rate, and top 5 products by revenue.
with orders_range as (
    select * 
    from orders as o
    where o.order_date between '2025-01-01' and '2025-10-01'
),
total_metrics as (
    select 
        sum(o.total_amount) as total_revenue,
        count(distinct o.customer_id) as unique_customers
    from orders_range as o
),
by_payment as (
    select 
        o.payment_method,
        sum(o.total_amount) as revenue_by_payment
    from orders_range as o
    group by o.payment_method
),
customer_orders as (
    select 
        o.customer_id,
        count(o.order_id) as orders_count,
        sum(o.total_amount) as customer_revenue
    from orders_range as o
    group by o.customer_id
),
repeat_rate as (
    select 
        round(sum(case when orders_count > 1 then 1 else 0 end) / count(*) * 100, 2) as repeat_customer_rate
    from customer_orders
),
top_products as (
    select 
        p.product_id,
        p.product_name,
        sum(oi.quantity * p.price) as product_revenue
    from order_items as oi
    join products as p 
        on oi.product_id = p.product_id
    join orders_range as o 
        on oi.order_id = o.order_id
    group by p.product_id, p.product_name
    order by product_revenue desc
    limit 5
)
-- Results: total metrics
select * from total_metrics;

-- Results: revenue by payment method
select * from by_payment order by revenue_by_payment desc;

-- Results: unique customers and repeat rate
select 
    unique_customers,
    (select repeat_customer_rate from repeat_rate) as repeat_customer_rate
from total_metrics
limit 1;

-- Results: top 5 products by revenue
select * from top_products;


-- 50. Describe 5 SQL optimization strategies for a slow join query on orders, order_items, and products, and write the SQL for at least two (e.g., CREATE INDEX, rewrite with CTE).

/*
Optimization Strategies:
1. Add appropriate indexes on join and filter columns.
2. Avoid SELECT *; choose only necessary columns.
3. Pre-aggregate large tables before joining.
4. Keep table statistics updated; analyze query plan.
5. Use covering or composite indexes where beneficial.
*/

-- Example 1: Create Indexes
create index idx_orders_order_date on orders(order_date);
create index idx_orders_customer_id on orders(customer_id);
create index idx_order_items_order_id on order_items(order_id);
create index idx_order_items_product_id on order_items(product_id);

-- Example 2: Pre-aggregate order_items before joining
with oi_agg as (
    select 
        oi.order_id,
        oi.product_id,
        sum(oi.quantity) as total_qty
    from order_items as oi
    group by oi.order_id, oi.product_id
)
select 
    o.order_id,
    o.order_date,
    p.product_id,
    p.product_name,
    oi_agg.total_qty,
    oi_agg.total_qty * p.price as line_revenue
from oi_agg
join products as p 
    on oi_agg.product_id = p.product_id
join orders as o 
    on oi_agg.order_id = o.order_id
where o.order_date between '2025-01-01' and '2025-06-30';
