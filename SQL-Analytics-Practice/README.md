# 🧠 SQL Analytics Practice for Data Analysts

A hands-on collection of SQL queries covering both **core** and **business-oriented analytics** — perfect for Data Analyst interviews and real projects.

---

## 🧩 Database Schema

Below are the main tables used throughout the practice:

| Table | Description | Key Columns |
|-------|--------------|--------------|
| **customers** | Customer information | `customer_id`, `name`, `signup_date`, `country`, `last_order_date` |
| **orders** | Customer orders | `order_id`, `customer_id`, `order_date`, `payment_method`,`order_status`, `total_amount` |
| **order_items** | Line items for each order | `order_item_id`, `order_id`, `product_id`, `quantity` |
| **products** | Product catalog | `product_id`, `product_name`, `category`, `cost`, `price` |

---

## 🎯 Tier 1 – Must-Know Core SQL  

🔹 DISTINCT, WHERE, BETWEEN, IN, LIKE  
🔹 ORDER BY & LIMIT  
🔹 COUNT, SUM, AVG, MAX, MIN  
🔹 GROUP BY & HAVING  
🔹 INNER / LEFT / RIGHT / FULL JOINS  
🔹 Self-Join  
🔹 Subqueries (e.g., above-avg salary)  
🔹 EXISTS vs IN  
🔹 UNION vs UNION ALL  
🔹 Nth Highest Salary  
🔹 ROW_NUMBER / RANK / DENSE_RANK  
🔹 CTEs  
🔹 Date / Time Functions  
🔹 Business Metrics – Revenue, Top Customer, Popular Product  

📄 File → `queries/Tier1_Core_SQL_Practice.sql`

---

## 🚀 Tier 2 – Advanced & Business-Oriented SQL  

🔹 LAG & LEAD  
🔹 Running Totals (SUM() OVER)  
🔹 NTILE (Quartiles / Percentiles)  
🔹 CASE WHEN  
🔹 COALESCE / IFNULL  
🔹 Views  
🔹 Indexing Basics  
🔹 Query Optimization (EXPLAIN)  
🔹 Top N per Group  
🔹 Customer Spending Analysis  
🔹 Monthly / Yearly KPIs  
🔹 Retention / Cohort Queries  
🔹 YoY Growth  
🔹 Region / Category Sales  
🔹 Final Case: Joins + CTE + Window Function  

📄 File → `queries/Tier2_Advanced_SQL_Practice.sql`

---

## 🧾 Final Case Study

A single complex query combining:
- **CTEs**
- **Window Functions**
- **Aggregations**
- **Business KPIs (Revenue, Retention, Growth)**  

📄 File → `queries/Final_Case_Study.sql`


---

📁 Repository Structure

📘 README.md
💡 queries/
│   ├── Tier1_Core_SQL_Practice.sql      # 25 beginner–intermediate queries
│   ├── Tier2_Advanced_SQL_Practice.sql  # 25 advanced & business queries (26–50)
│   └── Final_Case_Study.sql             # End-to-end business analysis project

---
## 🧑‍💻 Author
**Rimsha Bhatti**  
📍 Data Analyst | SQL | Power BI | Excel | Python  
💼 [GitHub Portfolio](https://github.com/) | 🌐 [LinkedIn Profile](https://linkedin.com/)

---

⭐ **If you find this useful, don’t forget to give it a star!**
