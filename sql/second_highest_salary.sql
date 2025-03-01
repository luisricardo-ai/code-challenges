-- # =================================================================
-- # 176. Second Highest Salary
-- # Diff: easy
-- # link: https://leetcode.com/problems/fix-names-in-a-table
-- # =================================================================

/*
    Table: Employee
    +-------------+------+
    | Column Name | Type |
    +-------------+------+
    | id          | int  |
    | salary      | int  |
    +-------------+------+
    id is the primary key (column with unique values) for this table.
    Each row of this table contains information about the salary of an employee.
    
    Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).
    The result format is in the following example.

    Example 1:
    Input: 
    Employee table:
    +----+--------+
    | id | salary |
    +----+--------+
    | 1  | 100    |
    | 2  | 200    |
    | 3  | 300    |
    +----+--------+

    Output: 
    +---------------------+
    | SecondHighestSalary |
    +---------------------+
    | 200                 |
    +---------------------+

    Example 2:
    Input: 
    Employee table:
    +----+--------+
    | id | salary |
    +----+--------+
    | 1  | 100    |
    +----+--------+

    Output: 
    +---------------------+
    | SecondHighestSalary |
    +---------------------+
    | null                |
    +---------------------+
*/

WITH cte AS (
    SELECT salary ,RANK() OVER(ORDER BY salary DESC) AS h 
    FROM employee
    GROUP BY salary
) SELECT
    SUM(salary) AS SecondHighestSalary 
FROM cte
WHERE
    h = 2;