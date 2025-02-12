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
