-- # =================================================================
-- # 3564. Seasonal Sales Analysis
-- # Diff: medium
-- # link: https://leetcode.com/problems/seasonal-sales-analysis/description/
-- # =================================================================

WITH cte_season_sales AS (
    SELECT
        CASE
            WHEN EXTRACT(MONTH FROM s.sale_date) IN (12,1,2) THEN 'Winter'
            WHEN EXTRACT(MONTH FROM s.sale_date) IN (3,4,5) THEN 'Spring'
            WHEN EXTRACT(MONTH FROM s.sale_date) IN (6,7,8) THEN 'Summer'
            WHEN EXTRACT(MONTH FROM s.sale_date) IN (9,10,11) THEN 'Fall'
        END AS season
        ,p.category
        ,SUM(s.quantity) AS total_quantity
        ,SUM(s.quantity * price) AS total_revenue
    FROM sales AS s
    INNER JOIN products AS p
        ON s.product_id = p.product_id
    GROUP BY season, p.category
), cte_season_sales_rank AS ( 
    SELECT 
        *, RANK() OVER(PARTITION BY season ORDER BY total_quantity DESC, total_revenue DESC) AS season_sale_rank
    FROM cte_season_sales
) SELECT 
    season, category, total_quantity, total_revenue
FROM cte_season_sales_rank
WHERE season_sale_rank = 1;