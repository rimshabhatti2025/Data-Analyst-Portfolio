
-- ============================================================
-- 📊 FINANCIAL & PERFORMANCE ANALYSIS – SQL PROJECT
-- Database   : finance
-- Table      : sales_data
-- Author     : Rimsha Bhatti
-- Description: Exploratory & summary SQL analysis for 
--              sales, profit, and discount trends across 
--              countries, products, and segments.
-- ============================================================

use finance;

CREATE TABLE sales_data (
    Segment VARCHAR(50),
    Country VARCHAR(50),
    Product VARCHAR(50),
    Discount_Band VARCHAR(20),
    Units_Sold DECIMAL(10,2),
    Manufacturing_Price DECIMAL(10,2),
    Sale_Price DECIMAL(10,2),
    Gross_Sales DECIMAL(15,2),
    Discounts DECIMAL(15,2),
    Sales DECIMAL(15,2),
    COGS DECIMAL(15,2),
    Profit DECIMAL(15,2),
    Date VARCHAR(20),
    Month_Number TINYINT,
    Month_Name VARCHAR(15),
    Year YEAR
);

select * from sales_data;

ALTER TABLE sales_data
ADD COLUMN Real_Date DATE;

UPDATE sales_data
SET Real_Date = STR_TO_DATE(Date, '%c/%e/%Y');

set sql_safe_updates = 0;

SELECT Date, Real_Date FROM sales_data LIMIT 10;

ALTER TABLE sales_data DROP COLUMN Date;
ALTER TABLE sales_data CHANGE Real_Date Date DATE;

SELECT YEAR(Date) AS Year, MONTHNAME(Date) AS Month, SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY YEAR(Date), MONTHNAME(Date);

-- Now run these minimum important queries 👇 (no answers — just tasks)

-- #	SQL Question

-- ============================================================
-- 1	Count total records and unique countries.
-- ============================================================

select Country , count(*) as record_count
from sales_data
group by Country;

/*
    **Output***
    Country	count(*)
	Canada	140
	Germany	139
	France	139
	Mexico	137
	United States of America	140
*/
-- ============================================================
-- 2	List all distinct segments and products.
-- ============================================================

SELECT DISTINCT Segment, Product
FROM sales_data
ORDER BY Segment, Product;

/*
    **Output***
Channel Partners	 Amarilla 
Channel Partners	 Carretera 
Channel Partners	 Montana 
Channel Partners	 Paseo 
Channel Partners	 Velo 
Channel Partners	 VTT 
Enterprise	 Amarilla 
Enterprise	 Carretera 
Enterprise	 Montana 
Enterprise	 Paseo 
Enterprise	 Velo 
Enterprise	 VTT 
Government	 Amarilla 
Government	 Carretera 
Government	 Montana 
Government	 Paseo 
Government	 Velo 
Government	 VTT 
Midmarket	 Amarilla 
Midmarket	 Carretera 
Midmarket	 Montana 
Midmarket	 Paseo 
Midmarket	 Velo 
Midmarket	 VTT 
Small Business	 Amarilla 
Small Business	 Carretera 
Small Business	 Montana 
Small Business	 Paseo 
Small Business	 Velo 
Small Business	 VTT 
*/


-- ============================================================
-- 3	Show total Sales, COGS, and Profit.
-- ============================================================

select 
     sum(Sales) as total_Sales, 
     sum(COGS) as total_COGS, 
     sum(Profit) as total_Profit
from sales_data;

/*
    **Output***
    117870390.29	100976688.00	16893702.29
*/

-- ============================================================
-- 4	Find top 5 countries by total Profit.
-- ============================================================
select 
      Country , 
      sum(Profit) as total_Profit
from sales_data
group by Country
order by total_Profit desc
limit 5;

/*
    **Output***
    France	3781020.79
Germany	3680388.82
Canada	3529228.89
United States of America	2995540.68
Mexico	2907523.11
*/

-- ============================================================
-- 5	Find bottom 5 countries by Profit.
-- ============================================================

select Country , 
       sum(Profit) as total_Profit
from sales_data
group by Country
order by total_Profit asc
limit 5;

/*
    **Output***
    Mexico	2907523.11
United States of America	2995540.68
Canada	3529228.89
Germany	3680388.82
France	3781020.79
*/
-- ============================================================
-- 6	Show total Profit by Product.
-- ============================================================

select Product, 
	   sum(Profit) as total_profit
from sales_data
group by Product
order by total_profit desc;

/*
 **Output***
 Paseo 	4797437.96
 VTT 	3034608.02
 Amarilla 	2814104.07
 Velo 	2305992.47
 Montana 	2114754.88
 Carretera 	1826804.89
 */
-- ============================================================
-- 7	Calculate average Profit Margin by Segment.
-- ============================================================

select Segment, 
       concat(round(avg(Profit/Sales)*100,2),"%") as Avg_Profit_margin
from sales_data
group by Segment;

/*
 **Output***
Government	29.33%
Midmarket	27.67%
Channel Partners	73.02%
Enterprise	-3.22%
Small Business	9.67%

*/
-- ============================================================
-- 8	Compare yearly Sales and Profit (Year-wise summary).
-- ============================================================

select 
     year(Date) as yr, 
     sum(Sales) as total_Sales , 
     sum(Profit) as total_Profit
from sales_data
group by yr
order by yr; 

/*
 **Output***
2013	26415255.51	3878464.51
2014	91455134.78	13015237.78
*/

-- ============================================================
-- 9	Calculate total Discount % per Product.
-- ============================================================

select 
     Product, 
     concat(round(sum(Discounts)/sum(Gross_Sales)*100,2),"%") as total_Discount_Percent
from sales_data
group by Product;
/*
 **Output***
 Carretera 	7.51%
 Montana 	7.03%
 Paseo 	7.36%
 Velo 	7.95%
 VTT 	6.63%
 Amarilla 	6.80%
 */

-- ============================================================
-- 10	Show Month_Name and total Profit (sorted by Month_Number).
-- ============================================================

with cte as
(
select
     month_name, 
     Month_Number , 
     sum(Profit) as total_Profit
from sales_data
group by month_name, Month_Number
)
select 
      month_name, 
      total_Profit
from cte
order by Month_Number;

/*
 **Output***
 January 	814028.69
 February 	1148547.39
 March 	669866.87
 April 	929984.58
 May 	828640.06
 June 	1473753.82
 July 	923865.69
 August 	791066.42
 September 	1786735.27
 October 	3439781.02
 November 	1370102.50
 December 	2717329.98
 */
 -- ============================================================
-- 11	Find Product with highest total Sales.
-- ============================================================

select 
     Product, 
     sum(Sales) as total_sales
from sales_data
group by Product
order by total_sales desc
limit 1;

/*
 **Output***
 Paseo 	32420623.96
 */
-- ============================================================
-- 12	Find which Segment has highest average Profit per Units_Sold.
-- ============================================================

select 
     Segment, 
     round(sum(Profit)/sum(Units_Sold),2) as Avg_Profit_per_Unit
from sales_data
group by Segment
order by Avg_Profit_per_Unit desc;

/*
 **Output***
Small Business	27.05
Government	24.20
Channel Partners	8.17
Midmarket	3.83
Enterprise	-3.81
*/

-- ============================================================
-- 13	Identify total Sales contribution % by each Country.
-- ============================================================

select  
        Country ,
		concat(round(sum(Sales)/(select sum(sales) as overall_sales from sales_data)*100,2),"%") as total_Sales_Contribution
from sales_data
group by Country;

/*
 **Output***
Canada	21.11%
Germany	19.86%
France	20.36%
Mexico	17.43%
United States of America	21.24%
*/

-- ============================================================
-- 14	Get top 3 high-profit Products for each Segment.
-- ============================================================

with cte as
(
select Segment , Product , sum(Profit) as total_profit , dense_rank() over(Partition by Segment order by sum(Profit) desc) as rnk
from sales_data
group by Segment , Product
)
select Segment , Product , total_profit
from cte
where rnk <= 3
order by Segment , total_profit desc;

/*
 **Output***
Channel Partners	 Paseo 	331838.40
Channel Partners	 Amarilla 	230068.50
Channel Partners	 VTT 	219765.96
Enterprise	 Montana 	-31096.25
Enterprise	 Paseo 	-81740.00
Enterprise	 Velo 	-84762.50
Government	 Paseo 	3057290.71
Government	 Amarilla 	2208301.61
Government	 VTT 	1840653.71
Midmarket	 Paseo 	258739.35
Midmarket	 Carretera 	94105.00
Midmarket	 VTT 	91120.85
Small Business	 Paseo 	1231309.50
Small Business	 VTT 	982150.00
Small Business	 Montana 	743313.50
*/
-- ============================================================
-- 15	Find correlation-type insight (e.g., higher Discounts → lower Profit?). (Exploratory)
-- (Pearson correlation coefficient)
-- ============================================================

select
     round(
		(avg(Discounts * Profit) - avg(Discounts) * avg(Profit)) 
        / (stddev(Discounts) * stddev(Profit)) , 
        3) as correlation_value
from sales_data;
    

/*
 **Output***
0.383
*/

-- ============================================================
-- ✅ END OF SQL SCRIPT
-- ============================================================
