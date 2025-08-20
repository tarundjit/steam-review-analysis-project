-- sql_scripts/04_summary_stats.sql
-- Query 1: What are the top 20 most-reviewed games?
SELECT
    app_name,
    COUNT(review_id) AS number_of_reviews
FROM
    reviews
GROUP BY
    app_name
ORDER BY
    number_of_reviews DESC
LIMIT 20;