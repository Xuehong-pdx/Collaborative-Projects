/* This script is used to build the county_health table in postgres, using
the csv file available from tableau's public datasets (see link below)
It performs the following steps:
1. Create schema with provided name (e.g. test)
2. Create table with name and data type for each column in CSV file below
3. Copy data from csv file to table: Provide full path to file within single quotes below

Note: I've included the command needed to delete the table, which needs to be run if you wish
to make changes to rebuild the table with updates to data model, etc

CSV source: https://public.tableau.com/s/sites/default/files/media/County_Health_Rankings.csv
*/

CREATE SCHEMA test

CREATE TABLE test.county_health (
	state varchar(2)
	, county varchar
	, state_code smallint
	, county_code smallint
	, year_span varchar(9)
	, measure_name varchar
	, measure_id smallint
	, numerator numeric
	, denominator numeric
	, raw_value numeric 
	, confidence_interval_lower numeric
	, confidence_interval_upper numeric
	, data_release_year smallint
	, fips_code integer
);

COPY test.county_health
FROM '/home/fdpearce/Documents/Projects/data/County_Health_Rankings/County_Health_Rankings.csv'
DELIMITER ',' CSV HEADER;

--DROP TABLE IF EXISTS test.county_health

