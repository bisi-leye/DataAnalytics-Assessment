-- Calculate the average number of transactions per customer per month and categorize them

-- Getting each customer's first and last transaction dates
WITH 
customer_periods AS (
    SELECT 
        owner_id,
        MIN(transaction_date) AS first_transaction,
        MAX(transaction_date) AS last_transaction,
        COUNT(*) AS total_transactions
    FROM savings_savingsaccount
    GROUP BY owner_id
),

-- Calculating transactions per month for each customer
customer_frequency AS (
    SELECT 
        cp.owner_id,
        cp.total_transactions,
        -- Calculating months between first and last transaction (added 1 to include partial months)
        GREATEST(1, TIMESTAMPDIFF(MONTH, cp.first_transaction, cp.last_transaction) + 1) AS active_months,
        -- Calculating average transactions per month
        cp.total_transactions / GREATEST(1, TIMESTAMPDIFF(MONTH, cp.first_transaction, cp.last_transaction) + 1) AS avg_transactions_per_month,
        -- Categorizing based on frequency
        CASE 
            WHEN cp.total_transactions / GREATEST(1, TIMESTAMPDIFF(MONTH, cp.first_transaction, cp.last_transaction) + 1) >= 10
				THEN 'High Frequency'
            WHEN cp.total_transactions / GREATEST(1, TIMESTAMPDIFF(MONTH, cp.first_transaction, cp.last_transaction) + 1) >= 3
				THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM customer_periods AS cp
)

-- Grouped and aggregateed by frequency category
SELECT 
    cf.frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(cf.avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM customer_frequency AS cf
GROUP BY cf.frequency_category
ORDER BY 
    CASE 
        WHEN cf.frequency_category = 'High Frequency' THEN 1
        WHEN cf.frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;