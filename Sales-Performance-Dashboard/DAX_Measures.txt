## ⚙️ Essential DAX Measures – Retail Performance Dashboard

This Power BI dashboard uses a set of carefully designed **DAX measures** to calculate KPIs, analyze performance, and drive actionable insights.  
Below are all **important DAX formulas** implemented in this project, categorized for clarity and business relevance.

---

### 🧾 1. Core Performance KPIs

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Total Sales** | `Total Sales = SUM(Data[Sales])` | Calculates overall revenue from all transactions. |
| **Total Profit** | `Total Profit = SUM(Data[Profit])` | Measures total profit generated across all orders. |
| **Total Quantity** | `Total Quantity = SUM(Data[Quantity])` | Counts the total number of units sold. |
| **Total Discount** | `Total Discount = SUM(Data[DiscountAmount])` | Displays the total discount amount offered. |

---

### 💰 2. Profitability Metrics

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Profit Margin %** | `Profit Margin % = DIVIDE([Total Profit], [Total Sales])` | Calculates the profit margin percentage. |
| **Avg Profit Margin (by Segment)** | `Avg Profit Margin = AVERAGEX(VALUES(Data[Segment]), [Profit Margin %])` | Finds the average margin per customer segment. |
| **Profit per Order** | `Profit per Order = DIVIDE([Total Profit], [Total Orders])` | Determines profitability per order. |

---

### 📈 3. Growth & Trend Analysis

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **YoY Sales Growth %** | `YoY Sales Growth % = DIVIDE([Total Sales] - CALCULATE([Total Sales], DATEADD(Data[OrderDate], -1, YEAR)), CALCULATE([Total Sales], DATEADD(Data[OrderDate], -1, YEAR)))` | Calculates year-over-year sales growth. |
| **Sales YoY Difference** | `Sales YoY Diff = [Total Sales] - CALCULATE([Total Sales], DATEADD(Data[OrderDate], -1, YEAR))` | Shows numeric difference in sales compared to last year. |
| **Monthly Sales Trend** | *Used in line chart with Total Sales and Date hierarchy* | Visualizes monthly growth trends. |

---

### 👥 4. Customer & Order Analysis

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Total Customers** | `Total Customers = DISTINCTCOUNT(Data[CustomerID])` | Counts unique customers. |
| **Sales per Customer** | `Sales per Customer = DIVIDE([Total Sales], [Total Customers])` | Calculates average revenue per customer. |
| **Total Orders** | `Total Orders = DISTINCTCOUNT(Data[Order_ID])` | Counts the total number of orders placed. |

---

### 🚚 5. Shipping & Delivery Insights

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Avg Shipping Duration** | `Avg Shipping Duration = AVERAGE(Data[Shipping_Duration])` | Calculates average delivery time. |
| **Orders by Ship Mode** | *Derived from Total Orders measure using Ship Mode dimension* | Used to visualize shipping mode performance. |

---

### 🎯 6. Discount & Pricing Analysis

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Average Discount %** | `Avg Discount % = AVERAGE(Data[Discount])` | Measures average discount across transactions. |
| **Discount Impact on Profit** | *Analyzed using Discount vs Profit combo chart* | Identifies how discounts affect profitability. |

---

### 📊 7. DAX Measure Usage by Dashboard Page

| 📄 Dashboard Page | 🔑 Key DAX Measures Used |
|-------------------|--------------------------|
| **Executive Overview** | Total Sales, Total Profit, Profit Margin %, YoY Sales Growth % |
| **Category & Product Insights** | Total Sales, Total Profit, Avg Profit Margin, Total Discount, Avg Discount % |
| **Customer & Shipping Insights** | Total Customers, Sales per Customer, Avg Shipping Duration, Profit per Order |
| **Insights & Recommendations (Optional)** | All summary DAX measures for storytelling and insights |

---

### 🧠 Key Takeaway

Each DAX formula is designed to make the dashboard **dynamic, analytical, and business-driven**.  
These measures allow users to explore **sales trends**, **category performance**, **customer profitability**, and **shipping efficiency**, delivering actionable insights across multiple business dimensions.

---

### 🧱 Tools & Technologies Used
- **Power BI Desktop** – Dashboard design & interactivity  
- **Excel** – Data cleaning and preprocessing  
- **DAX (Data Analysis Expressions)** – KPI calculations and analysis  
- **Power Query** – Data transformation  

---

> 💡 *This DAX collection represents a complete analytical foundation for the Retail Performance Dashboard — a powerful example of end-to-end data storytelling for business decision-making.*
