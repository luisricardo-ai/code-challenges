-- # =================================================================
-- # User Shopping Sprees
-- # Diff: medium
-- # link: https://datalemur.com/questions/amazon-shopping-spree
-- # =================================================================

/*
    In an effort to identify high-value customers, Amazon asked for your help to obtain data about users who go on shopping sprees. A shopping spree occurs when a user makes purchases on 3 or more consecutive days.

    List the user IDs who have gone on at least 1 shopping spree in ascending order.

    transactions Table:
    Column Name	Type
    user_id	integer
    amount	float
    transaction_date	timestamp

    transactions Example Input:
    user_id	amount	transaction_date
    1	9.99	08/01/2022 10:00:00
    1	55	08/17/2022 10:00:00
    2	149.5	08/05/2022 10:00:00
    2	4.89	08/06/2022 10:00:00
    2	34	08/07/2022 10:00:00

    Example Output:
    user_id
    2
    Explanation

    In this example, user_id 2 is the only one who has gone on a shopping spree.

    The dataset you are querying against may have different input & output - this is just an example!
*/

SELECT 
  DISTINCT T1.user_id
FROM transactions AS T1
INNER JOIN transactions AS T2
ON
  T1.transaction_date::DATE + 1 = T2.transaction_date::DATE
INNER JOIN transactions AS T3
ON
  T1.transaction_date::DATE + 2 = T3.transaction_date::DATE
ORDER BY
  T1.user_id ASC
;