/* This script builds the county_health table in postgres, using
the csv file available from tableau's public datasets (see link below)
It performs the following steps:
1. Create a schema with provided name (e.g. test)
2. Create a table with name and data type for each column in CSV file below
3. Copy data from csv file to postgres table: Provide full path to file within
   single quotes

Note: I've included the command needed to delete the table, which needs to be
run if you wish to recreate the table with updates to data model, etc

CSV link: 
https://public.tableau.com/s/sites/default/files/media/County_Health_Rankings.csv

Resources:
https://www.countyhealthrankings.org/sites/default/files/media/document/resources/Ranked%20measures%20from%20the%20CHR%202010-2019v2.pdf
https://www.countyhealthrankings.org/explore-health-rankings/rankings-data-documentation/national-data-documentation-2010-2018
*/

CREATE SCHEMA inputs

--DROP TABLE IF EXISTS test.county_health
CREATE TABLE inputs.county_health (
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

COPY inputs.county_health
FROM 'full_path_to_file.csv'
DELIMITER ',' CSV HEADER;
