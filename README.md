# The scope

This project aims to derive insights from health related data. 

# Phase I: initial table cleaning

The original file "County_Health_Rankings.csv" can be found at https://public.tableau.com/s/sites/default/files/media/County_Health_Rankings.csv

This file contains missing data and mislabeled data in multiple columns as well as duplicated records.  It was migrated into Postgres database as a table. 

Minimum cleaning were done in Postgres using DBeaver interface.  Rows with mislabeled data are corrected based on other information in other columns.  Rows with missing values that are less than 1% of the total data are removed.  

# Phase II: getting other types of related data

Economical, COVID-19 related and other types of data will be integrated as new tables in the database to create a comprehensive data source for analysis.  Exploratory data analysis will be performed on the data to focus the direction of the project.

# Phase III: Predictive analysis

Various machine learning algorithms will be used for predictive analysis when appropriate  to derive actionable insights.
