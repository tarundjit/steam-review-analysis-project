# Steam Review Analysis Project

## Project Goal
This project performs an end-to-end analysis of a large dataset of Steam reviews. The workflow includes creating a database schema, ingesting raw data, cleaning and transforming the data using advanced SQL, and finally performing text analysis to uncover insights.

## Data Source
The raw data is from the "7 Million+ Steam Reviews (2021)" dataset on Kaggle, containing millions of user reviews for various games on the Steam platform.

## Phase 1: Setup and Data Ingestion
A PostgreSQL database named `player_feedback` was created. A staging table, `reviews_raw`, was defined with all columns as `TEXT` to ensure a successful import of the large CSV file. The data was then loaded from the CSV into this staging table using PostgreSQL's efficient `COPY` command.

## Phase 2: Data Cleaning and Transformation
A final, structured table named `reviews` was created with correctly defined data types. A SQL script was then executed to perform the following transformations while loading the data from `reviews_raw` into the final `reviews` table:
* **Type Casting:** Converted columns from `TEXT` to their proper numeric types (`BIGINT`, `INT`).
* **Text Cleaning:** Used `TRIM()` to remove leading/trailing whitespace from text fields.
* **Conditional Logic:** Used a `CASE` statement to transform the `review_score` column into a more usable `BOOLEAN` column named `is_recommended`.
* **Handling Nulls:** Used `COALESCE()` to convert any null `review_votes` into a default value of `0`.
* **Data Validation:** Records with `NULL` or empty `app_name` values were deleted to ensure the quality of the final dataset.
