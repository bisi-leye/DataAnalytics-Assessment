-- Find customers with at least one funded savings plan AND one funded investment plan

-- Identifying customers with funded savings plans (is_regular_savings = 1)
WITH 
savings_customers AS (
    SELECT 
        pp.owner_id,
        COUNT(DISTINCT pp.id) AS savings_count,
        SUM(ss.confirmed_amount) / 100 AS savings_deposits -- (Convert Kobo to Naira)
    FROM plans_plan AS pp
    JOIN savings_savingsaccount AS ss
        ON pp.id = ss.plan_id
    WHERE pp.is_regular_savings = 1 AND ss.confirmed_amount > 0
    GROUP BY pp.owner_id
    HAVING COUNT(DISTINCT pp.id) >= 1
),

-- Identify customers with funded investment plans (is_a_fund = 1)
investment_customers AS (
    SELECT 
        pp.owner_id,
        COUNT(DISTINCT pp.id) AS investment_count,
        SUM(ss.confirmed_amount) / 100 AS investment_deposits -- (Convert kobo to Naira)
    FROM plans_plan AS pp
    JOIN savings_savingsaccount AS ss
		ON pp.id = ss.plan_id
    WHERE pp.is_a_fund = 1 AND ss.confirmed_amount > 0
    GROUP BY pp.owner_id
    HAVING COUNT(DISTINCT pp.id) >= 1
)

-- Join the two customer sets to find those with both product types
SELECT 
    sc.owner_id,
    uc.name,
    sc.savings_count,
    ic.investment_count,
    (sc.savings_deposits + ic.investment_deposits) AS total_deposits
FROM savings_customers AS sc
JOIN investment_customers AS ic
	ON sc.owner_id = ic.owner_id
JOIN users_customuser AS uc
	ON sc.owner_id = uc.id
ORDER BY total_deposits DESC;