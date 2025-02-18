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

## Recommendation

### Retention Recommendations:
- Leverage Repeat Purchases: Implement loyalty programs and exclusive deals for frequent buyers to boost retention.
- Optimize Marketing for New Cohorts: Focus on onboarding and nurturing new customers with personalized offers and post-purchase follow-ups.
- Address Declining Retention: Use predictive churn models and personalized engagement to prevent further decline.
- Seasonal Retention Strategies: Create seasonal campaigns for customers acquired in later months to maintain engagement.
- Maximize Engagement in Months 5-7: Align promotions with peak engagement months to boost retention and upsell opportunities.
- Investigate Post-2013 Cohorts: Analyze changes after 2013 to understand regular return patterns and replicate them.
- Manage Low Engagement Cohorts: Use win-back campaigns and product diversification to re-engage low-retention cohorts.
- Utilize Seasonality: Capitalize on higher return rates during May-August with seasonal promotions and targeted products.
- Enhance Retention in Larger Cohorts: Segment larger cohorts and apply targeted retention strategies for high-value customers.

### CLV Recommendations:
- Analyze Spending Spikes: Replicate successful strategies behind spending spikes during peak months.
- Focus on Retention: Strengthen retention efforts for cohorts showing signs of churn to maintain CLV.
- Investigate Data Gaps: Clarify data gaps to improve CLV predictions.
- Tailor Acquisition Strategies: Adjust acquisition strategies based on cohort behavior and preferences.
- Nurture Early-Stage Customers: Engage new customers early to reduce churn and maximize CLV.
- Leverage Promotions: Align campaigns with seasonal trends and high-revenue periods.
- Expand Post-2013 Cohorts: Maintain engagement strategies to sustain revenue from newer cohorts.
- Address Churn in Older Cohorts: Analyze churn causes for older cohorts and adjust strategies to prevent loss.

## Contact

📧 Email: pearriperri@gmail.com

🔗 [LinkedIn](https://www.linkedin.com/in/phan-chenh-6a7ba127a/) | Portfolio
