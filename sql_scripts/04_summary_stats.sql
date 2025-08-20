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


-- Query 2: What is the overall recommendation rate?
SELECT
    ROUND(
        (COUNT(*) FILTER (WHERE is_recommended = true)::numeric / COUNT(*)) * 100,
        2
    ) AS recommendation_rate_percent
FROM
    reviews;


-- Query 3: Which games have the highest number of "helpful" votes?
SELECT
    app_name,
    SUM(review_votes) AS total_helpful_votes
FROM
    reviews
GROUP BY
    app_name
ORDER BY
    total_helpful_votes DESC
LIMIT 20;