# The scope

This project aims to derive insights from health related data. 

# Phase I: initial table cleaning

The original file "County_Health_Rankings.csv" can be found at https://public.tableau.com/s/sites/default/files/media/County_Health_Rankings.csv

This file contains missing data and mislabeled data in multiple columns as well as duplicated records.  It was migrated into Postgres database as a table. 

Minimum cleaning were done in Postgres using DBeaver interface.  Rows with mislabeled data are corrected based on information in other columns.  Duplicate rows were removed.  The postgresSQL-scripts for creating the original table (csv_to_table.sql) and for cleaning the table (clean_table_to_csv.sql) and the minimum cleaned file (cleaned_rankings_1.csv) are uploaded.  Additional cleaning were done using jupyter notebook (cleaning_2nd.ipynb) and exploratory analysis were doen in exploratory_analysis.ipynb.

# Phase II: getting other types of related data

Economical, COVID-19 related and other types of data will be integrated as new tables in the database to create a comprehensive data source for analysis.  Exploratory data analysis will be performed on the data to focus the direction of the project.

# Phase III: Predictive analysis

Various machine learning algorithms will be used for predictive analysis when appropriate  to derive actionable insights.

# Resources
- https://www.countyhealthrankings.org/sites/default/files/media/document/resources/Ranked%20measures%20from%20the%20CHR%202010-2019v2.pdf
- https://www.countyhealthrankings.org/explore-health-rankings/rankings-data-documentation/national-data-documentation-2010-2018
