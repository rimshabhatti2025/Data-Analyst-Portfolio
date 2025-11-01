-- 🎯 Tier 1 – Must-Know Core SQL (1–25)

-- 1. Select the distinct category values from the products table.

select 
    distinct category
from products;


-- 2. Return all orders where order_status = 'Cancelled' and payment_method is not null.

select *
from orders
where order_status = 'Cancelled'
  and payment_method is not null;


-- 3. Find orders placed between '2025-01-01' and '2025-06-30'.

select *
from orders
where order_date between '2025-01-01' and '2025-06-30';


-- 4. List the top 10 orders by total_amount in descending order.

select *
from orders
order by total_amount desc
limit 10;


-- 5. Count the total number of customers in the customers table.

select count(customer_id)
from customers;


-- 6. Compute total revenue (SUM of total_amount) and average order value (AVG) across all orders.

select 
    sum(total_amount) as total_revenue, 
    avg(total_amount) as avg_order_value
from orders;


-- 7. Show the maximum and minimum price in the products table.

select 
    max(price) as max_price, 
    min(price) as min_price
from products;


-- 8. For each category, show the number of products and the average price.

select 
    category, 
    count(*) as total_products, 
    avg(price) as avg_price
from products
group by category;


-- 9. From the grouped result above, filter to categories having average price greater than 100 (use HAVING).

select 
    category, 
    count(*) as total_products, 
    avg(price) as avg_price
from products
group by category
having avg(price) > 100
order by avg(price) desc;


-- 10. Return all orders with customer names using an INNER JOIN between orders and customers.

select *
from orders as o
inner join customers as c
    on o.customer_id = c.customer_id;


-- 11. Show all customers and their last order amount, including those with no orders (use LEFT JOIN).

select 
    c.name, 
    o.total_amount
from customers as c
left join orders as o
    on o.customer_id = c.customer_id;


-- 12. List order items with product names: join order_items → products, showing quantity and price.

select 
    p.product_name, 
    p.category, 
    o.quantity, 
    p.price
from order_items as o
join products as p
    on o.product_id = p.product_id;


-- 13. Using a self-join on customers, find pairs of customers living in the same country (exclude same customer pairing).

select 
    a.customer_id, a.name, a.country, 
    b.customer_id, b.name, b.country
from customers as a
join customers as b
    on a.country = b.country
    and a.customer_id <> b.customer_id;


-- 14. Find orders where total_amount is above the average order total_amount (use a subquery).

select *
from orders
where total_amount > (select avg(total_amount) from orders);


-- 15. Return customers who have placed at least one order (use EXISTS).

select 
    name
from customers as c
where exists (
    select 1
    from orders as o
    where c.customer_id = o.customer_id
);


-- 16. Return customers whose customer_id appears in the list of IDs having orders (use IN) and rewrite using EXISTS.

-- Using IN
select 
    name
from customers
where customer_id in (select customer_id from orders);

-- Using EXISTS
select 
    name
from customers as c
where exists (
    select 1
    from orders as o
    where c.customer_id = o.customer_id
);


-- 17. Show a UNION of two queries: all product_names from category 'Electronics' and category 'Accessories' (remove duplicates).

select 
    product_name, 
    category
from products
where category = 'Electronics'
union
select 
    product_name, 
    category
from products
where category = 'Accessories';


-- 18. Show the same as #17 but with duplicates preserved (use UNION ALL).

select 
    product_name, 
    category
from products
where category = 'Electronics'
union all
select 
    product_name, 
    category
from products
where category = 'Accessories';


-- 19. Find the 2nd highest priced product in the products table.

select *
from products
order by price desc
limit 1 offset 1;


-- 20. Use ROW_NUMBER() to number each order per customer by order_date (most recent = 1) and return each customer’s latest order.

with cte as (
    select 
        customer_id, 
        order_date, 
        row_number() over(partition by customer_id order by order_date desc) as row_num
    from orders
)
select *
from cte
where row_num = 1;


-- 21. Create a CTE to return orders from the last 90 days, then select from it.

with recent_orders as (
    select *
    from orders
    where order_date >= curdate() - interval 90 day
)
select *
from recent_orders
order by order_date desc;


-- 22. Extract year and month from order_date and show total revenue per month.

select 
    year(order_date) as order_year, 
    month(order_date) as order_month, 
    monthname(order_date) as month_name, 
    sum(total_amount) as total_revenue
from orders
group by 
    year(order_date), 
    month(order_date), 
    monthname(order_date)
order by order_year, order_month;


-- 23. Use LIKE to find all products whose product_name contains 'Pro'.

select 
    product_name
from products
where product_name like '%pro%';


-- 24. Return the top 5 customers by total spending (SUM of total_amount) showing customer_id, name, and total spend.

select 
    c.customer_id, 
    c.name, 
    sum(o.total_amount) as total_spent
from customers as c
join orders as o
    on c.customer_id = o.customer_id
group by 
    c.customer_id, 
    c.name
order by total_spent desc
limit 5;


-- 25. Write an UPDATE statement to set order_status = 'Completed' for orders where total_amount > 1000 and order_status = 'Pending'.

select *
from orders 
where total_amount > 1000 and order_status = 'Pending';

set sql_safe_updates = 0;

update orders
set order_status = 'Completed'
where total_amount > 1000 and order_status = 'Pending';
