-- sql_scripts/03_clean_and_transform.sql
INSERT INTO reviews (app_id, app_name, review_text, is_recommended, review_votes)
SELECT
    CAST(app_id AS INT),
    TRIM(app_name),
    TRIM(review_text),
    CASE
        WHEN review_score = '1' THEN true
        ELSE false
    END AS is_recommended,
    COALESCE(CAST(review_votes AS INT), 0)
FROM
    reviews_raw;