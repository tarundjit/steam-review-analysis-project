-- Query 1: Rank the most helpful reviews for a specific game
SELECT
    review_text,
    review_votes,
    is_recommended,
    RANK() OVER (ORDER BY review_votes DESC) as review_rank
FROM
    reviews
WHERE
    app_name = 'Counter-Strike: Source' 
LIMIT 10;

-- Query 2: Find the most helpful review for each major game franchise
WITH RankedReviews AS (
    SELECT
        app_name,
        review_text,
        review_votes,
        -- Create a rank partitioned by the game's main franchise name
        RANK() OVER (PARTITION BY SPLIT_PART(app_name, ':', 1) ORDER BY review_votes DESC) as review_rank
    FROM
        reviews
    WHERE
        -- Filter for popular franchises that are likely to have multiple entries
        app_name ILIKE 'Counter-Strike%' OR app_name ILIKE 'Grand Theft Auto%' OR app_name ILIKE 'Half-Life%' OR app_name ILIKE 'Sid Meier''s Civilization%'
)
SELECT
    app_name,
    review_text,
    review_votes
FROM
    RankedReviews
WHERE
    review_rank = 1
ORDER BY
    review_votes DESC;