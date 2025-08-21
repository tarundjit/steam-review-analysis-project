-- Query 1: For the top 5 games, find the 3 longest positive and negative reviews
WITH TopGames AS (
    -- First, identify the top 5 most-reviewed games
    SELECT app_name FROM reviews GROUP BY app_name ORDER BY COUNT(*) DESC LIMIT 5
),
RankedReviews AS (
    -- Next, rank reviews for those top games by their length
    SELECT
        r.app_name,
        r.review_text,
        r.is_recommended,
        -- Rank reviews within each game AND recommendation status by the length of the review
        RANK() OVER (PARTITION BY r.app_name, r.is_recommended ORDER BY LENGTH(r.review_text) DESC) as review_rank
    FROM
        reviews r
    JOIN
        TopGames tg ON r.app_name = tg.app_name
    WHERE
        r.review_text IS NOT NULL AND r.review_text != ''
)
-- Finally, select the top 3 from each partition
SELECT
    app_name,
    is_recommended,
    review_text
FROM
    RankedReviews
WHERE
    review_rank <= 3
ORDER BY
    app_name, is_recommended, review_rank;
