# Project Title: Customer Retention and Lifetime Value Analysis Using Cohort Analysis on AdventureWorks Dataset

## Project Overview:

Dataset: AdventureWorks2022.bak (https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms)

Cohort analysis is a technique used to track and analyze the behavior of groups of users (cohorts) over time. A cohort is a group of people who share a common characteristic within a specific time frame, such as their first purchase date, sign-up date, or first interaction with a company.

In business intelligence, cohort analysis helps understand customer retention, lifetime value, and purchase behavior trends by examining how different cohorts behave over time.

- Retention rate measures the percentage of customers who continue to do business with a company over a specified period, indicating how well a company is keeping its customers. It’s an important metric for understanding customer loyalty and the effectiveness of retention strategies.

- Customer Lifetime Value (CLV) is a predictive metric that estimates the total revenue or profit a business can expect from a customer during their entire relationship with the company. CLV helps businesses determine how much they should invest in acquiring and retaining customers.

## Objectives:

Analyze customer retention, Customer Lifetime Value (CLV), churn patterns, and cohort behavior

## Project Structure:
1. Data Preparation
- Extract necessary fields (CustomerID, OrderDate, TotalDue).
- Convert OrderDate to cohort-based timeframes (Year/Month).
2. Cohort Identification
- Identify the first purchase date (cohort) for each customer.
- Assign customers to their respective cohorts (Year/Month).
3. Customer Retention Analysis
- Track how many customers return in each subsequent month.
- Calculate retention rates for each cohort.
- Visualize retention trends in a matrix.
4. Customer Lifetime Value (CLV) Analysis
- Calculate revenue per cohort over time.
- Compute cumulative revenue per cohort.
- Identify high-value cohorts contributing the most revenue.
5. Churn & Loyalty Analysis
- Determine when customers stop purchasing (churn point).
- Segment customers into one-time buyers, occasional, and loyal customers.
- Compare revenue contribution of loyal vs. churned customers.
6. Cohort Behavior Segmentation
- Analyze purchase frequency per cohort.
- Identify seasonal trends in purchasing behavior.
- Assess the impact of promotions on retention.
7. Insights & Recommendations
- Suggest strategies to improve retention (e.g., loyalty programs).
- Identify the best-performing customer segments for targeted marketing.
- Optimize product offerings based on cohort preferences.

----

## Analyze customer retention Rate

1. Identify the Cohort for Each Customer
```sql
-- This query finds the first purchase date (month) for each customer:
WITH FirstPurchaseCohort AS (
    SELECT
        CustomerID,
        DATEPART(YEAR, MIN(OrderDate)) AS CohortYear, -- Get the Year of the first purchase
        DATEPART(MONTH, MIN(OrderDate)) AS CohortMonth -- Get the Month of the first purchase
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
)
SELECT * FROM FirstPurchaseCohort
ORDER BY CohortYear ASC, CohortMonth ASC;
```

2. Combine Cohort Data with Orders
```sql
--Join the cohort data with order data to track customer purchases over time:
WITH FirstPurchaseCohort AS (
    SELECT
        CustomerID,
        DATEPART(YEAR, MIN(OrderDate)) AS CohortYear, -- Get the Year of the first purchase
        DATEPART(MONTH, MIN(OrderDate)) AS CohortMonth -- Get the Month of the first purchase
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
),
CustomerOrders AS (
    SELECT
        fpc.CustomerID,
        fpc.CohortYear,
        fpc.CohortMonth,
        DATEPART(YEAR, soh.OrderDate) AS OrderYear,
        DATEPART(MONTH, soh.OrderDate) AS OrderMonth
    FROM FirstPurchaseCohort fpc
    JOIN Sales.SalesOrderHeader soh
        ON fpc.CustomerID = soh.CustomerID
)
SELECT * FROM CustomerOrders;
-- => The SQL query you have right now is only tracking the first purchase and subsequent second purchases (or any repeat purchases) in terms of the first purchase cohort.
```
3. Count Active Customers per Cohort Over Time
```sql
-- Now, calculate the number of active customers in each cohort for each month:
WITH FirstPurchaseCohort AS (
    SELECT
        CustomerID,
        DATEPART(YEAR, MIN(OrderDate)) AS CohortYear, -- Get the Year of the first purchase
        DATEPART(MONTH, MIN(OrderDate)) AS CohortMonth -- Get the Month of the first purchase
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
),
CustomerOrders AS (
    SELECT
        fpc.CustomerID,
        fpc.CohortYear,
        fpc.CohortMonth,
        DATEPART(YEAR, soh.OrderDate) AS OrderYear,
        DATEPART(MONTH, soh.OrderDate) AS OrderMonth
    FROM FirstPurchaseCohort fpc
    JOIN Sales.SalesOrderHeader soh
        ON fpc.CustomerID = soh.CustomerID
),
CohortAnalysis AS (
    SELECT
        CohortYear,
        CohortMonth,
        OrderYear,
        OrderMonth,
        COUNT(DISTINCT CustomerID) AS ActiveCustomers
    FROM CustomerOrders
    GROUP BY CohortYear, CohortMonth, OrderYear, OrderMonth
)
SELECT
    CohortYear,
    CohortMonth,
    OrderYear,
    OrderMonth,
    ActiveCustomers
FROM CohortAnalysis
ORDER BY CohortYear, CohortMonth, OrderYear, OrderMonth;
--=> This output helps you track the retention and activity of customers based on their first purchase in January 2011
--=> For example: In June 2011 (OrderYear = 2011, OrderMonth = 6), 7 unique customers from the January 2011 cohort made a purchase.
```
4. Calculate Retention Rates
```sql
-- To calculate retention rates, divide the number of active customers by the cohort size:
WITH FirstPurchaseCohort AS (
    SELECT
        CustomerID,
        DATEPART(YEAR, MIN(OrderDate)) AS CohortYear, -- Get the Year of the first purchase
        DATEPART(MONTH, MIN(OrderDate)) AS CohortMonth -- Get the Month of the first purchase
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
),
CustomerOrders AS (
    SELECT
        fpc.CustomerID,
        fpc.CohortYear,
        fpc.CohortMonth,
        DATEPART(YEAR, soh.OrderDate) AS OrderYear,
        DATEPART(MONTH, soh.OrderDate) AS OrderMonth,
        ROW_NUMBER() OVER (PARTITION BY fpc.CustomerID ORDER BY soh.OrderDate) AS OrderRank
    FROM FirstPurchaseCohort fpc
    JOIN Sales.SalesOrderHeader soh
        ON fpc.CustomerID = soh.CustomerID
),
ReturnCustomers AS (
    SELECT
        CustomerID,
        CohortYear,
        CohortMonth,
        OrderYear,
        OrderMonth
    FROM CustomerOrders
    WHERE OrderRank > 1  -- This filters out first-time purchasers (only return customers)
),
CohortSizes AS (
    SELECT
        CohortYear,
        CohortMonth,
        COUNT(DISTINCT CustomerID) AS CohortSize
    FROM FirstPurchaseCohort
    GROUP BY CohortYear, CohortMonth
),
CohortAnalysis AS (
    SELECT
        fpc.CohortYear,
        fpc.CohortMonth,
        DATEPART(YEAR, soh.OrderDate) AS OrderYear,
        DATEPART(MONTH, soh.OrderDate) AS OrderMonth,
        COUNT(DISTINCT soh.CustomerID) AS ActiveCustomers,
        COUNT(DISTINCT rc.CustomerID) AS ReturnCustomers  -- Count only return customers
    FROM FirstPurchaseCohort fpc
    JOIN Sales.SalesOrderHeader soh
        ON fpc.CustomerID = soh.CustomerID
    LEFT JOIN ReturnCustomers rc
        ON soh.CustomerID = rc.CustomerID
        AND DATEPART(YEAR, soh.OrderDate) = rc.OrderYear
        AND DATEPART(MONTH, soh.OrderDate) = rc.OrderMonth
    GROUP BY fpc.CohortYear, fpc.CohortMonth, DATEPART(YEAR, soh.OrderDate), DATEPART(MONTH, soh.OrderDate)
)
SELECT
    ca.CohortYear,
    ca.CohortMonth,
    ca.OrderYear,
    ca.OrderMonth,
    ca.ActiveCustomers,
    ca.ReturnCustomers,  -- Show return customers
    cs.CohortSize,
    ROUND(ca.ReturnCustomers * 1.0 / cs.CohortSize, 2) AS RetentionRate  -- Round retention rate to 2 decimal places
FROM CohortAnalysis ca
JOIN CohortSizes cs
    ON ca.CohortYear = cs.CohortYear AND ca.CohortMonth = cs.CohortMonth
ORDER BY ca.CohortYear, ca.CohortMonth, ca.OrderYear, ca.OrderMonth;
```
5. pivot retention (just in case we need)
```sql
WITH FirstPurchaseCohort AS (
    SELECT
        CustomerID,
        MIN(DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1)) AS CohortDate
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
),
CustomerOrders AS (
    SELECT
        fpc.CustomerID,
        fpc.CohortDate,
        DATEFROMPARTS(YEAR(soh.OrderDate), MONTH(soh.OrderDate), 1) AS OrderMonthDate,
        DATEDIFF(MONTH, fpc.CohortDate, soh.OrderDate) AS CohortIndex
    FROM FirstPurchaseCohort fpc
    JOIN Sales.SalesOrderHeader soh
        ON fpc.CustomerID = soh.CustomerID
),
CohortSizes AS (
    SELECT
        CohortDate,
        COUNT(DISTINCT CustomerID) AS CohortSize
    FROM FirstPurchaseCohort
    GROUP BY CohortDate
),
RetentionAnalysis AS (
    SELECT
        co.CohortDate,
        co.CohortIndex,
        COUNT(DISTINCT co.CustomerID) AS RetainedCustomers
    FROM CustomerOrders co
    GROUP BY co.CohortDate, co.CohortIndex
)
SELECT 
    ra.CohortDate,
    cs.CohortSize,
    ra.CohortIndex,
    ra.RetainedCustomers,
    ROUND(ra.RetainedCustomers * 1.0 / cs.CohortSize, 2) AS RetentionRate
FROM RetentionAnalysis ra
JOIN CohortSizes cs 
    ON ra.CohortDate = cs.CohortDate
ORDER BY ra.CohortDate, ra.CohortIndex;

```
6. 



