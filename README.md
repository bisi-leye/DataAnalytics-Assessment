## Assessment Overview
This repository contains my solutions to Cowrywise Data Analytics Assessment, focusing on SQL queries that address specific business scenarios within a fintech platform.
The assessment involved analyzing user savings patterns, transaction behaviours, account activity, and customer lifetime value across multiple database tables.

##PER-QUESTION EXPLANATION

## Question 1: High-Value Customers with Multiple Products

### Business Scenario
Identifying customers with both savings and investment plans to target cross-selling opportunities.

### Approach
I utilized Common Table Expressions (CTEs) to separately identify customers with funded savings plans and investment plans before joining these sets. This modular approach improves readability while enabling efficient analysis of cross-product adoption.

### Key Techniques
- Common Table Expressions (CTEs)
- Aggregation with GROUP BY
- Inner joins to find overlapping customer sets
- Conversion of kobo to Naira

### Business Value
This query enables marketing teams to identify high-value customers already familiar with multiple product offerings, creating opportunities for targeted upselling of premium features or new products.

## Question 2: Transaction Frequency Analysis

### Business Scenario
The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).

### Approach
I created a multi-step analysis that first establishes each customer's active period, then calculates their transaction frequency per month, and finally categorizes them based on specified thresholds. Using CTEs provided a clear progression from raw data to actionable segments.

### Key Techniques
- Time-based analytics with TIMESTAMPDIFF
- Sophisticated customer segmentation using CASE statements
- Handling of edge cases like customers with very short tenures using GREATEST function
- Advanced aggregation to calculate average metrics per segment

### Business Value
This segmentation enables targeted customer engagement strategies - from retention campaigns for low-frequency users to premium offerings for high-frequency customers. It also provides a foundation for monitoring engagement trends over time.

## Question 3: Account Inactivity Alert

### Business Scenario
The ops team wants to flag accounts with no inflow transactions for over one year.

### Approach
I identified accounts with extended periods of inactivity by using a two-step process that first determines the last transaction date for each plan, then identifies plans where this date exceeds the one-year threshold. The solution distinguishes between different plan types for contextual analysis.

### Key Techniques
- Common Table Expressions to establish baseline activity dates
- Date difference calculations with DATEDIFF
- Filtering inactive but still active accounts
- Plan type categorization for segmented analysis

### Business Value
This solution helps the operations team prioritize at-risk accounts for intervention, potentially preventing customer churn while maintaining regulatory compliance regarding dormant accounts. The inactivity_days metric allows for tiered intervention strategies based on severity.

## Question 4: Customer Lifetime Value Estimation

### Business Scenario
Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model)

### Approach
I implemented the CLV calculation by first establishing key customer metrics (tenure, transaction count, average transaction value), then applying the specified formula with appropriate currency conversions. The analysis accounts for each customer's historical activity to project their future value.

### Key Techniques
- Tenure calculation using TIMESTAMPDIFF
- Complex formula implementation with multiple operations
- Currency conversion from kobo to standard units
- Profit margin calculations incorporated into the analysis
- Strategic sorting to highlight highest-value customers

### Business Value
This CLV analysis provides marketing with a data-driven approach to customer segmentation, allowing for optimized budget allocation, targeted retention efforts for high-value customers, and more accurate calculation of customer acquisition cost thresholds.

## Challenges Encountered and Solutions

### Data Scale Considerations
Working with potentially large financial transaction datasets required careful optimization of joins and aggregations. I addressed this by:
- Using specific filtering before joins where possible
- Leveraging CTEs to create efficient intermediate result sets
- Carefully selecting only necessary columns

### Currency Conversion
The database stores monetary values in kobo. I implemented consistent conversion to ensure all financial metrics are presented in the standard currency unit (Naira).

### Date and Time Calculations
Calculating metrics like tenure and transaction frequency required precise handling of date differences. I used DATEDIFF and TIMESTAMPDIFF functions to ensure accurate calculations across different time periods.


## Conclusion

These queries demonstrate both my SQL proficiency and business analytics capabilities by transforming raw financial data into actionable business insights. Each solution was optimized for performance while maintaining readability and addressing the specific business requirements.

The analyses provide various stakeholders (marketing, finance, operations) with valuable customer insights that can drive business decisions, improve customer retention, and identify growth opportunities.
