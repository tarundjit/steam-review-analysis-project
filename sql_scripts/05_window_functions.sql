-- Query 1: Rank the most helpful reviews for a specific game
SELECT
    review_text,
    review_votes,
    is_recommended,
    RANK() OVER (ORDER BY review_votes DESC) as review_rank
FROM
    reviews
WHERE
    app_name = 'Counter-Strike'
LIMIT 10;

-- Query 2: For the top 5 games, find the most helpful positive and negative review for each.
WITH TopGames AS (
    -- First, identify the top 5 most-reviewed games
    SELECT
        app_name
    FROM
        reviews
    GROUP BY
        app_name
    ORDER BY
        COUNT(review_id) DESC
    LIMIT 5
),
RankedReviews AS (
    -- Next, rank reviews only for those top games
    SELECT
        r.app_name,
        r.review_text,
        r.review_votes,
        r.is_recommended,
        RANK() OVER (PARTITION BY r.app_name, r.is_recommended ORDER BY r.review_votes DESC) as review_rank
    FROM
        reviews r
    JOIN
        TopGames tg ON r.app_name = tg.app_name
)
-- Finally, select the #1 ranked review from each partition
SELECT
    app_name,
    is_recommended,
    review_text,
    review_votes
FROM
    RankedReviews
WHERE
    review_rank = 1
ORDER BY
    app_name, is_recommended;