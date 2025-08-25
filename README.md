# Steam Review Analysis Project

## Project Goal
This project performs an end-to-end analysis of a large dataset of Steam reviews. The workflow includes creating a database schema, ingesting raw data, cleaning and transforming the data using advanced SQL, and finally performing text analysis and visualization to uncover insights.

## Data Source
The raw data is from the "7 Million+ Steam Reviews (2021)" dataset on Kaggle, containing millions of user reviews for various games on the Steam platform.

---

## Phase 1: Setup and Data Ingestion
A PostgreSQL database named `player_feedback` was created. A staging table, `reviews_raw`, was defined to match the CSV structure. The raw data was then loaded into this staging table using PostgreSQL's efficient `COPY` command.
* **Script:** [`01_create_staging_table.sql`](./sql_scripts/01_create_staging_table.sql)

---

## Phase 2: Data Cleaning and Transformation
A final, structured table named `reviews` was created with correctly defined data types. A SQL script was then executed to perform the following transformations while loading the data from `reviews_raw` into the final `reviews` table:
* **Type Casting:** Converted columns from `TEXT` to their proper numeric types (`BIGINT`, `INT`).
* **Text Cleaning:** Used `TRIM()` to remove leading/trailing whitespace from text fields.
* **Conditional Logic:** Used a `CASE` statement to transform the `review_score` column into a more usable `BOOLEAN` column named `is_recommended`.
* **Handling Nulls:** Used `COALESCE()` to convert any null `review_votes` into a default value of `0`.
* **Data Validation:** Records with `NULL` or empty `app_name` values were deleted to ensure the quality of the final dataset.
* **Scripts:**
    * [`02_create_final_table.sql`](./sql_scripts/02_create_final_table.sql)
    * [`03_clean_and_transform.sql`](./sql_scripts/03_clean_and_transform.sql)

---

## Phase 3: Core Analysis & Summary Stats
With the data cleaned and structured, an initial exploratory analysis was performed to get a high-level understanding of the dataset.
### Key Findings:
* **Most Reviewed Games:** The dataset is heavily dominated by major titles like "Payday2" and "Dayz".
* **Overall Sentiment:** The sentiment across all reviews is highly positive, with a recommendation rate of approximately 61.29%.
* **"Helpful" Reviews:** The games with the highest number of reviews marked as "helpful" are largely the same as the most-reviewed games.
* **Script:** [`04_summary_stats.sql`](./sql_scripts/04_summary_stats.sql)

---

## Phase 4: Advanced Analysis with Window Functions
To find deeper insights, window functions were used to rank and compare reviews within specific groups.
### Key Findings:
* **Segmented Analysis:** Using `RANK() OVER (PARTITION BY ...)` we successfully identified the longest positive and negative reviews for each of the top 5 most-reviewed games, providing insight into the most detailed user feedback.
* **Script:** [`05_window_functions.sql`](./sql_scripts/05_window_functions.sql)

---

## Phase 5: Text Mining & Full-Text Search
A dedicated, indexed table was created for a subset of the data to enable high-speed text analysis using PostgreSQL's Full-Text Search.
### Key Findings:
* **Sentiment on Technical Issues:** Reviews mentioning words like "bug," "crash," or "performance" showed a significantly lower recommendation rate compared to the overall average.
* **Positive Themes:** Full-Text Search was also used to identify positive reviews that praised key aspects like "gameplay" and "story."
* **Scripts:**
    * [`06_text_search_setup.sql`](./sql_scripts/06_text_search_setup.sql)
    * [`07_text_analysis.sql`](./sql_scripts/07_text_analysis.sql)

---

## Phase 6: Visualization
The key findings from the SQL analysis were visualized in the summary dashboard below, created with Tableau Public.

**[Link to Live Dashboard on Tableau Public](https://public.tableau.com/app/profile/your-username/viz/...)** *(https://public.tableau.com/app/profile/tarun.chowdary.manne/viz/SteamReviewAnalysisDashboard/SteamReviewAnalysisSummary?publish=yes)*

![Final Dashboard](./images/final_dashboard.png)