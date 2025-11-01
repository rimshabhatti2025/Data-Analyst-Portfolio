## ⚙️ Essential DAX Measures – Financial Performance Dashboard

This Power BI dashboard uses a set of carefully designed **DAX measures** to calculate KPIs, analyze financial metrics, and generate business insights.  
Below are all **key DAX formulas** implemented in this project, categorized for clarity and relevance.

---

### 💰 1. Core Financial KPIs

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Total Revenue** | `Total Revenue = SUM(Data[Revenue])` | Calculates total income generated from all transactions. |
| **Total Expense** | `Total Expense = SUM(Data[Expense])` | Sums up all business costs or expenditures. |
| **Total Profit** | `Total Profit = [Total Revenue] - [Total Expense]` | Derives profit by subtracting expenses from revenue. |
| **Total Transactions** | `Total Transactions = DISTINCTCOUNT(Data[TransactionID])` | Counts unique financial transactions. |

---

### 📈 2. Profitability Metrics

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Profit Margin %** | `Profit Margin % = DIVIDE([Total Profit], [Total Revenue])` | Shows how much profit is earned per rupee of revenue. |
| **Average Profit per Transaction** | `Avg Profit per Transaction = DIVIDE([Total Profit], [Total Transactions])` | Calculates average profit per transaction. |
| **Profit YoY Growth %** | `Profit YoY Growth % = DIVIDE([Total Profit] - CALCULATE([Total Profit], DATEADD(Data[Date], -1, YEAR)), CALCULATE([Total Profit], DATEADD(Data[Date], -1, YEAR)))` | Measures year-over-year growth in profit. |

---

### 📊 3. Revenue & Expense Trends

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **YoY Revenue Growth %** | `YoY Revenue Growth % = DIVIDE([Total Revenue] - CALCULATE([Total Revenue], DATEADD(Data[Date], -1, YEAR)), CALCULATE([Total Revenue], DATEADD(Data[Date], -1, YEAR)))` | Tracks yearly growth in revenue. |
| **Monthly Revenue** | `Monthly Revenue = CALCULATE([Total Revenue], DATESMTD(Data[Date]))` | Calculates revenue for the current month-to-date. |
| **Monthly Expense** | `Monthly Expense = CALCULATE([Total Expense], DATESMTD(Data[Date]))` | Computes total expenses for the month. |
| **Net Income Trend** | *Used in line chart with [Total Profit] over Date hierarchy* | Visualizes profit fluctuations over time. |

---

### 🧾 4. Category & Department Analysis

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Revenue by Category** | `Revenue by Category = CALCULATE([Total Revenue], VALUES(Data[Category]))` | Breaks down revenue by business category. |
| **Expense by Department** | `Expense by Department = CALCULATE([Total Expense], VALUES(Data[Department]))` | Summarizes total expense per department. |
| **Profit by Category** | `Profit by Category = CALCULATE([Total Profit], VALUES(Data[Category]))` | Displays profit distribution by category. |

---

### 📉 5. Cost & Efficiency Insights

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Expense Ratio %** | `Expense Ratio % = DIVIDE([Total Expense], [Total Revenue])` | Indicates percentage of revenue spent as expense. |
| **Operating Margin %** | `Operating Margin % = DIVIDE([Total Profit], [Total Revenue])` | Measures profitability before taxes and other adjustments. |
| **Cost per Transaction** | `Cost per Transaction = DIVIDE([Total Expense], [Total Transactions])` | Calculates average cost incurred per transaction. |

---

### 🔍 6. Advanced Analysis Metrics

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Revenue Contribution % by Category** | `Revenue % by Category = DIVIDE([Total Revenue], CALCULATE([Total Revenue], ALL(Data[Category])))` | Shows each category’s share in total revenue. |
| **Profit Contribution % by Department** | `Profit % by Department = DIVIDE([Total Profit], CALCULATE([Total Profit], ALL(Data[Department])))` | Displays contribution of each department to total profit. |
| **Top 3 Profit Sources (Dynamic)** | `Top 3 Profit Sources = TOPN(3, SUMMARIZE(Data, Data[Category], "Profit", [Total Profit]), [Total Profit], DESC)` | Identifies top-performing profit categories. |

---

### 🧩 7. DAX Measure Usage by Dashboard Page

| 📄 Dashboard Page | 🔑 Key DAX Measures Used |
|-------------------|--------------------------|
| **Page 1: Executive Overview** | Total Revenue, Total Expense, Total Profit, Profit Margin % |
| **Page 2: Revenue & Expense Trends** | YoY Revenue Growth %, Monthly Revenue, Monthly Expense |
| **Page 3: Departmental Insights** | Expense by Department, Profit by Category, Expense Ratio % |
| **Page 4: Profitability Breakdown** | Average Profit per Transaction, Operating Margin %, Profit YoY Growth % |
| **Page 5: Key Insights & Summary** | Revenue % by Category, Profit % by Department, Top 3 Profit Sources |

---

### 🧠 Key Takeaway

Each DAX formula is designed to make this **Financial Performance Dashboard** interactive, data-driven, and decision-oriented.  
These measures enable analysis of **revenue flow**, **cost structure**, **profitability**, and **departmental performance** — helping stakeholders understand the full financial picture.

---

### 🧱 Tools & Technologies Used

- **Power BI Desktop** – Dashboard design & interactivity  
- **Excel** – Data cleaning and preprocessing  
- **DAX (Data Analysis Expressions)** – KPI creation and calculations  
- **Power Query** – Data transformation  

---

> 💡 *This DAX collection provides a robust analytical foundation for the Financial Performance Dashboard — empowering better financial visibility and smarter business decisions.*
