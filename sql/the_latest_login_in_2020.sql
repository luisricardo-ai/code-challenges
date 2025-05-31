-- # =================================================================
-- # 1890. The Latest Login in 2020
-- # Diff: medium
-- # link: https://leetcode.com/problems/the-latest-login-in-2020/description/
-- # =================================================================

select user_id, max(time_stamp) as last_stamp from Logins where year(time_stamp) = 2020 group by user_id;