-- Find all active accounts with no transactions in the last 1 year (365 days)

-- Getting the latest transaction date for each plan
WITH 
latest_transactions AS (
    SELECT 
        plan_id,
        MAX(transaction_date) AS last_transaction_date
    FROM savings_savingsaccount
    GROUP BY plan_id
)
-- Finding plans with no recent activity
SELECT 
    pp.id AS plan_id,
    pp.owner_id,
    CASE 
        WHEN pp.is_regular_savings = 1 THEN 'Savings'
        WHEN pp.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    lt.last_transaction_date,
    DATEDIFF(CURRENT_DATE(), lt.last_transaction_date) AS inactivity_days
FROM plans_plan AS pp
JOIN latest_transactions AS lt
	ON pp.id = lt.plan_id
WHERE 
    -- selecting active plans only
    pp.is_deleted = 0 AND pp.is_archived = 0  -- Active plans
    -- where there are no transactions in the last 365 days
    AND DATEDIFF(CURRENT_DATE(), lt.last_transaction_date) > 365
ORDER BY 
    inactivity_days DESC;