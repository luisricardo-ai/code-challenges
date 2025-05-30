-- # =================================================================
-- # 1179. Reformat Department Table
-- # Diff: medium
-- # link: https://leetcode.com/problems/reformat-department-table/description/
-- # =================================================================

SELECT id, 
	SUM(CASE WHEN MONTH = 'jan' THEN REVENUE ELSE NULL END) AS Jan_Revenue,
	SUM(CASE WHEN MONTH = 'feb' THEN REVENUE ELSE NULL END) AS Feb_Revenue,
	SUM(CASE WHEN MONTH = 'mar' THEN REVENUE ELSE NULL END) AS Mar_Revenue,
	SUM(CASE WHEN MONTH = 'apr' THEN REVENUE ELSE NULL END) AS Apr_Revenue,
	SUM(CASE WHEN MONTH = 'may' THEN REVENUE ELSE NULL END) AS May_Revenue,
	SUM(CASE WHEN MONTH = 'jun' THEN REVENUE ELSE NULL END) AS Jun_Revenue,
	SUM(CASE WHEN MONTH = 'jul' THEN REVENUE ELSE NULL END) AS Jul_Revenue,
	SUM(CASE WHEN MONTH = 'aug' THEN REVENUE ELSE NULL END) AS Aug_Revenue,
	SUM(CASE WHEN MONTH = 'sep' THEN REVENUE ELSE NULL END) AS Sep_Revenue,
	SUM(CASE WHEN MONTH = 'oct' THEN REVENUE ELSE NULL END) AS Oct_Revenue,
	SUM(CASE WHEN MONTH = 'nov' THEN REVENUE ELSE NULL END) AS Nov_Revenue,
	SUM(CASE WHEN MONTH = 'dec' THEN REVENUE ELSE NULL END) AS Dec_Revenue
FROM DEPARTMENT
GROUP BY id
ORDER BY id;