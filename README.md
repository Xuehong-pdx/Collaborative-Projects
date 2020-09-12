# The scope

This project aims to derive insights from health related data. 

# Phase I: initial table cleaning

The file "County_Health_Rankings.csv" can also be found at https://public.tableau.com/s/sites/default/files/media/County_Health_Rankings.csv

This file contains missing data and mislabeled data in multiple columns as well as duplicated records.  It was migrated into Postgres database as a table. 

To clean the table, rows with mostly missing data are dropped, whenever possible mislabeled data are corrected based on other information in other columns.  Two cleaned tables were generated.  One focused on preserving as much as possible the records without any null values ("Cleaned_Health_Rankings.csv"), the other focused more on preserving features ("Cleaned_Health_Rankings_1.csv") where preserving four more features cost the loss of 58% of records. Both files are uploaded via LFS to this repository

# Phase II: getting other types of related data

Economical, COVID-19 related and other types of data will be integrated as new tables in the database to create a comprehensive data source for analysis.  Exploratory data analysis will be performed on the data to focus the direction of the project.

# Phase III: Predictive analysis

Various machine learning algorithms will be used for predictive analysis when appropriate  to derive actionable insights.
