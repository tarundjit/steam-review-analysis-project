CREATE TABLE reviews (
    review_id BIGSERIAL PRIMARY KEY,
    app_id INT,
    app_name TEXT,
    review_text TEXT,
    is_recommended BOOLEAN,
    review_votes INT
);