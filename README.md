# Steam Review Analysis Project

## Project Goal
This project performs an end-to-end analysis of a large dataset of Steam reviews. The workflow includes creating a database schema, ingesting raw data, cleaning and transforming the data using advanced SQL, and finally performing text analysis to uncover insights.

## Data Source
The raw data is from the "7 Million+ Steam Reviews (2021)" dataset on Kaggle, containing millions of user reviews for various games on the Steam platform.

## Phase 1: Setup and Data Ingestion
A PostgreSQL database named `player_feedback` was created. A staging table, `reviews_raw`, was defined with all columns as `TEXT` to ensure a successful import of the large CSV file. The data was then loaded from the CSV into this staging table using PostgreSQL's efficient `COPY` command.

## Phase 2: Data Cleaning and Transformation
A final, structured table named `reviews` was created with correctly defined data types. A SQL script was then executed to perform the following transformations while loading the data from `reviews_raw` into the final `reviews` table:
* **Type Casting:** Converted columns like `review_id` and `app_id` from `TEXT` to `BIGINT` and `INT`.
* **Text Cleaning:** Used `TRIM()` to remove leading/trailing whitespace from text fields.
* **Conditional Logic:** Used a `CASE` statement to transform the `review_score` column ('1' or '-1') into a more usable `BOOLEAN` column named `is_recommended`.
* **Handling Nulls:** Used `COALESCE()` to ensure any null `review_votes` were converted to `0`.
