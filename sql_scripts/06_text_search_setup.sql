-- sql_scripts/06_text_search_setup.sql
-- This script creates a dedicated, smaller table for efficient text analysis.

-- Step 1: Create the new searchable table
CREATE TABLE reviews_searchable (
    review_id BIGSERIAL PRIMARY KEY,
    app_id INT,
    app_name TEXT,
    review_text TEXT,
    is_recommended BOOLEAN,
    review_votes INT,
    review_vector tsvector
);

-- Step 2: Populate the table with a clean subset from the top 5 games
INSERT INTO reviews_searchable (review_id, app_id, app_name, review_text, is_recommended, review_votes, review_vector)
SELECT
    review_id,
    app_id,
    app_name,
    review_text,
    is_recommended,
    review_votes,
    to_tsvector('english',
        SUBSTRING(
            regexp_replace(review_text, E'https?://\\S+|[^[:alnum:][:space:]]+', ' ', 'g'),
            1, 50000
        )
    )
FROM
    reviews
WHERE app_name IN (
    SELECT app_name
    FROM reviews
    GROUP BY app_name
    ORDER BY COUNT(*) DESC
    LIMIT 5
);

-- Step 3: Create the GIN index for fast searching
CREATE INDEX reviews_search_idx ON reviews_searchable USING GIN(review_vector);