-- # =================================================================
-- # 1393. Capital Gain/Loss
-- # Diff: medium
-- # link: https://leetcode.com/problems/capital-gainloss/description/
-- # =================================================================

SELECT 
    stock_name,
    SUM(
        CASE 
            WHEN operation = 'buy' THEN -price
            WHEN operation = 'sell' THEN price
        END
    ) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;