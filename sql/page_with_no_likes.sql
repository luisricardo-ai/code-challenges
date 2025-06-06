-- # =================================================================
-- # Page With No Likes
-- # Diff: easy
-- # link: https://datalemur.com/questions/sql-page-with-no-likes
-- # =================================================================

/*
    Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").
    Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.

    pages Table:
    Column Name	Type
    page_id	integer
    page_name	varchar

    pages Example Input:
    page_id	page_name
    20001	SQL Solutions
    20045	Brain Exercises
    20701	Tips for Data Analysts

    page_likes Table:
    Column Name	Type
    user_id	integer
    page_id	integer
    liked_date	datetime

    page_likes Example Input:
    user_id	page_id	liked_date
    111	20001	04/08/2022 00:00:00
    121	20045	03/12/2022 00:00:00
    156	20001	07/25/2022 00:00:00

    Example Output:
    page_id
    20701

    The dataset you are querying against may have different input & output - this is just an example!

    p.s. If you have literally no idea how to solve this, maybe give our free SQL tutorial a try first?
*/

SELECT 
  pages.page_id
FROM page_likes
RIGHT JOIN pages
ON
  pages.page_id = page_likes.page_id
GROUP BY
  pages.page_id
HAVING
  COUNT(DISTINCT user_id) = 0
ORDER BY
  pages.page_id;