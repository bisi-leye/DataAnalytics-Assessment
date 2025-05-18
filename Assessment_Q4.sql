-- Calculate Customer Lifetime Value (CLV) based on account tenure and transaction volume

-- Calculating metrics per customer
WITH 
customer_metrics AS (
    SELECT 
        uc.id AS customer_id,
        uc.name,
        -- Calculating tenure in months since signup
        TIMESTAMPDIFF(MONTH, uc.date_joined, CURRENT_DATE()) AS tenure_months,
        -- Counting total transactions
        COUNT(ss.id) AS total_transactions,
        -- Calculating average profit per transaction (0.1% of transaction value)
        AVG(ss.confirmed_amount) * 0.001 / 100 AS avg_profit_per_transaction -- Convert from kobo to naira and calculate 0.1%
    FROM users_customuser AS uc
    LEFT JOIN savings_savingsaccount AS ss
		ON uc.id = ss.owner_id
    WHERE ss.confirmed_amount > 0  -- counting only positive transactions
    GROUP BY uc.id, uc.name, uc.date_joined
)

-- Calculating estimated CLV using the formula provided
SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    -- CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction
    ROUND((total_transactions / tenure_months) * 12 * avg_profit_per_transaction, 2) AS estimated_clv
FROM customer_metrics
WHERE tenure_months > 0  -- avoided division by zero
ORDER BY estimated_clv DESC;