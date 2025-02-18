# Project Title: Customer Retention and Lifetime Value Analysis Using Cohort Analysis on AdventureWorks Dataset (2011-2014)

## Table of Contents
- [Overview](#overview)
- [Dataset](#dataset)
- [Objective](#objective)
- [Analysis Approach](#analysis-approach)
- [Key Findings](#key-findings)
- [How to Use](#how-to-use)
- [Technologies Used](#technologies-used)
- [Results & Visualizations](#results--visualizations)
- [Recommendation](#recommendation)
- [Contact](#contact)

## Overview

This project aims to analyze customer retention, loyalty, and lifetime value (CLV) through cohort analysis using the AdventureWorks2022 dataset. Cohort analysis is utilized to track the behavior of customer groups over time, helping businesses understand retention trends, identify churn patterns, and predict future revenue from various customer segments.

## Dataset

The analysis is based on the AdventureWorks2022, obtained from Microsoft Learn:

🔗 AdventureWorks sample Databases
- Source: [Microsoft Learn](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak)
- Time Period Covered: 2011-2014

This dataset contains transactional data from AdventureWorks, a fictional retail company, including sales, products, and customer orders.

## Objective

This project aims to analyze customer retention trends and identify churn patterns to better understand customer behavior over time. Additionally, it will measure and predict Customer Lifetime Value (CLV) to assess the long-term revenue potential of different customer segments. The project will also segment customer cohorts based on their purchasing behavior to uncover meaningful trends and patterns. It will evaluate the impact of promotions and seasonal trends on retention rates and, ultimately, provide actionable insights and recommendations to improve customer loyalty, optimize marketing strategies, and enhance overall business performance.

## Analysis Approach
1. Data Preparation:
- Extract fields such as CustomerID, OrderDate, and TotalDue.
- Convert OrderDate into cohort-based timeframes (Year/Month).
2. Cohort Identification:
- Assign each customer to a cohort based on their first purchase date.
- Track cohort behavior over time.
3. Customer Retention Analysis:
- Measure how many customers return in each subsequent month.
- Calculate retention rates per cohort and visualize trends.
4. Customer Lifetime Value (CLV) Analysis:
- Analyze revenue per cohort and calculate cumulative revenue over time.
- Identify high-value cohorts that contribute the most revenue.
5. Churn & Loyalty Analysis:
- Segment customers into one-time buyers, occasional buyers, and loyal customers.
- Compare the revenue contributions of loyal vs. churned customers.
6. Cohort Behavior Segmentation:
- Examine purchase frequency, seasonal trends, and the effect of promotions.
7. Interpret Results:
- Analyze trends, retention, and CLV to understand customer behavior and identify key factors.
8. Recommendations:
- Improve retention with loyalty programs.
- Focus marketing on new cohorts and seasonal trends.
- Re-engage at-risk customers to reduce churn.

## Key Findings
- Repeat Purchases: Strong correlation between repeat customers and retention rates.
- Retention Decline: Retention tends to decline over time, suggesting the need for proactive retention strategies.
- Seasonal Trends: Higher retention observed in certain months (May to August), indicating the importance of seasonality in engagement.
- Cohort Performance: Larger cohorts generally show lower retention rates, suggesting that segmenting cohorts could improve engagement.

## How to use
1. Restore database in SSMS as guided in Mirosoft Learn [Restore to SQL Server](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms)
2. Using SQL Server Management Studio (SSMS) to execute SQL queries
3. Run the analysis notebooks in Jupyter.

## Technologies Used
- SQL code: SQL queries were executed to extract insights from the dataset, focusing on customer cohorts, retention rates, purchasing behavior, and revenue trends. Queries specifically targeted cohort identification, retention analysis, and revenue generation by customer segments.
- Python code: Extracted SQL data was saved as CSV and analyzed in Jupyter Notebook using Python. Key libraries used include Pandas for data manipulation, and Seaborn and Matplotlib for data visualization.

## Results & Visualizations

### Retention Rate Analysis

![image](https://github.com/user-attachments/assets/faaa4c18-5dd6-4e8e-9fe6-83b560be3567)
Figure 1: Retention Heatmap

Findings:
- Return Customers & Retention Rate (+0.49, Medium Positive Correlation)
- Order Year & Retention Rate (-0.12, Moderate Negative Correlation)
- Cohort Month & Retention Rate (-0.09, Slight Negative Correlation)
- Cohort Size & Retention Rate (-0.27, Weak Negative Correlation)
- Active Customers & Retention Rate (-0.10, Slight Negative Correlation)

![image](https://github.com/user-attachments/assets/753088f5-9f01-41a6-829b-a58ecfb2207e)
Figure 2: Cohort Analysis - Active Customer with cohort size

![image](https://github.com/user-attachments/assets/f4313dbe-c2fe-4eed-899e-34a9caa8add6)
Figure 3: Cohort Analysis - Return Customer

![image](https://github.com/user-attachments/assets/7ef07715-c959-4635-8566-9672a3e57c14)
Figure 4: Cohort Analysis - Retention Rates

Findings of the plots above: 
- There was a significant increase in the number of first-time buyers after July 2013.
- Before 2013-06: Customers typically returned after 2 months from their first and next purchase.
- After 2013-06: Customers returned more regularly across all cohorts.
- Cohorts from May to August Show Higher Return Rates
- Cohorts from 2011-05 to 2013-05 Stopped Purchasing by 2014-06
- Higher Retention Rates for Cohorts in Months 5-7

### Customers Lifetime Value Analysis

![image](https://github.com/user-attachments/assets/8af31296-3324-4330-9145-98aae5bae4c6)
Figure 5: Monthly Revenue by cohort over time

Findings:
- Spending spikes in months like 2011-07, 2012-04, and 2013-12 suggest promotional, seasonal, or product influences.
- Many cohorts show declining spend over time, indicating potential churn after 1-2 years.
- Spending varies by cohort, suggesting the need for tailored acquisition strategies.
- Early-stage cohorts generate significant revenue but need strategies to foster repeat purchases.

![image](https://github.com/user-attachments/assets/a1e2e8c1-5329-4f06-85a1-1ab63e77b12a)

Figure 6: Cumulative Lifetime Value by cohort

Findings: 
- Revenue spiked from July 2013, indicating strong engagement.
- Pre-2013 cohorts showed slower growth.
- Post-2013 cohorts had sustained revenue, with May-Aug performing well seasonally.
- There is a higher revenue in May-Aug might due to seasonal demand.
- Older cohorts (2011-2013) stopped purchasing after June 2014, indicating churn.



-----------------
## Project Overview:

Dataset: AdventureWorks2022.bak (https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms)

Cohort analysis is a technique used to track and analyze the behavior of groups of users (cohorts) over time. A cohort is a group of people who share a common characteristic within a specific time frame, such as their first purchase date, sign-up date, or first interaction with a company.

In business intelligence, cohort analysis helps understand customer retention, lifetime value, and purchase behavior trends by examining how different cohorts behave over time.

- Retention rate measures the percentage of customers who continue to do business with a company over a specified period, indicating how well a company is keeping its customers. It’s an important metric for understanding customer loyalty and the effectiveness of retention strategies.

- Customer Lifetime Value (CLV) is a predictive metric that estimates the total revenue or profit a business can expect from a customer during their entire relationship with the company. CLV helps businesses determine how much they should invest in acquiring and retaining customers.

## Objectives:

This project aims to analyze customer retention trends and identify churn patterns to understand customer behavior over time. Addition to that, measure and predict Customer Lifetime Value (CLV) to assess the long-term revenue potential of different customer segments. Additionally, the project will segment customer cohorts based on their purchasing behavior to uncover trends and patterns. It will also evaluate the impact of promotions and seasonal trends on retention rates. Finally, the project will provide actionable insights and recommendations to improve customer loyalty, optimize marketing strategies, and enhance overall business performance.

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


![image](https://github.com/user-attachments/assets/faaa4c18-5dd6-4e8e-9fe6-83b560be3567)
Figure 1: Retention Heatmap

![image](https://github.com/user-attachments/assets/753088f5-9f01-41a6-829b-a58ecfb2207e)
Figure 2: Cohort Analysis - Active Customer with cohort size

![image](https://github.com/user-attachments/assets/f4313dbe-c2fe-4eed-899e-34a9caa8add6)
Figure 3: Cohort Analysis - Return Customer

![image](https://github.com/user-attachments/assets/7ef07715-c959-4635-8566-9672a3e57c14)
Figure 4: Cohort Analysis - Retention Rates

### RECOMMENDATIONS FOR RETENTION:

1. Leverage Repeat Purchases to Improve Retention
- Recommendation: Since repeat purchases significantly contribute to retention (as shown by the positive correlation between return customers and retention rate), focus on improving loyalty programs or introducing personalized offers to encourage customers to return. 

For example:
- Implement a rewards program where customers earn points for each purchase, which can be redeemed for discounts or exclusive offers.
- Target frequent buyers with exclusive deals or early access to new products to maintain their engagement.
2. Optimize Marketing Campaigns for Newer Cohorts
- Observation: Newer cohorts tend to be larger, but they also have lower retention rates. This suggests that while your business is successfully acquiring new customers, you may struggle with retaining them over time.
- Recommendation: Focus marketing efforts on new customer onboarding to improve retention for these larger cohorts. 

Consider:
- Sending personalized welcome emails with special first-time buyer offers.
- Offering post-purchase follow-ups to enhance the initial experience and remind customers of additional products that may interest them.
- Utilizing email automation to nurture these customers into loyal, repeat buyers.
3. Address Declining Retention with Proactive Strategies
- Observation: There's a slight decline in retention over the years, possibly due to changing customer behavior or increased competition.

To combat this decline, you should consider:
- Predictive churn models: Use past customer behavior (e.g., purchase frequency, basket size) to identify customers who are at risk of churn. Send targeted retention offers to re-engage these customers before they fully disengage.
- Enhancing the customer experience through personalized recommendations, superior customer service, and more tailored communications.
- Post-purchase engagement: Use automated email sequences to re-engage customers who haven’t made a purchase in a while. Offer discounts, ask for feedback, or highlight new product arrivals to bring them back.
4. Improve Retention for Customers Acquired in Late Months
- Observation: Cohort months later in the year show slightly lower retention, possibly due to seasonal effects.
- Recommendation: For customers acquired in later months, create seasonal retention strategies that align with their purchasing habits. 

This could include:
- Targeted ads or offers that are relevant to their interests during the off-season.
- Offering seasonal promotions or exclusive end-of-year sales to incentivize purchases after their initial engagement.
- Encourage engagement with reminder emails for products they might need to restock, like seasonal items or accessories.
5. Maximize Cohort Engagement in Months 5-7
- Observation: Higher retention rates are seen in cohorts from months 5 to 7.
- Recommendation: Since retention is higher in these months, identify and replicate the drivers that contribute to stronger engagement. 

Consider:
- Timing your promotions: Ensure that promotions or new product releases are aligned with these peak engagement months to maximize their impact.
- Upselling or cross-selling: In these high-engagement months, upsell customers with complementary products or offer package deals that encourage larger orders.
6. Investigate and Enhance Engagement with Customers from Cohorts After 2013-06
- Observation: After June 2013, return customers seem to make purchases more regularly across cohorts.
- Recommendation: Investigate what changed in your customer experience or marketing strategy post-2013 to better understand why this pattern emerged.

Consider:
- Analyze changes in product offerings, pricing, or marketing approaches that could have contributed to the increased regularity of returns.
- Use these insights to enhance personalization across customer segments, making the buying experience more tailored and rewarding for customers.
7. Monitor and Manage Cohorts with Low Engagement
- Observation: Cohorts from 2011-05 to 2013-05 stopped purchasing by 2014-06, possibly due to market saturation or competitive pressures.
- Recommendation: For these groups, take proactive steps to either re-engage or gracefully disengage. 

Consider:
- Conducting win-back campaigns that offer customers incentives to return, such as discounts or bundled deals.
- Exit surveys for customers who stop purchasing to understand the root causes (pricing, competition, product dissatisfaction) and adapt your offerings.
- If market saturation is the issue, consider diversifying your product range or offering exclusive, limited-time products to reignite interest in these cohorts.
8. Utilize Seasonality to Drive Engagement
- Observation: Cohorts from May to August show higher return rates, likely due to seasonal effects or marketing efforts.

Maximize seasonal trends by:
- Running seasonal promotions targeting these months and using time-sensitive discounts to create urgency.
- Offering products that are seasonally relevant to these cohorts, such as summer or holiday-related items, to drive purchases.
- Consider launching seasonal campaigns or events in these months to build excitement and reinforce customer loyalty.
9. Improve Retention for Larger Cohorts
- Observation: Larger cohorts tend to show lower retention rates.

To address this, you might need to:
- Segment larger cohorts into smaller groups based on behavior, demographics, or product preferences and then tailor retention efforts to each group.
- Implement targeted retention strategies for high-value customers within large cohorts, such as VIP programs, early access to products, or personalized offers.

## Customers lifetime value (CLV) Analysis

```sql
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
```

Explain Columns:
- cohortyear: The year when the cohort made their first purchase. In this case, it’s 2011.
- cohortmonth: The month when the cohort made their first purchase. Here, it’s January 2011.
- monthssincefirstpurchase: This shows how many months have passed since the customer's first purchase in the cohort. For example, 5 means five months after the first purchase in January.
- monthlyrevenue: This is the revenue generated in the given month (since the first purchase) for customers in this cohort. It’s the total revenue of all customers from that cohort who made purchases in that month.
- lifetimevalue: This is the cumulative revenue generated from this cohort up to and including the current month. It’s the sum of monthlyrevenue up until the current month.

Code to sort Top cohorts by highest CLV
```sql
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
```

![image](https://github.com/user-attachments/assets/8af31296-3324-4330-9145-98aae5bae4c6)
Figure 5: Monthly Revenue by cohort over time

![image](https://github.com/user-attachments/assets/a1e2e8c1-5329-4f06-85a1-1ab63e77b12a)

Figure 6: Cumulative Lifetime Value by cohort

### RECOMMENDATIONS FOR CUSTOMER LIFETIME VALUE 

1. Analyze Spending Spikes: 
- Identify the drivers behind spending spikes in specific months (e.g., 2011-07, 2012-04, 2013-12) to replicate successful promotions or seasonal strategies during those periods.

2. Focus on Retention: 
- Address the drop in spending over time by enhancing retention strategies, especially for cohorts showing signs of churn after the first year. This could include personalized outreach or loyalty programs.

3. Investigate Data Gaps: 
- Investigate the missing values to determine whether they indicate actual customer inactivity or data reporting issues. This will improve accuracy in CLV predictions and retention analysis.

4. Tailor Acquisition Strategies: 
- Recognize that different cohorts (e.g., 2011-06 vs. 2012-06) have different behaviors. Adapt customer acquisition strategies to meet the expectations and preferences of each cohort.

5. Nurture Early-Stage Customers: 
- Target early-stage customers with engaging strategies to turn them into repeat buyers, reducing churn and maximizing CLV.

6. Leverage Promotions and External Events: 
- Use knowledge of seasonal trends and promotions (e.g., May-Aug) to plan campaigns that align with high-revenue periods and customer purchasing behavior.

7. Enhance Post-2013 Cohorts: 
- Since post-2013 cohorts show more sustained revenue, focus on expanding this trend with strategies that maintain engagement and repeat purchases.

8. Address Churn in Older Cohorts: 
- For older cohorts (e.g., 2011-2013), analyze why customers stop purchasing (e.g., shift in strategy, product issues, competition) and adjust business practices to prevent churn.
