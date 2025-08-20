-- sql_scripts/01_create_staging_table.sql (Corrected)
CREATE TABLE reviews_raw (
    app_id TEXT,
    app_name TEXT,
    review_text TEXT,
    review_score TEXT,
    review_votes TEXT
);