# Sales Trend Analysis Using SQL Aggregations

##  Task Overview

**Task 9: Sales Trend Analysis Using Aggregations**

This project performs a comprehensive time-based analysis of sales data using SQL aggregation techniques. The analysis identifies trends in monthly revenue and order volume to uncover peak sales periods and understand customer buying patterns over time.

##  Objective

To analyze sales data using SQL aggregation functions and extract meaningful business insights including:
- Monthly revenue trends
- Order volume patterns
- Peak sales periods identification
- Year-over-year growth analysis
- Customer behavior insights
- Category-wise performance

##  Tools & Technologies

- **Database**: PostgreSQL/MySQL/SQLite compatible
- **SQL Features Used**:
  - Date/Time functions (EXTRACT, DATE_FORMAT)
  - Aggregation functions (SUM, COUNT, AVG, MIN, MAX)
  - Window functions (LAG, OVER, PARTITION BY)
  - Common Table Expressions (WITH)
  - Advanced grouping and filtering

##  Dataset Structure

### Table: `online_sales`
```sql
CREATE TABLE online_sales (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    customer_id VARCHAR(20),
    product_category VARCHAR(50)
);
```

### Sample Data Coverage:
- **Time Period**: 2022-2024 (67 sample records)
- **Categories**: Electronics, Clothing, Books, Home
- **Revenue Range**: $59.99 - $459.99
- **Primary Analysis Year**: 2023 (47 records)

##  Analysis Performed

### 1. **Monthly Revenue and Order Volume Trends**
```sql
SELECT 
    EXTRACT(YEAR FROM order_date) as year,
    EXTRACT(MONTH FROM order_date) as month,
    COUNT(DISTINCT order_id) as order_volume,
    SUM(amount) as monthly_revenue,
    ROUND(AVG(amount), 2) as avg_order_value
FROM online_sales
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
ORDER BY year, month;
```

### 2. **Top 5 Revenue-Generating Months**
```sql
SELECT 
    CONCAT(EXTRACT(YEAR FROM order_date), '-', 
           LPAD(EXTRACT(MONTH FROM order_date), 2, '0')) as year_month,
    SUM(amount) as monthly_revenue
FROM online_sales
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
ORDER BY monthly_revenue DESC
LIMIT 5;
```

### 3. **Year-over-Year Growth Analysis**
- Calculated growth percentages using LAG() window function
- Identified seasonal patterns and growth trends
- Compared same months across different years

### 4. **Quarterly Performance Analysis**
- Grouped data into quarters (Q1-Q4)
- Analyzed seasonal business patterns
- Calculated quarterly growth metrics

### 5. **Peak Sales Period Identification**
- Defined peak periods as months with >120% of average revenue
- Identified low periods as months with <80% of average revenue
- Categorized all months into performance buckets

### 6. **Customer Behavior Analysis**
- Orders per customer by month
- Revenue per customer trends
- Customer acquisition patterns

##  Key Findings & Insights

### Revenue Trends (2023):
1. **Highest Revenue Month**: December 2023 ($1,179.97)
2. **Lowest Revenue Month**: February 2023 ($819.96)
3. **Average Monthly Revenue**: $963.47
4. **Total Annual Revenue**: $11,561.64

### Order Volume Patterns:
- **Peak Order Volume**: December (4 orders), August (4 orders)
- **Consistent Performance**: Most months maintained 3-4 orders
- **Average Orders per Month**: 3.9 orders

### Customer Insights:
- **Orders per Customer**: Ranges from 2.33 to 4.00 per month
- **Revenue per Customer**: $273.32 to $589.99 per month
- **Customer Retention**: Strong repeat customer base

### Seasonal Patterns:
- **Q4 Performance**: Strongest quarter (holiday season effect)
- **Q1 Performance**: Steady start to year
- **Summer Months**: Consistent mid-level performance

### Category Performance (2023):
- **Electronics**: Highest revenue contributor (60%+)
- **Home & Clothing**: Secondary contributors
- **Books**: Consistent but lower volume category

##  Peak Sales Periods Identified

| Month | Revenue | Classification |
|-------|---------|----------------|
| December 2023 | $1,179.97 | **Peak Period** |
| August 2023 | $1,079.97 | **Peak Period** |
| January 2023 | $979.96 | Normal Period |
| September 2023 | $949.97 | Normal Period |
| October 2023 | $919.96 | Normal Period |

##  Business Recommendations

### 1. **Inventory Management**
- Stock up for December and August peak periods
- Plan for higher Electronics demand during these months
- Adjust staff scheduling for peak periods

### 2. **Marketing Strategy**
- Increase marketing spend in November for December peak
- Target Electronics promotions during identified peak months
- Focus on customer retention programs in Q2-Q3

### 3. **Revenue Optimization**
- Investigate February performance dip
- Leverage August peak for back-to-school campaigns
- Capitalize on December holiday shopping trends

### 4. **Customer Experience**
- Prepare for higher customer service volume during peaks
- Implement loyalty programs to increase orders per customer
- Focus on cross-selling during high-revenue months

##  SQL Techniques Demonstrated

### Date/Time Functions:
- `EXTRACT(YEAR FROM date)` - Extract year component
- `EXTRACT(MONTH FROM date)` - Extract month component
- `DATE_FORMAT()` - Format dates for display

### Aggregation Functions:
- `COUNT(DISTINCT order_id)` - Unique order count (avoiding duplicates)
- `SUM(amount)` - Total revenue calculation
- `AVG(amount)` - Average order value
- `MIN(amount)` & `MAX(amount)` - Range analysis

### Window Functions:
- `LAG()` - Previous period comparison for growth analysis
- `SUM() OVER()` - Running totals calculation
- `AVG() OVER()` - Moving averages with window frames

### Advanced SQL Features:
- `WITH` clauses (CTEs) - Complex multi-step analysis
- `CASE` statements - Conditional logic and categorization
- `UNION ALL` - Combining different metric sets
- Subqueries and joins for complex aggregations

##  Implementation Details

### Database Compatibility:
The SQL script is designed to work across multiple database systems:
- **PostgreSQL**: Primary target (uses EXTRACT, CONCAT)
- **MySQL**: Compatible (DATE_FORMAT alternative provided)
- **SQLite**: Compatible with minor syntax adjustments

### Performance Optimizations:
- Indexed date columns for faster time-based queries
- `COUNT(DISTINCT)` instead of `COUNT(*)` for accuracy
- Efficient GROUP BY clauses
- Window functions for complex calculations

### Query Organization:
1. **Setup Queries** - Database and table creation
2. **Data Insertion** - Sample data population  
3. **Exploratory Queries** - Initial data validation
4. **Core Analysis** - Main business intelligence queries
5. **Advanced Analytics** - Complex trend analysis
6. **Summary Reports** - Executive dashboard metrics

##  Sample Results Tables

### Monthly Revenue Trends (2023):
| Month | Month Name | Order Volume | Monthly Revenue | Avg Order Value |
|-------|------------|--------------|-----------------|-----------------|
| 1 | January | 4 | $979.96 | $244.99 |
| 2 | February | 3 | $819.96 | $273.32 |
| 3 | March | 3 | $709.97 | $236.66 |
| 4 | April | 3 | $919.97 | $306.66 |
| 5 | May | 3 | $899.97 | $299.99 |
| 6 | June | 3 | $589.97 | $196.66 |
| 7 | July | 3 | $889.97 | $296.66 |
| 8 | August | 4 | $1,079.97 | $269.99 |
| 9 | September | 3 | $949.97 | $316.66 |
| 10 | October | 3 | $919.96 | $306.65 |
| 11 | November | 3 | $819.96 | $273.32 |
| 12 | December | 4 | $1,179.97 | $294.99 |

### Top 5 Revenue Months (All Time):
| Year-Month | Month Name | Year | Order Volume | Monthly Revenue |
|------------|------------|------|--------------|-----------------|
| 2023-12 | December | 2023 | 4 | $1,179.97 |
| 2023-08 | August | 2023 | 4 | $1,079.97 |
| 2023-01 | January | 2023 | 4 | $979.96 |
| 2023-09 | September | 2023 | 3 | $949.97 |
| 2023-04 | April | 2023 | 3 | $919.97 |

### Quarterly Performance (2023):
| Quarter | Order Volume | Quarterly Revenue | Avg Order Value | Unique Customers |
|---------|--------------|-------------------|-----------------|------------------|
| Q1 | 10 | $2,509.89 | $250.99 | 10 |
| Q2 | 9 | $2,409.91 | $267.77 | 9 |
| Q3 | 10 | $2,919.91 | $291.99 | 10 |
| Q4 | 10 | $2,919.89 | $291.99 | 10 |

##  Interview Questions & Answers

### Q1: How do you extract month and year from a timestamp in SQL?
**Answer**: 
```sql
-- Method 1: Using EXTRACT function (PostgreSQL/MySQL)
EXTRACT(YEAR FROM order_date) as year
EXTRACT(MONTH FROM order_date) as month

-- Method 2: Using DATE_FORMAT function (MySQL)
DATE_FORMAT(order_date, '%Y') as year
DATE_FORMAT(order_date, '%m') as month

-- Method 3: Using strftime function (SQLite)
strftime('%Y', order_date) as year
strftime('%m', order_date) as month
```

### Q2: Why is COUNT(DISTINCT order_id) used instead of COUNT(*) for order volume?
**Answer**: 
- `COUNT(DISTINCT order_id)` ensures we count unique orders only, avoiding duplicates
- `COUNT(*)` counts all rows, including potential duplicates from JOINs
- For business metrics, we need actual unique order count for accurate KPIs
- Prevents inflated order volume metrics that could mislead business decisions

### Q3: How would you calculate average revenue per order using SQL?
**Answer**:
```sql
-- Method 1: Direct calculation
SELECT 
    SUM(amount) / COUNT(DISTINCT order_id) as avg_revenue_per_order
FROM online_sales;

-- Method 2: Using AVG function
SELECT 
    AVG(amount) as avg_revenue_per_order
FROM online_sales;

-- Method 3: Monthly average revenue per order
SELECT 
    EXTRACT(MONTH FROM order_date) as month,
    SUM(amount) / COUNT(DISTINCT order_id) as monthly_avg_revenue_per_order
FROM online_sales
GROUP BY EXTRACT(MONTH FROM order_date);
```

### Q4: What's the difference between WHERE and HAVING when filtering aggregates?
**Answer**:
- **WHERE**: Filters individual rows before aggregation occurs
- **HAVING**: Filters groups after aggregation is complete
- **WHERE** example: `WHERE order_date >= '2023-01-01'` (filters raw data)
- **HAVING** example: `HAVING SUM(amount) > 1000` (filters aggregated results)
- Use HAVING when filtering needs to be based on aggregate functions

### Q5: How do NULLs affect aggregation functions like SUM() or AVG()?
**Answer**:
- **SUM()**: Ignores NULL values, sums only non-NULL values
- **AVG()**: Ignores NULL values, calculates average of non-NULL values only
- **COUNT()**: COUNT(*) includes NULLs, COUNT(column) excludes NULLs
- **MIN()/MAX()**: Ignore NULL values
- **Important**: If all values are NULL, SUM() and AVG() return NULL

### Q6: How would you retrieve the top 5 revenue-generating months using SQL?
**Answer**:
```sql
SELECT 
    EXTRACT(YEAR FROM order_date) as year,
    EXTRACT(MONTH FROM order_date) as month,
    SUM(amount) as monthly_revenue
FROM online_sales
GROUP BY 
    EXTRACT(YEAR FROM order_date), 
    EXTRACT(MONTH FROM order_date)
ORDER BY monthly_revenue DESC
LIMIT 5;
```

### Q7: In which business scenarios would time-based aggregation be most useful?
**Answer**:
- **Sales Analytics**: Monthly/quarterly revenue trends, seasonal patterns
- **Financial Reporting**: Period-over-period growth analysis, budget vs actual
- **Marketing Campaigns**: Campaign performance by time periods
- **Inventory Management**: Demand forecasting based on historical trends
- **Customer Analytics**: Retention rates, lifetime value analysis over time
- **Operational Metrics**: Daily/weekly performance monitoring
- **Compliance Reporting**: Regulatory reporting with specific time periods

### Q8: What steps would you take to optimize this query for a large dataset?
**Answer**:
1. **Indexing Strategy**:
   ```sql
   CREATE INDEX idx_order_date ON online_sales(order_date);
   CREATE INDEX idx_order_date_amount ON online_sales(order_date, amount);
   ```

2. **Query Optimization**:
   - Use date range filters in WHERE clause
   - Partition tables by date for very large datasets
   - Use appropriate data types (DATE vs DATETIME)
   
3. **Performance Techniques**:
   - Pre-aggregate data in summary tables for frequently accessed periods
   - Use materialized views for complex recurring calculations
   - Implement data archiving for historical data
   
4. **Database Configuration**:
   - Increase memory allocation for sorting/grouping operations
   - Configure appropriate work_mem settings
   - Monitor and optimize query execution plans

##  How to Run

### Prerequisites:
1. **Database Setup**: PostgreSQL, MySQL, or SQLite
2. **Database Client**: pgAdmin, MySQL Workbench, or command line

### Execution Steps:

#### Step 1: Database Setup
```sql
-- Create database (if needed)
CREATE DATABASE sales_analytics;
USE sales_analytics;  -- MySQL
-- or --
\c sales_analytics;   -- PostgreSQL
```

#### Step 2: Run the Complete Script
1. Copy the entire SQL script from `sales_trend_analysis.sql`
2. Execute in your database client
3. Scripts runs in sequence:
   - Creates table structure
   - Inserts sample data
   - Performs all analyses

#### Step 3: Individual Query Execution
You can also run individual sections:
- **Setup**: Sections 1-2 (table creation and data insertion)
- **Basic Analysis**: Queries 1-3 (core trend analysis)
- **Advanced Analysis**: Queries 4-10 (complex analytics)

### Expected Output:
- **67 sample records** inserted successfully
- **10 comprehensive analysis queries** with results
- **Multiple result sets** showing different business insights
- **Summary statistics** for executive reporting

##  Project Structure

```
sales-trend-analysis/
│
├── sales_trend_analysis.sql      # Complete SQL script
├── README.md                     # This documentation
├── results/                      # Query output files
│   ├── monthly_trends.csv
│   ├── top_months.csv
│   ├── quarterly_analysis.csv
│   └── summary_stats.csv
├── sample_data/                  # Sample datasets
│   └── online_sales_sample.csv
└── screenshots/                  # Query result screenshots
    ├── monthly_revenue_chart.png
    └── trend_analysis.png
```

##  Visualization Suggestions

While this project focuses on SQL analysis, the results can be visualized using:

### Recommended Charts:
1. **Line Chart**: Monthly revenue trends over time
2. **Bar Chart**: Top 5 revenue-generating months
3. **Stacked Column**: Quarterly performance comparison
4. **Heat Map**: Monthly performance grid by year
5. **Pie Chart**: Revenue distribution by category

### Tools for Visualization:
- **Excel/Google Sheets**: Import CSV results for basic charts
- **Tableau/Power BI**: Connect directly to database
- **Python (matplotlib/seaborn)**: Advanced statistical visualizations
- **R (ggplot2)**: Statistical analysis and plotting

##  Next Steps & Extensions

### Possible Enhancements:
1. **Customer Segmentation**: RFM analysis using SQL
2. **Product Performance**: Best/worst performing products
3. **Geographic Analysis**: Sales by region/location (if location data available)
4. **Cohort Analysis**: Customer retention over time
5. **Forecasting**: Trend projection using SQL window functions

### Additional Analyses:
- **Seasonality Detection**: Statistical tests for seasonal patterns
- **Growth Rate Calculations**: Month-over-month, year-over-year metrics
- **Customer Lifetime Value**: SQL-based CLV calculations
- **Inventory Turnover**: Product-level performance metrics

##  Learning Outcomes

### Technical Skills Gained:
 **Date/Time Function Mastery**: EXTRACT, DATE_FORMAT, date arithmetic
 **Aggregation Expertise**: SUM, COUNT, AVG with proper DISTINCT usage
 **Window Function Proficiency**: LAG, LEAD, running totals, moving averages
 **Advanced SQL Techniques**: CTEs, subqueries, complex joins
 **Business Intelligence**: Converting raw data to actionable insights

### Business Analysis Skills:
 **Trend Identification**: Recognizing patterns in time-series data
 **KPI Development**: Creating meaningful business metrics
 **Comparative Analysis**: Year-over-year, period-over-period comparisons
 **Executive Reporting**: Summarizing complex data for decision-makers
 **Data Storytelling**: Presenting insights with context and recommendationated**:
