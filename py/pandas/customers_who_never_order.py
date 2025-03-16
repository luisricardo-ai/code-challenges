# =================================================================
# 183. Customers Who Never Order
# Diff: easy
# link: https://leetcode.com/problems/customers-who-never-order
# =================================================================

"""
    Table: Customers
    +-------------+---------+
    | Column Name | Type    |
    +-------------+---------+
    | id          | int     |
    | name        | varchar |
    +-------------+---------+
    Each row of this table indicates the ID and name of a customer.
    id is the primary key (column with unique values) for this table.
    

    Table: Orders
    +-------------+------+
    | Column Name | Type |
    +-------------+------+
    | id          | int  |
    | customerId  | int  |
    +-------------+------+
    id is the primary key (column with unique values) for this table.
    customerId is a foreign key (reference columns) of the ID from the Customers table.
    Each row of this table indicates the ID of an order and the ID of the customer who ordered it.

    Write a solution to find all customers who never order anything.
    Return the result table in any order.

    The result format is in the following example.

    Example 1:
    Input: 
    Customers table:
    +----+-------+
    | id | name  |
    +----+-------+
    | 1  | Joe   |
    | 2  | Henry |
    | 3  | Sam   |
    | 4  | Max   |
    +----+-------+

    Orders table:
    +----+------------+
    | id | customerId |
    +----+------------+
    | 1  | 3          |
    | 2  | 1          |
    +----+------------+

    Output: 
    +-----------+
    | Customers |
    +-----------+
    | Henry     |
    | Max       |
    +-----------+
"""

import pandas as pd

def find_customers(customers: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    df = customers.merge(
        orders,
        how="left",
        left_on="id",
        right_on="customerId"
    ).rename(
        columns={
            "name": "Customers"
        }
    )

    return df[df["customerId"].isna()][["Customers"]]