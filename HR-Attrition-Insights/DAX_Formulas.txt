# 💼 HR Analytics Dashboard – Employee Attrition & Insights

This Power BI project analyzes workforce data to uncover **employee attrition trends**, **demographics**, and **key HR insights**.  
It helps organizations identify **who is leaving, why they are leaving, and what actions** can improve retention.

---

## 📊 Project Overview

**Goal:**  
To build an interactive HR dashboard that visualizes attrition, performance, and engagement metrics for data-driven HR decisions.

**Dataset:**  
IBM HR Analytics Employee Attrition & Performance  
File: `WA_Fn-UseC_-HR-Employee-Attrition.csv` (~1,470 rows)

**Tools Used:**
- Microsoft **Excel** – Data cleaning and preprocessing  
- **Power BI Desktop** – Dashboard design and visualizations  
- **DAX (Data Analysis Expressions)** – KPI and metric calculations  
- **Power Query** – Data transformation

---

## ⚙️ Essential DAX Measures – HR Attrition & Employee Insights Dashboard

This Power BI dashboard uses a set of well-structured **DAX measures** to calculate HR KPIs, analyze workforce patterns, and uncover attrition insights.  
Below are all **important DAX formulas**, organized by their purpose and business logic.

---

### 👥 1. Core Employee KPIs

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Total Employees** | `Total Employees = COUNT(EmployeeData[EmployeeNumber])` | Counts total number of employees in the dataset. |
| **Employees Left** | `Employees Left = SUM(EmployeeData[Attrition(Number)])` | Calculates total employees who left the organization. |
| **Active Employees** | `Active Employees = [Total Employees] - [Employees Left]` | Determines currently employed workforce. |
| **Attrition Rate %** | `Attrition Rate % = DIVIDE([Employees Left], [Total Employees], 0)` | Calculates percentage of employees who left. |
| **Average Monthly Income** | `Avg Monthly Income = AVERAGE(EmployeeData[MonthlyIncome])` | Finds average monthly income across all employees. |

---

### 🧩 2. Workforce Demographics

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Employees by Age Group** | `Employees by Age Group = COUNTROWS(EmployeeData)` | Used with `Age_Group` to show workforce distribution. |
| **Employees by Gender** | `Employees by Gender = COUNT(EmployeeData[Gender])` | Counts total employees by gender. |
| **Employees by Department** | `Employees by Department = COUNT(EmployeeData[Department])` | Displays department-wise headcount. |
| **Average Age** | `Average Age = AVERAGE(EmployeeData[Age])` | Calculates mean employee age. |
| **Avg Years at Company** | `Avg Years at Company = AVERAGE(EmployeeData[YearsAtCompany])` | Shows average tenure. |

---

### ⚠️ 3. Attrition & Turnover Insights

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Attrition by Department %** | `Attrition by Department % = DIVIDE(SUM(EmployeeData[Attrition(Number)]), COUNT(EmployeeData[EmployeeNumber]))` | Shows department-specific attrition. |
| **Attrition by Age Group %** | `Attrition by Age Group % = DIVIDE(SUM(EmployeeData[Attrition(Number)]), COUNT(EmployeeData[EmployeeNumber]))` | Displays age group–wise turnover. |
| **Attrition by Gender %** | `Attrition by Gender % = DIVIDE(SUM(EmployeeData[Attrition(Number)]), COUNT(EmployeeData[EmployeeNumber]))` | Measures attrition by gender. |
| **Attrition by Salary Range %** | `Attrition by Salary Range % = DIVIDE(SUM(EmployeeData[Attrition(Number)]), COUNT(EmployeeData[EmployeeNumber]))` | Shows attrition distribution across salary bands. |
| **Attrition by Job Level %** | `Attrition by Job Level % = DIVIDE(SUM(EmployeeData[Attrition(Number)]), COUNT(EmployeeData[EmployeeNumber]))` | Reveals which job levels have higher exits. |
| **Attrition by Overtime %** | `Attrition by Overtime % = DIVIDE(SUMX(FILTER(EmployeeData, EmployeeData[OverTime]="Yes"), EmployeeData[Attrition(Number)]), COUNTROWS(EmployeeData))` | Compares attrition between overtime and non-overtime employees. |

---

### 💵 4. Compensation & Performance Metrics

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Avg Income by Department** | `Avg Income by Department = AVERAGEX(VALUES(EmployeeData[Department]), [Avg Monthly Income])` | Calculates average income per department. |
| **Avg Job Satisfaction** | `Avg Job Satisfaction = AVERAGE(EmployeeData[JobSatisfaction])` | Measures job satisfaction score (1–4). |
| **Avg Environment Satisfaction** | `Avg Environment Satisfaction = AVERAGE(EmployeeData[EnvironmentSatisfaction])` | Calculates satisfaction with work environment. |
| **Avg Performance Rating** | `Avg Performance Rating = AVERAGE(EmployeeData[PerformanceRating])` | Displays average employee performance rating. |
| **Avg Work-Life Balance** | `Avg Work-Life Balance = AVERAGE(EmployeeData[WorkLifeBalance])` | Determines overall work-life satisfaction. |

---

### 🌿 5. Satisfaction & Engagement

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Overall Engagement Score** | `Overall Engagement Score = AVERAGEX(EmployeeData, (EmployeeData[JobSatisfaction] + EmployeeData[EnvironmentSatisfaction] + EmployeeData[WorkLifeBalance]) / 3)` | Composite measure of engagement based on satisfaction metrics. |
| **High Engagement %** | `High Engagement % = CALCULATE(DIVIDE(COUNTROWS(FILTER(EmployeeData, [Overall Engagement Score] > 3)), [Total Employees]))` | Shows percentage of highly engaged employees. |
| **Avg Training Times Last Year** | `Avg Training Times Last Year = AVERAGE(EmployeeData[TrainingTimesLastYear])` | Tracks average number of trainings per employee. |
| **Avg Relationship Satisfaction** | `Avg Relationship Satisfaction = AVERAGE(EmployeeData[RelationshipSatisfaction])` | Measures satisfaction with workplace relationships. |

---

### 📈 6. Scenario & Projection Metrics

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Attrition_Scenario Table** | ```DAX
Attrition_Scenario = 
DATATABLE(
    "Scenario", STRING,
    "Attrition Rate (%)", DOUBLE,
    {
        {"Before", 16.1},
        {"After", 11.5}
    }
)
``` | Custom table to simulate “Before vs After” HR improvements. |
| **Attrition Rate Before** | `Attrition Rate Before = CALCULATE(MAX(Attrition_Scenario[Attrition Rate (%)]), FILTER(Attrition_Scenario, Attrition_Scenario[Scenario]="Before"))` | Extracts baseline attrition rate. |
| **Attrition Rate After (Target)** | `Attrition Rate After = CALCULATE(MAX(Attrition_Scenario[Attrition Rate (%)]), FILTER(Attrition_Scenario, Attrition_Scenario[Scenario]="After"))` | Target rate after implementing HR actions. |

---

### 🧮 7. Supporting Calculations

| 🧠 Measure Name | 💡 DAX Formula | 📊 Description |
|-----------------|----------------|----------------|
| **Total Income** | `Total Income = SUM(EmployeeData[MonthlyIncome])` | Sum of all employee monthly incomes. |
| **Average Tenure (Years)** | `Average Tenure (Years) = AVERAGE(EmployeeData[YearsAtCompany])` | Measures average years of service. |
| **Total Overtime Employees** | `Total Overtime Employees = COUNTROWS(FILTER(EmployeeData, EmployeeData[OverTime]="Yes"))` | Counts employees doing overtime. |
| **Attrition Count (Overtime)** | `Attrition Count (Overtime) = SUMX(FILTER(EmployeeData, EmployeeData[OverTime]="Yes"), EmployeeData[Attrition(Number)])` | Attrition among overtime workers. |

---

### 📊 8. DAX Measure Usage by Dashboard Page

| 📄 Dashboard Page | 🔑 Key DAX Measures Used |
|-------------------|--------------------------|
| **Executive Overview** | Total Employees, Employees Left, Attrition Rate %, Avg Monthly Income |
| **Workforce Demographics** | Employees by Age Group, Employees by Gender, Avg Years at Company |
| **Attrition Analysis** | Attrition by Department %, Attrition by Age Group %, Attrition by Overtime % |
| **Compensation & Performance** | Avg Monthly Income, Avg Job Satisfaction, Avg Performance Rating |
| **Satisfaction & Engagement** | Overall Engagement Score, Avg Relationship Satisfaction, Avg Work-Life Balance |
| **Recommendations & Takeaways** | Attrition_Scenario table, Attrition Rate Before, Attrition Rate After |

---

### 🧠 Key Takeaway

These DAX measures make the dashboard **analytical, insightful, and HR-actionable**.  
They allow you to explore **attrition trends**, **satisfaction drivers**, and **compensation fairness**, while supporting storytelling through clear KPIs and scenario simulations.

---

### 🧱 Tools & Technologies Used
- **Power BI Desktop** – Dashboard design & interactivity  
- **Excel** – HR data cleaning and preparation  
- **DAX (Data Analysis Expressions)** – Metrics, KPIs, and scenario analysis  
- **Power Query** – Data transformation and modeling  

---

> 💡 *This DAX collection powers the HR Attrition & Employee Insights Dashboard — turning workforce data into a story of people, performance, and retention strategy.*
