--====cohort analysis

-- objective of this project? Analyze customer retention, Customer Lifetime Value (CLV), churn patterns, and cohort behavior.

--------
-- Analyze customer retention Rate
-- 1. Identify the Cohort for Each Customer
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


--2. Combine Cohort Data with Orders
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


-- 3. Count Active Customers per Cohort Over Time
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

-- 4. Calculate Retention Rates
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


--=====pivot retention
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



--=======================
-- Analyze Customer Lifetime Value (CLV)
-- 1. Identify the Cohort for Each Customer
WITH FirstPurchaseCohort AS (
    SELECT
        CustomerID,
        DATEPART(YEAR, MIN(OrderDate)) AS CohortYear, -- Get the Year of the first purchase
        DATEPART(MONTH, MIN(OrderDate)) AS CohortMonth -- Get the Month of the first purchase
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
),

-- 2. Combine Cohort Data with Orders and Calculate Revenue
CustomerOrders AS (
    SELECT
        fpc.CustomerID,
        fpc.CohortYear,
        fpc.CohortMonth,
        DATEPART(YEAR, soh.OrderDate) AS OrderYear,
        DATEPART(MONTH, soh.OrderDate) AS OrderMonth,
        DATEDIFF(MONTH, 
            DATEFROMPARTS(fpc.CohortYear, fpc.CohortMonth, 1), 
            DATEFROMPARTS(DATEPART(YEAR, soh.OrderDate), DATEPART(MONTH, soh.OrderDate), 1)
        ) AS MonthsSinceFirstPurchase,
        soh.TotalDue AS Revenue
    FROM FirstPurchaseCohort fpc
    JOIN Sales.SalesOrderHeader soh
        ON fpc.CustomerID = soh.CustomerID
),

-- 3. Aggregate Revenue by Cohort and Month
CohortRevenue AS (
    SELECT
        CohortYear,
        CohortMonth,
        MonthsSinceFirstPurchase,
        SUM(Revenue) AS TotalRevenue
    FROM CustomerOrders
    GROUP BY CohortYear, CohortMonth, MonthsSinceFirstPurchase
),

-- 4. Calculate Cumulative Revenue (CLV) for Each Cohort
CohortCLV AS (
    SELECT
        CohortYear,
        CohortMonth,
        MonthsSinceFirstPurchase,
        TotalRevenue,
        SUM(TotalRevenue) OVER (
            PARTITION BY CohortYear, CohortMonth
            ORDER BY MonthsSinceFirstPurchase
        ) AS CumulativeRevenue
    FROM CohortRevenue
)

-- 5. Output the CLV Analysis
SELECT
    CohortYear,
    CohortMonth,
    MonthsSinceFirstPurchase,
    TotalRevenue AS MonthlyRevenue,
    CumulativeRevenue AS LifetimeValue
FROM CohortCLV
ORDER BY CohortYear, CohortMonth, MonthsSinceFirstPurchase;


--=> The MonthsSinceFirstPurchase = 5 means that the customer made their first purchase in January and now, five months later, we’re looking at their purchase in June 2011.

/*
Explain Columns:
cohortyear: The year when the cohort made their first purchase. In this case, it’s 2011.
cohortmonth: The month when the cohort made their first purchase. Here, it’s January 2011.
monthssincefirstpurchase: This shows how many months have passed since the customer's first purchase in the cohort. For example, 5 means five months after the first purchase in January.
monthlyrevenue: This is the revenue generated in the given month (since the first purchase) for customers in this cohort. It’s the total revenue of all customers from that cohort who made purchases in that month.
lifetimevalue: This is the cumulative revenue generated from this cohort up to and including the current month. It’s the sum of monthlyrevenue up until the current month.
*/


--=========================
-- code to sort Top cohorts by highest CLV
-- 1. Identify the Cohort for Each Customer
WITH FirstPurchaseCohort AS (
    SELECT
        CustomerID,
        DATEPART(YEAR, MIN(OrderDate)) AS CohortYear, -- Get the Year of the first purchase
        DATEPART(MONTH, MIN(OrderDate)) AS CohortMonth -- Get the Month of the first purchase
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
),

-- 2. Combine Cohort Data with Orders and Calculate Revenue
CustomerOrders AS (
    SELECT
        fpc.CustomerID,
        fpc.CohortYear,
        fpc.CohortMonth,
        DATEPART(YEAR, soh.OrderDate) AS OrderYear,
        DATEPART(MONTH, soh.OrderDate) AS OrderMonth,
        DATEDIFF(MONTH, 
            DATEFROMPARTS(fpc.CohortYear, fpc.CohortMonth, 1), 
            DATEFROMPARTS(DATEPART(YEAR, soh.OrderDate), DATEPART(MONTH, soh.OrderDate), 1)
        ) AS MonthsSinceFirstPurchase,
        soh.TotalDue AS Revenue
    FROM FirstPurchaseCohort fpc
    JOIN Sales.SalesOrderHeader soh
        ON fpc.CustomerID = soh.CustomerID
),

-- 3. Aggregate Revenue by Cohort and Month
CohortRevenue AS (
    SELECT
        CohortYear,
        CohortMonth,
        MonthsSinceFirstPurchase,
        SUM(Revenue) AS TotalRevenue
    FROM CustomerOrders
    GROUP BY CohortYear, CohortMonth, MonthsSinceFirstPurchase
),

-- 4. Calculate Cumulative Revenue (CLV) for Each Cohort
CohortCLV AS (
    SELECT
        CohortYear,
        CohortMonth,
        MonthsSinceFirstPurchase,
        TotalRevenue,
        SUM(TotalRevenue) OVER (
            PARTITION BY CohortYear, CohortMonth
            ORDER BY MonthsSinceFirstPurchase
        ) AS CumulativeRevenue
    FROM CohortRevenue
)

-- 5. Output the CLV Analysis and Cohort Comparison
SELECT
    CohortYear,
    CohortMonth,
    SUM(TotalRevenue) AS TotalRevenue,
    MAX(CumulativeRevenue) AS MaxCLV
FROM CohortCLV
GROUP BY CohortYear, CohortMonth
ORDER BY MaxCLV DESC;  -- Top cohorts by highest CLV


