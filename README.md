# Steam Review Analysis Project

## Project Goal
This project performs an end-to-end analysis of a large dataset of Steam reviews. The workflow includes creating a database schema, ingesting raw data, cleaning and transforming the data using advanced SQL, and finally performing text analysis to uncover insights.

## Data Source
The raw data is from the "7 Million+ Steam Reviews (2021)" dataset on Kaggle, containing millions of user reviews for various games on the Steam platform.

## Phase 1: Setup and Data Ingestion
A PostgreSQL database named `player_feedback` was created. A staging table, `reviews_raw`, was defined with all columns as `TEXT` to ensure a successful import of the large CSV file. The data was then loaded from the CSV into this staging table using PostgreSQL's efficient `COPY` command.