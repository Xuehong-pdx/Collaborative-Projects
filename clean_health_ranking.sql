/* These queries were used to clean the original county_heath_ranking.csv file */

/* create county_health table */
CREATE TABLE test.health_rankings ();

/* imported data using DBeaver's Import function by right click on the table name */

/* a quick look at the data*/
SELECT * FROM test.health_rankings limit 10;
SELECT count(*) FROM test.health_rankings;

/* rename columns*/
ALTER TABLE test.health_rankings 
RENAME COLUMN "State code" TO state_code;

ALTER TABLE test.health_rankings 
RENAME COLUMN "County code" TO county_code;

ALTER TABLE test.health_rankings 
RENAME COLUMN "Year span" TO year_span;

ALTER TABLE test.health_rankings 
RENAME COLUMN "Measure name" TO measure_name;

ALTER TABLE test.health_rankings 
RENAME COLUMN "Measure id" TO measure_id;

ALTER TABLE test.health_rankings 
RENAME COLUMN "Raw value" TO raw_value;

ALTER TABLE test.health_rankings 
RENAME COLUMN "Confidence Interval Lower Bound" TO confidence_interval_lower_bound;

ALTER TABLE test.health_rankings 
RENAME COLUMN "Confidence Interval Upper Bound" TO confidence_interval_upper_bound;

ALTER TABLE test.health_rankings 
RENAME COLUMN "Data Release Year" TO data_release_year;

ALTER TABLE test.health_rankings 
RENAME COLUMN fipscode TO fips_code;

/* create start and end year columns for splitting year span colunn*/
ALTER TABLE test.health_rankings 
ADD start_year VARchar(4),
add end_year VARchar(4)

/* split year_span into start, end_ year columns*/
update test.health_rankings 
  set start_year = split_part(year_span, '-', 1), 
      end_year = split_part(year_span, '-', 2)

/* drop year_span column */
alter table test.health_rankings 
drop column year_span;

/* check start_year and end_year columns for integrity*/
select start_year, count(*) 
from test.health_rankings hr 
group by start_year;

select end_year, count(*) 
from test.health_rankings hr 
group by end_year;

/* clean start_year and end_year columns*/
UPDATE test.health_rankings SET start_year= NULL where start_year ='.';
UPDATE test.health_rankings SET start_year= NULL where start_year ='';
UPDATE test.health_rankings SET end_year= NULL where end_year ='';

/* find duplicate records*/
select hr.state,hr.county,hr.state_code,hr.county_code,hr.year_span,hr.start_year, 
		hr.end_year,hr.measure_name,hr.measure_id,hr.numerator,
		hr.denominator, hr.raw_value,hr.confidence_interval_lower_bound,
		hr.confidence_interval_upper_bound,hr.data_release_year,hr.fips_code, count(*)
from test.health_rankings hr 
group by hr.state,hr.county,hr.state_code,hr.county_code,hr.year_span,hr.start_year, 
		hr.end_year,hr.measure_name,hr.measure_id,hr.numerator,
		hr.denominator, hr.raw_value,hr.confidence_interval_lower_bound,
		hr.confidence_interval_upper_bound,hr.data_release_year,hr.fips_code
having count(*) >1;

/* dispaly duplicate records*/
SELECT * 
FROM (SELECT *, count(*) over (PARTITION by hr.state,hr.county,hr.state_code,hr.county_code,hr.year_span,hr.start_year, 
		hr.end_year,hr.measure_name,hr.measure_id,hr.numerator,
		hr.denominator, hr.raw_value,hr.confidence_interval_lower_bound,
		hr.confidence_interval_upper_bound,hr.data_release_year,hr.fips_code) AS count
  	  FROM test.health_rankings hr) tableWithCount
  	  WHERE tableWithCount.count > 1;
       		  
/* delete duplicate records without primary key*/        		  
delete from test.health_rankings a using test.health_rankings b 
where a=b and a.ctid < b.ctid;

/* check state, state_code column integrity*/
select state, state_code, count(*) 
from test.health_rankings hr 
group by state, state_code
order by state, state_code;

/*update state='AK' and county='Alaska' for statec-code='2'*/
update test.health_rankings set state='AK' where county='' and state_code='2'
update test.health_rankings set county='Alaska' where county='' and state_code='2'

/*remove 4 records records without state_code*/
DELETE FROM test.health_rankings
WHERE state_code = '';

/* check county, county_code column integrity*/
select county, county_code, count(*) c
from test.health_rankings hr 
group by county, county_code
order by c; 

/* check measure_name, measure_id column integrity*/
select measure_name, measure_id,count(*) 
from test.health_rankings hr 
group by measure_name, measure_id;

/*delete 79 records with no measure_name*/
delete from test.health_rankings where measure_name ='';

/* check numerical column integrity*/
select  count(*) from test.health_rankings where numerator = '' or denominator= '';
select  count(*) from test.health_rankings where raw_value= '';
select  count(*) from test.health_rankings where confidence_interval_lower_bound= '';
select  count(*) from test.health_rankings where confidence_interval_upper_bound= '';

/* numerator, confidence_interval_lower_bound,confidence_interval_upper_bound have 
   over 110,000 missing values*/

/* check data_release_year, fips_code column integrity*/
select data_release_year,count(*) 
from test.health_rankings hr 
group by data_release_year
order by data_release_year;
/*data_release_year has 146,862 missing values*/

/*check fips_code*/
select count(*) 
from test.health_rankings hr
where fips_code = '';

/* fips_code has 9581 missing missing values*/
delete from test.health_rankings 
where fips_code = '';

/* check county, county code*/
select county, county_code,fips_code
from test.health_rankings
order by fips_code;

/*drop county=United States*/
delete from test.health_rankings where county='United States';

select end_year,count(*) from test.health_rankings hr group by end_year

/*end_year has over 100K null values,*/
alter table test.health_rankings 
drop column end_year;

/*check start_year*/
select start_year,count(*) from test.health_rankings hr group by start_year

delete from test.health_rankings hr2 where start_year is null; /*1 record*/

/*use psql command to write to local machine*/
\copy (SELECT * FROM test.health_rankings) to '\Collaborative-Projects\Cleaned_Health_Rankings.csv' with CSV HEADER;