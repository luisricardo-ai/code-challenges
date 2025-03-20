# =================================================================
# 184. Department Highest Salary
# Diff: medium
# link: https://leetcode.com/problems/second-highest-salary
# =================================================================

"""
    Table: Employee
    +--------------+---------+
    | Column Name  | Type    |
    +--------------+---------+
    | id           | int     |
    | name         | varchar |
    | salary       | int     |
    | departmentId | int     |
    +--------------+---------+
    id is the primary key (column with unique values) for this table.
    departmentId is a foreign key (reference columns) of the ID from the Department table.
    Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.

    Table: Department
    +-------------+---------+
    | Column Name | Type    |
    +-------------+---------+
    | id          | int     |
    | name        | varchar |
    +-------------+---------+
    id is the primary key (column with unique values) for this table. It is guaranteed that department name is not NULL.
    Each row of this table indicates the ID of a department and its name.
    
    Write a solution to find employees who have the highest salary in each of the departments.
    Return the result table in any order.

    The result format is in the following example.

    Example 1:
    Input: 
    Employee table:
    +----+-------+--------+--------------+
    | id | name  | salary | departmentId |
    +----+-------+--------+--------------+
    | 1  | Joe   | 70000  | 1            |
    | 2  | Jim   | 90000  | 1            |
    | 3  | Henry | 80000  | 2            |
    | 4  | Sam   | 60000  | 2            |
    | 5  | Max   | 90000  | 1            |
    +----+-------+--------+--------------+

    Department table:
    +----+-------+
    | id | name  |
    +----+-------+
    | 1  | IT    |
    | 2  | Sales |
    +----+-------+

    Output: 
    +------------+----------+--------+
    | Department | Employee | Salary |
    +------------+----------+--------+
    | IT         | Jim      | 90000  |
    | Sales      | Henry    | 80000  |
    | IT         | Max      | 90000  |
    +------------+----------+--------+
    Explanation: Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.
"""

import pandas as pd

def department_highest_salary(employee: pd.DataFrame, department: pd.DataFrame) -> pd.DataFrame:
    columns = ["Department", "Employee", "Salary"]
    result_df = pd.DataFrame(columns=columns)

    if employee.empty == False or department.empty == False:
        merged_df = employee.merge(
            department,
            left_on="departmentId",
            right_on="id",
            suffixes=('_employee', '_department')
        )

        highest_salaries = merged_df.loc[
            merged_df.groupby("departmentId")["salary"].transform("max") == merged_df["salary"]
        ]

        result_df = highest_salaries[
            ["name_department", "name_employee", "salary"]
        ]
        result_df.columns = columns

    return result_df

def department_highest_salary(employee: pd.DataFrame, department: pd.DataFrame) -> pd.DataFrame:
    columns = ["Department", "Employee", "Salary"]
    result_df = pd.DataFrame(columns=columns)

    if employee.empty == False or department.empty == False:
        df = employee.merge(
            department,
            left_on="departmentId",
            right_on="id",
            suffixes=('_employee', '_department')
        )

        highest_salaries = df.groupby("departmentId").apply(lambda row: row[row["salary"] == row["salary"].max()]).reset_index(drop=True)

        result_df = highest_salaries[["name_department", "name_employee", "salary"]]        
        result_df.columns = columns

    return result_df