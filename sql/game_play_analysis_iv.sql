-- # =================================================================
-- # 550. Game Play Analysis IV
-- # Diff: medium
-- # link: https://leetcode.com/problems/game-play-analysis-iv
-- # =================================================================

/*
    Table: Activity
    +--------------+---------+
    | Column Name  | Type    |
    +--------------+---------+
    | player_id    | int     |
    | device_id    | int     |
    | event_date   | date    |
    | games_played | int     |
    +--------------+---------+
    (player_id, event_date) is the primary key (combination of columns with unique values) of this table.
    This table shows the activity of players of some games.
    Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
    
    Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.
    The result format is in the following example.

    Example 1:
    Input: 
    Activity table:
    +-----------+-----------+------------+--------------+
    | player_id | device_id | event_date | games_played |
    +-----------+-----------+------------+--------------+
    | 1         | 2         | 2016-03-01 | 5            |
    | 1         | 2         | 2016-03-02 | 6            |
    | 2         | 3         | 2017-06-25 | 1            |
    | 3         | 1         | 2016-03-02 | 0            |
    | 3         | 4         | 2018-07-03 | 5            |
    +-----------+-----------+------------+--------------+

    Output: 
    +-----------+
    | fraction  |
    +-----------+
    | 0.33      |
    +-----------+

    Explanation: 
    Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33
*/

WITH cte_first_login AS (
    SELECT
        player_id
        ,MIN(event_date) AS event_date
    FROM activity
    GROUP BY
        player_id
), cte_consecutive_login AS (
    SELECT
        DISTINCT cl.player_id
    FROM activity AS cl
    JOIN cte_first_login AS cte
    ON
        cl.player_id = cte.player_id
        AND cl.event_date = DATE_ADD(cte.event_date, INTERVAL 1 DAY)
)
SELECT 
    ROUND(COUNT(c.player_id) / COUNT(f.player_id), 2) AS fraction
FROM cte_first_login AS f
LEFT JOIN cte_consecutive_login AS c
ON
    c.player_id = f.player_id;