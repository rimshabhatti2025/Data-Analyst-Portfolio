# 🛒 Retail Sales Performance Dashboard – Power BI | Excel | Data Analytics Project

---

## 🧭 1. Title
**Retail Sales Performance Dashboard – Power BI | Excel | Data Analytics Project**

---

## 📘 2. Executive Summary
This **interactive Power BI dashboard** provides a complete overview of **retail sales performance**, covering sales, profit, discount, and customer trends across multiple regions and categories.

The project analyzes **regional sales distribution, category profitability, customer segments, and shipping modes**, enabling management to make informed decisions on pricing, discount strategies, and customer targeting.

Developed using **Excel pivot tables** and **Power BI visuals**, it transforms raw transactional data into **actionable insights** for business growth and performance optimization.

---

## 💡 3. Business Problem
The company needed to understand key drivers behind **sales performance and profitability**.  
Key business questions included:  
- Which **regions and product categories** generate the most sales and profit?  
- How do **discounts and shipping modes** affect profitability?  
- Who are the **top customers and products** contributing to overall revenue?  
- What are the **monthly and yearly sales trends**?

This dashboard provides the answers with **clear visuals and DAX-powered KPIs**, guiding better strategic and operational decisions.

---

## ⚙️ 4. Methodology

**Data Source:** Superstore Retail Dataset (Orders, Customers, Shipping, and Sales details)  
**Tools Used:** Microsoft **Excel** + **Power BI**  

**Process Flow:**  
1️⃣ Data cleaning and validation in Excel  
2️⃣ Creation of pivot tables to summarize sales and profit metrics  
3️⃣ Importing and modeling the dataset in Power BI  
4️⃣ Writing **DAX measures** for KPIs and trend analysis  
5️⃣ Designing a **multi-page Power BI dashboard** with interactive visuals and filters  

---

## 🧮 5. Skills Applied

### 🔹 Tools & Techniques
- Microsoft **Excel** – Data preparation, cleaning, pivot tables  
- **Power BI Desktop** – Data modeling, relationships, dashboards  
- **DAX (Data Analysis Expressions)** – KPI calculations and metrics  
- **Power Query** – Data transformation  

### 🔹 Analytical Concepts
- Regional and Category Sales Analysis  
- Profitability & Discount Impact Study  
- Customer and Shipping Performance Analysis  
- Time Series Analysis (Monthly & Yearly Sales Trend)  
- YoY Growth and Profit Margin Analysis  

---

## 📊 6. Results & Key Insights

### 🧭 Region-Wise Performance
| Region | Sales | Profit |
|--------|--------|--------|
| Central | $501,239.89 | $39,706.36 |
| East | $678,781.24 | $91,522.78 |
| South | $391,721.91 | $46,749.43 |
| West | $725,457.82 | $108,418.45 |
| **Grand Total** | **$2,297,200.86** | **$286,397.02** |

➡️ *West Region leads in both sales and profit.*

---

### 🛒 Category-Wise Performance
| Category | Sales | Profit | Profit Impact % |
|-----------|--------|--------|----------------|
| Furniture | $741,999.80 | $18,451.27 | 15% |
| Office Supplies | $719,047.03 | $122,490.80 | 160% |
| Technology | $836,154.03 | $145,454.95 | 119% |

➡️ *Technology category drives highest profitability.*

---

### 📦 Top 10 Products by Profit
| Product | Sales | Profit |
|----------|--------|--------|
| Canon imageCLASS 2200 Advanced Copier | $61,599.82 | $25,199.93 |
| Cisco TelePresence System EX90 | $22,638.48 | -$1,811.08 |
| GBC DocuBind P400 Electric Binding | $17,965.07 | -$1,878.17 |
| Hewlett Packard LaserJet 3310 | $18,839.69 | $6,983.88 |
| HP Designjet T520 Inkjet Printer | $18,374.90 | $4,094.98 |

➡️ *Canon Copier is the most profitable product.*

---

### 📈 Monthly Sales Trend
| Month | Total Sales |
|--------|--------------|
| Jan | $94,924.84 |
| Sep | $307,649.95 |
| Nov | $352,461.07 |
| Dec | $325,293.50 |

➡️ *Sales peak in November and December.*

---

### 👥 Customer Insights
| Customer | Sales | Profit |
|-----------|--------|--------|
| Tamara Chand | $19,052.22 | $8,981.32 |
| Raymond Buch | $15,117.34 | $6,976.10 |
| Adrian Barton | $14,473.57 | $5,444.81 |

➡️ *High-value repeat customers drive consistent profits.*

---

### 🚚 Shipping Mode Analysis
| Ship Mode | Orders | Profit |
|------------|---------|---------|
| Standard Class | 5,968 | $164,088.79 |
| Second Class | 1,945 | $57,446.64 |
| First Class | 1,538 | $48,969.84 |
| Same Day | 543 | $15,891.76 |

➡️ *Standard Class dominates order volume and profit.*

---

### 🌍 Profit by State (Regional Detail)
- West: California, Washington → highest profit states  
- East: New York dominates; Pennsylvania & Ohio show negative profit  
- South: Strong profits in Virginia & Georgia  
- Central: Minor losses in Illinois and Texas  

---

### 📅 Yearly Sales Performance
| Year | % of Total Sales | YoY Growth |
|------|------------------|------------|
| 2014 | 21.08% | — |
| 2015 | 20.48% | -2.83% |
| 2016 | 26.52% | +29.47% |
| 2017 | 31.92% | +20.36% |

➡️ *Strong YoY growth from 2016 onward.*

---

## 🧮 7. Essential DAX Measures
| # | Measure Name | Formula | Purpose |
|---|---------------|----------|----------|
| 1️⃣ | Total Sales | `SUM(Data[Sales])` | KPI & trend visuals |
| 2️⃣ | Total Profit | `SUM(Data[Profit])` | Profit tracking |
| 3️⃣ | Total Quantity | `SUM(Data[Quantity])` | Unit-based analysis |
| 4️⃣ | Profit Margin % | `DIVIDE([Total Profit], [Total Sales])` | Profitability ratio |
| 5️⃣ | Total Discount | `SUM(Data[DiscountAmount])` | Discount impact |
| 6️⃣ | Avg Profit Margin by Segment | `AVERAGEX(VALUES(Data[Segment]), [Profit Margin %])` | Segment-level margin |
| 7️⃣ | YoY Sales Growth % | `DIVIDE([Total Sales] - CALCULATE([Total Sales], DATEADD(Data[OrderDate], -1, YEAR)), CALCULATE([Total Sales], DATEADD(Data[OrderDate], -1, YEAR)))` | Year-over-year growth |
| 8️⃣ | Total Customers | `DISTINCTCOUNT(Data[CustomerID])` | Customer KPI |
| 9️⃣ | Sales per Customer | `DIVIDE([Total Sales], [Total Customers])` | Customer-level metric |
| 🔟 | Average Discount % | `AVERAGE(Data[Discount])` | Discount analysis |

**Optional Analytical DAX**  
- `Total Orders = DISTINCTCOUNT(Data[Order_ID])`  
- `Profit per Order = DIVIDE([Total Profit], [Total Orders])`  
- `Avg Shipping Duration = AVERAGE(Data[Shipping_Duration])`  
- `Sales YoY Diff = [Total Sales] - CALCULATE([Total Sales], DATEADD(Data[OrderDate], -1, YEAR))`  

---

## 💡 8. Strategic Insights
✅ **Profitability Leaders:** Technology category & West region drive most of the profit.  
✅ **Discount Impact:** Furniture has low profit margins due to higher discounts.  
✅ **Top Customers:** Retaining top 10 high-value customers ensures consistent revenue.  
✅ **Shipping Optimization:** Standard & Second Class yield the best cost-profit balance.  
✅ **Seasonal Peaks:** November–December are peak sales months — ideal for promotions.  
✅ **Growth:** 2016 & 2017 recorded strongest YoY growth — expansion opportunities.  

---

## 🛠️ 9. Recommendations
🚀 Reduce heavy discounts on Furniture and low-performing products.  
📦 Optimize shipping by promoting Standard & Second Class modes.  
👥 Enhance loyalty programs for top customers to retain consistent profits.  
🌍 Focus marketing on West & East regions to scale profitability.  
📊 Monitor YoY trends for seasonal planning and inventory management.  

---

## 🏁 10. Project Outcome
This project translates raw sales data into **clear visual stories and actionable insights**, providing a **360° view of retail performance** for better strategic and operational decisions.  

---

## 🧩 Repository Tags
`#PowerBI` `#Excel` `#RetailAnalytics` `#SalesDashboard` `#DataAnalytics` `#BusinessIntelligence` `#SuperstoreDataset`
