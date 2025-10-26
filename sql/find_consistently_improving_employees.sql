-- # =================================================================
-- # 3580. Find Consistently Improving Employees
-- # Diff: medium
-- # link: https://leetcode.com/problems/find-consistently-improving-employees/description
-- # =================================================================

-- My logic: https://leetcode.com/problems/find-consistently-improving-employees/solutions/7302979/easy-window-function-logic-by-luisricard-ndbv

/*
    Table: employees
    +-------------+---------+
    | Column Name | Type    |
    +-------------+---------+
    | employee_id | int     |
    | name        | varchar |
    +-------------+---------+
    employee_id is the unique identifier for this table.
    Each row contains information about an employee.

    Table: performance_reviews
    +-------------+------+
    | Column Name | Type |
    +-------------+------+
    | review_id   | int  |
    | employee_id | int  |
    | review_date | date |
    | rating      | int  |
    +-------------+------+
    review_id is the unique identifier for this table.

    Each row represents a performance review for an employee. The rating is on a scale of 1-5 where 5 is excellent and 1 is poor.

    Write a solution to find employees who have consistently improved their performance over their last three reviews.
        An employee must have at least 3 review to be considered
        The employee's last 3 reviews must show strictly increasing ratings (each review better than the previous)
        Use the most recent 3 reviews based on review_date for each employee
        Calculate the improvement score as the difference between the latest rating and the earliest rating among the last 3 reviews

    Return the result table ordered by improvement score in descending order, then by name in ascending order.

    The result format is in the following example.
*/

WITH cte_employee_historic_reviews AS (
    SELECT 
        employee_id, 
        COUNT(review_id) OVER(PARTITION BY employee_id) AS total_reviews,
        ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS review_freshness,
        rating,
        LAG(rating, 1) OVER(PARTITION BY employee_id ORDER BY review_date ASC) AS rating_1_before,
        LAG(rating, 2) OVER(PARTITION BY employee_id ORDER BY review_date ASC) AS rating_2_before
    FROM performance_reviews
) SELECT 
    ehr.employee_id,
    e.name,
    ehr.rating - ehr.rating_2_before AS improvement_score
FROM cte_employee_historic_reviews AS ehr
LEFT JOIN employees AS e
    ON ehr.employee_id = e.employee_id
WHERE
    ehr.total_reviews >= 3
    AND ehr.review_freshness = 1
    AND ehr.rating > ehr.rating_1_before
    AND ehr.rating_1_before > ehr.rating_2_before
ORDER BY 
    improvement_score DESC, 
    e.name ASC;