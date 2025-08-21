-- Query 1: Find the sentiment of reviews mentioning performance issues
SELECT
    ROUND(
        COUNT(*) FILTER (WHERE is_recommended = true)::numeric / COUNT(*) * 100, 2
    ) AS recommendation_rate,
    COUNT(*) AS total_reviews_with_issues
FROM
    reviews_searchable
WHERE
    review_vector @@ to_tsquery('english', 'bug | crash | performance');



-- Query 2: Find positive reviews that mention key themes
SELECT
    app_name,
    review_text,
    review_votes
FROM
    reviews_searchable
WHERE
    is_recommended = true
    AND review_votes >= 1
    AND review_vector @@ to_tsquery('english', '(gameplay | story) & fun')
ORDER BY
    review_votes DESC
LIMIT 10;