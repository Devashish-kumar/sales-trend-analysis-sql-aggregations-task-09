-- ================================================================
-- TASK 9: SALES TREND ANALYSIS USING SQL AGGREGATIONS
-- Data Analytics Internship
-- ================================================================

-- ================================================================
-- SECTION 1: DATABASE SETUP AND DATA CREATION
-- ================================================================

-- Create database (uncomment if needed)
-- CREATE DATABASE sales_analytics;
-- USE sales_analytics;

-- Drop table if exists (for fresh start)
DROP TABLE IF EXISTS online_sales;

-- Create the online_sales table
CREATE TABLE online_sales (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    customer_id VARCHAR(20),
    product_category VARCHAR(50)
);

-- ================================================================
-- SECTION 2: INSERT SAMPLE DATA
-- ================================================================

-- Insert comprehensive sample data for analysis
INSERT INTO online_sales (order_id, order_date, amount, product_id, customer_id, product_category) VALUES
-- 2022 Data
('ORD001', '2022-01-15', 299.99, 'PROD001', 'CUST001', 'Electronics'),
('ORD002', '2022-01-20', 149.50, 'PROD002', 'CUST002', 'Clothing'),
('ORD003', '2022-02-10', 89.99, 'PROD003', 'CUST003', 'Books'),
('ORD004', '2022-02-25', 199.99, 'PROD004', 'CUST001', 'Electronics'),
('ORD005', '2022-03-05', 79.99, 'PROD005', 'CUST004', 'Home'),
('ORD006', '2022-03-18', 349.99, 'PROD006', 'CUST005', 'Electronics'),
('ORD007', '2022-04-02', 129.99, 'PROD007', 'CUST006', 'Clothing'),
('ORD008', '2022-04-15', 59.99, 'PROD008', 'CUST007', 'Books'),
('ORD009', '2022-05-10', 399.99, 'PROD009', 'CUST008', 'Electronics'),
('ORD010', '2022-05-22', 179.99, 'PROD010', 'CUST009', 'Home'),

-- 2023 Data (More comprehensive)
('ORD011', '2023-01-05', 459.99, 'PROD011', 'CUST010', 'Electronics'),
('ORD012', '2023-01-12', 229.99, 'PROD012', 'CUST011', 'Clothing'),
('ORD013', '2023-01-25', 99.99, 'PROD013', 'CUST012', 'Books'),
('ORD014', '2023-01-28', 189.99, 'PROD014', 'CUST013', 'Home'),
('ORD015', '2023-02-03', 329.99, 'PROD015', 'CUST014', 'Electronics'),
('ORD016', '2023-02-14', 159.99, 'PROD016', 'CUST015', 'Clothing'),
('ORD017', '2023-02-20', 79.99, 'PROD017', 'CUST016', 'Books'),
('ORD018', '2023-02-28', 249.99, 'PROD018', 'CUST017', 'Electronics'),
('ORD019', '2023-03-08', 119.99, 'PROD019', 'CUST018', 'Home'),
('ORD020', '2023-03-15', 389.99, 'PROD020', 'CUST019', 'Electronics'),
('ORD021', '2023-03-22', 199.99, 'PROD021', 'CUST020', 'Clothing'),
('ORD022', '2023-04-05', 149.99, 'PROD022', 'CUST021', 'Books'),
('ORD023', '2023-04-12', 279.99, 'PROD023', 'CUST022', 'Electronics'),
('ORD024', '2023-04-18', 89.99, 'PROD024', 'CUST023', 'Home'),
('ORD025', '2023-04-25', 359.99, 'PROD025', 'CUST024', 'Electronics'),
('ORD026', '2023-05-02', 129.99, 'PROD026', 'CUST025', 'Clothing'),
('ORD027', '2023-05-10', 219.99, 'PROD027', 'CUST026', 'Electronics'),
('ORD028', '2023-05-18', 99.99, 'PROD028', 'CUST027', 'Books'),
('ORD029', '2023-05-25', 449.99, 'PROD029', 'CUST028', 'Electronics'),
('ORD030', '2023-06-01', 179.99, 'PROD030', 'CUST029', 'Home'),
('ORD031', '2023-06-08', 259.99, 'PROD031', 'CUST030', 'Electronics'),
('ORD032', '2023-06-15', 139.99, 'PROD032', 'CUST031', 'Clothing'),
('ORD033', '2023-06-22', 189.99, 'PROD033', 'CUST032', 'Books'),
('ORD034', '2023-07-03', 329.99, 'PROD034', 'CUST033', 'Electronics'),
('ORD035', '2023-07-10', 149.99, 'PROD035', 'CUST034', 'Home'),
('ORD036', '2023-07-17', 299.99, 'PROD036', 'CUST035', 'Electronics'),
('ORD037', '2023-07-24', 119.99, 'PROD037', 'CUST036', 'Clothing'),
('ORD038', '2023-08-02', 399.99, 'PROD038', 'CUST037', 'Electronics'),
('ORD039', '2023-08-09', 159.99, 'PROD039', 'CUST038', 'Books'),
('ORD040', '2023-08-16', 279.99, 'PROD040', 'CUST039', 'Home'),
('ORD041', '2023-08-23', 349.99, 'PROD041', 'CUST040', 'Electronics'),
('ORD042', '2023-09-01', 199.99, 'PROD042', 'CUST041', 'Clothing'),
('ORD043', '2023-09-08', 229.99, 'PROD043', 'CUST042', 'Electronics'),
('ORD044', '2023-09-15', 89.99, 'PROD044', 'CUST043', 'Books'),
('ORD045', '2023-09-22', 419.99, 'PROD045', 'CUST044', 'Electronics'),
('ORD046', '2023-10-05', 169.99, 'PROD046', 'CUST045', 'Home'),
('ORD047', '2023-10-12', 309.99, 'PROD047', 'CUST046', 'Electronics'),
('ORD048', '2023-10-19', 129.99, 'PROD048', 'CUST047', 'Clothing'),
('ORD049', '2023-10-26', 249.99, 'PROD049', 'CUST048', 'Books'),
('ORD050', '2023-11-02', 379.99, 'PROD050', 'CUST049', 'Electronics'),
('ORD051', '2023-11-09', 159.99, 'PROD051', 'CUST050', 'Home'),
('ORD052', '2023-11-16', 289.99, 'PROD052', 'CUST001', 'Electronics'),
('ORD053', '2023-11-23', 119.99, 'PROD053', 'CUST002', 'Clothing'),
('ORD054', '2023-12-01', 459.99, 'PROD054', 'CUST003', 'Electronics'),
('ORD055', '2023-12-08', 199.99, 'PROD055', 'CUST004', 'Books'),
('ORD056', '2023-12-15', 329.99, 'PROD056', 'CUST005', 'Home'),
('ORD057', '2023-12-22', 389.99, 'PROD057', 'CUST006', 'Electronics'),

-- 2024 Data (Q1)
('ORD058', '2024-01-10', 299.99, 'PROD058', 'CUST007', 'Electronics'),
('ORD059', '2024-01-17', 149.99, 'PROD059', 'CUST008', 'Clothing'),
('ORD060', '2024-01-24', 199.99, 'PROD060', 'CUST009', 'Books'),
('ORD061', '2024-02-05', 359.99, 'PROD061', 'CUST010', 'Electronics'),
('ORD062', '2024-02-12', 129.99, 'PROD062', 'CUST011', 'Home'),
('ORD063', '2024-02-19', 279.99, 'PROD063', 'CUST012', 'Electronics'),
('ORD064', '2024-03-01', 189.99, 'PROD064', 'CUST013', 'Clothing'),
('ORD065', '2024-03-08', 249.99, 'PROD065', 'CUST014', 'Electronics'),
('ORD066', '2024-03-15', 119.99, 'PROD066', 'CUST015', 'Books'),
('ORD067', '2024-03-22', 399.99, 'PROD067', 'CUST016', 'Electronics');

-- Verify data insertion
SELECT COUNT(*) as total_records FROM online_sales;
SELECT MIN(order_date) as earliest_order, MAX(order_date) as latest_order FROM online_sales;

-- ================================================================
-- SECTION 3: BASIC DATA EXPLORATION
-- ================================================================

-- View sample data
SELECT * FROM online_sales 
ORDER BY order_date 
LIMIT 10;

-- Check data distribution by year
SELECT 
    EXTRACT(YEAR FROM order_date) as year,
    COUNT(*) as order_count,
    SUM(amount) as total_revenue
FROM online_sales 
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year;

-- ================================================================
-- SECTION 4: MAIN SALES TREND ANALYSIS QUERIES
-- ================================================================

-- ----------------------------------------------------------------
-- QUERY 1: Monthly Revenue and Order Volume Trends (All Years)
-- ----------------------------------------------------------------
SELECT 
    EXTRACT(YEAR FROM order_date) as year,
    EXTRACT(MONTH FROM order_date) as month,
    CONCAT(EXTRACT(YEAR FROM order_date), '-', 
           LPAD(EXTRACT(MONTH FROM order_date), 2, '0')) as year_month,
    COUNT(DISTINCT order_id) as order_volume,
    SUM(amount) as monthly_revenue,
    ROUND(AVG(amount), 2) as avg_order_value,
    MIN(amount) as min_order_value,
    MAX(amount) as max_order_value
FROM online_sales
GROUP BY 
    EXTRACT(YEAR FROM order_date), 
    EXTRACT(MONTH FROM order_date)
ORDER BY year, month;

-- ----------------------------------------------------------------
-- QUERY 2: 2023 Specific Analysis (Primary Focus Year)
-- ----------------------------------------------------------------
SELECT 
    EXTRACT(MONTH FROM order_date) as month,
    CASE EXTRACT(MONTH FROM order_date)
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February' 
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END as month_name,
    COUNT(DISTINCT order_id) as order_volume,
    SUM(amount) as monthly_revenue,
    ROUND(AVG(amount), 2) as avg_order_value
FROM online_sales
WHERE EXTRACT(YEAR FROM order_date) = 2023
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY month;

-- ----------------------------------------------------------------
-- QUERY 3: Top 5 Revenue-Generating Months (All Time)
-- ----------------------------------------------------------------
SELECT 
    CONCAT(EXTRACT(YEAR FROM order_date), '-', 
           LPAD(EXTRACT(MONTH FROM order_date), 2, '0')) as year_month,
    CASE EXTRACT(MONTH FROM order_date)
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February' 
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END as month_name,
    EXTRACT(YEAR FROM order_date) as year,
    COUNT(DISTINCT order_id) as order_volume,
    SUM(amount) as monthly_revenue,
    ROUND(AVG(amount), 2) as avg_order_value
FROM online_sales
GROUP BY 
    EXTRACT(YEAR FROM order_date), 
    EXTRACT(MONTH FROM order_date)
ORDER BY monthly_revenue DESC
LIMIT 5;

-- ----------------------------------------------------------------
-- QUERY 4: Year-over-Year Growth Analysis
-- ----------------------------------------------------------------
WITH monthly_stats AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) as year,
        EXTRACT(MONTH FROM order_date) as month,
        SUM(amount) as monthly_revenue,
        COUNT(DISTINCT order_id) as order_volume
    FROM online_sales
    GROUP BY 
        EXTRACT(YEAR FROM order_date), 
        EXTRACT(MONTH FROM order_date)
)
SELECT 
    year,
    month,
    CASE month
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February' 
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END as month_name,
    monthly_revenue,
    order_volume,
    LAG(monthly_revenue) OVER (PARTITION BY month ORDER BY year) as prev_year_revenue,
    ROUND(
        ((monthly_revenue - LAG(monthly_revenue) OVER (PARTITION BY month ORDER BY year)) / 
         LAG(monthly_revenue) OVER (PARTITION BY month ORDER BY year)) * 100, 2
    ) as revenue_growth_percent
FROM monthly_stats
ORDER BY year, month;

-- ----------------------------------------------------------------
-- QUERY 5: Quarterly Analysis
-- ----------------------------------------------------------------
SELECT 
    EXTRACT(YEAR FROM order_date) as year,
    CASE 
        WHEN EXTRACT(MONTH FROM order_date) IN (1,2,3) THEN 'Q1'
        WHEN EXTRACT(MONTH FROM order_date) IN (4,5,6) THEN 'Q2'
        WHEN EXTRACT(MONTH FROM order_date) IN (7,8,9) THEN 'Q3'
        WHEN EXTRACT(MONTH FROM order_date) IN (10,11,12) THEN 'Q4'
    END as quarter,
    COUNT(DISTINCT order_id) as order_volume,
    SUM(amount) as quarterly_revenue,
    ROUND(AVG(amount), 2) as avg_order_value,
    COUNT(DISTINCT customer_id) as unique_customers
FROM online_sales
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    CASE 
        WHEN EXTRACT(MONTH FROM order_date) IN (1,2,3) THEN 'Q1'
        WHEN EXTRACT(MONTH FROM order_date) IN (4,5,6) THEN 'Q2'
        WHEN EXTRACT(MONTH FROM order_date) IN (7,8,9) THEN 'Q3'
        WHEN EXTRACT(MONTH FROM order_date) IN (10,11,12) THEN 'Q4'
    END
ORDER BY year, quarter;

-- ----------------------------------------------------------------
-- QUERY 6: Category-wise Monthly Trends (2023)
-- ----------------------------------------------------------------
SELECT 
    EXTRACT(MONTH FROM order_date) as month,
    product_category,
    COUNT(DISTINCT order_id) as order_volume,
    SUM(amount) as category_revenue,
    ROUND(AVG(amount), 2) as avg_order_value
FROM online_sales
WHERE EXTRACT(YEAR FROM order_date) = 2023
GROUP BY 
    EXTRACT(MONTH FROM order_date),
    product_category
ORDER BY month, category_revenue DESC;

-- ----------------------------------------------------------------
-- QUERY 7: Peak Sales Periods Identification
-- ----------------------------------------------------------------
WITH monthly_revenue AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) as year,
        EXTRACT(MONTH FROM order_date) as month,
        SUM(amount) as monthly_revenue
    FROM online_sales
    GROUP BY 
        EXTRACT(YEAR FROM order_date), 
        EXTRACT(MONTH FROM order_date)
),
avg_monthly_revenue AS (
    SELECT AVG(monthly_revenue) as avg_revenue
    FROM monthly_revenue
)
SELECT 
    mr.year,
    mr.month,
    CASE mr.month
        WHEN 1 THEN 'January' WHEN 2 THEN 'February' WHEN 3 THEN 'March'
        WHEN 4 THEN 'April' WHEN 5 THEN 'May' WHEN 6 THEN 'June'
        WHEN 7 THEN 'July' WHEN 8 THEN 'August' WHEN 9 THEN 'September'
        WHEN 10 THEN 'October' WHEN 11 THEN 'November' WHEN 12 THEN 'December'
    END as month_name,
    mr.monthly_revenue,
    ROUND(amr.avg_revenue, 2) as overall_avg_revenue,
    CASE 
        WHEN mr.monthly_revenue > amr.avg_revenue * 1.2 THEN 'Peak Period'
        WHEN mr.monthly_revenue < amr.avg_revenue * 0.8 THEN 'Low Period'
        ELSE 'Normal Period'
    END as sales_period_type
FROM monthly_revenue mr
CROSS JOIN avg_monthly_revenue amr
ORDER BY mr.monthly_revenue DESC;

-- ----------------------------------------------------------------
-- QUERY 8: Customer Behavior Analysis by Month (2023)
-- ----------------------------------------------------------------
SELECT 
    EXTRACT(MONTH FROM order_date) as month,
    CASE EXTRACT(MONTH FROM order_date)
        WHEN 1 THEN 'January' WHEN 2 THEN 'February' WHEN 3 THEN 'March'
        WHEN 4 THEN 'April' WHEN 5 THEN 'May' WHEN 6 THEN 'June'
        WHEN 7 THEN 'July' WHEN 8 THEN 'August' WHEN 9 THEN 'September'
        WHEN 10 THEN 'October' WHEN 11 THEN 'November' WHEN 12 THEN 'December'
    END as month_name,
    COUNT(DISTINCT order_id) as total_orders,
    COUNT(DISTINCT customer_id) as unique_customers,
    ROUND(COUNT(DISTINCT order_id) * 1.0 / COUNT(DISTINCT customer_id), 2) as orders_per_customer,
    SUM(amount) as total_revenue,
    ROUND(SUM(amount) / COUNT(DISTINCT customer_id), 2) as revenue_per_customer
FROM online_sales
WHERE EXTRACT(YEAR FROM order_date) = 2023
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY month;

-- ================================================================
-- SECTION 5: ADVANCED ANALYTICS
-- ================================================================

-- ----------------------------------------------------------------
-- QUERY 9: Running Total and Moving Averages
-- ----------------------------------------------------------------
WITH monthly_data AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) as year,
        EXTRACT(MONTH FROM order_date) as month,
        SUM(amount) as monthly_revenue
    FROM online_sales
    WHERE EXTRACT(YEAR FROM order_date) = 2023
    GROUP BY 
        EXTRACT(YEAR FROM order_date), 
        EXTRACT(MONTH FROM order_date)
)
SELECT 
    month,
    CASE month
        WHEN 1 THEN 'January' WHEN 2 THEN 'February' WHEN 3 THEN 'March'
        WHEN 4 THEN 'April' WHEN 5 THEN 'May' WHEN 6 THEN 'June'
        WHEN 7 THEN 'July' WHEN 8 THEN 'August' WHEN 9 THEN 'September'
        WHEN 10 THEN 'October' WHEN 11 THEN 'November' WHEN 12 THEN 'December'
    END as month_name,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY month) as running_total,
    ROUND(AVG(monthly_revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) as three_month_avg
FROM monthly_data
ORDER BY month;

-- ----------------------------------------------------------------
-- QUERY 10: Summary Statistics Report
-- ----------------------------------------------------------------
SELECT 
    'Overall Statistics' as metric_type,
    COUNT(DISTINCT order_id) as total_orders,
    COUNT(DISTINCT customer_id) as total_customers,
    COUNT(DISTINCT product_id) as total_products,
    ROUND(SUM(amount), 2) as total_revenue,
    ROUND(AVG(amount), 2) as avg_order_value,
    ROUND(MIN(amount), 2) as min_order_value,
    ROUND(MAX(amount), 2) as max_order_value,
    COUNT(DISTINCT DATE_FORMAT(order_date, '%Y-%m')) as months_with_data
FROM online_sales

UNION ALL

SELECT 
    '2023 Statistics' as metric_type,
    COUNT(DISTINCT order_id) as total_orders,
    COUNT(DISTINCT customer_id) as total_customers,
    COUNT(DISTINCT product_id) as total_products,
    ROUND(SUM(amount), 2) as total_revenue,
    ROUND(AVG(amount), 2) as avg_order_value,
    ROUND(MIN(amount), 2) as min_order_value,
    ROUND(MAX(amount), 2) as max_order_value,
    COUNT(DISTINCT DATE_FORMAT(order_date, '%Y-%m')) as months_with_data
FROM online_sales
WHERE EXTRACT(YEAR FROM order_date) = 2023;

-- ================================================================
-- END OF ANALYSIS
-- ================================================================