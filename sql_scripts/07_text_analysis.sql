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



-- QUery 2: Find any highly-voted positive reviews mentioning 'fun'
SELECT
    app_name,
    review_text,
    review_votes
FROM
    reviews -- Searching the main table, not the searchable subset
WHERE
    is_recommended = true
    AND review_votes > 50
    AND review_text ILIKE '%fun%' -- Simple, direct text search
ORDER BY
    review_votes DESC
LIMIT 10;