/* These queries were used to clean the original county_heath_ranking.csv file */

/* copy county_health table to cleaned_ranking_1 table using Dbeaver export daabase function*/

/* a quick look at the data*/
SELECT * FROM test.cleaned_ranking_1 limit 10;
SELECT count(*) FROM test.cleaned_ranking_1;

/* create start and end year columns for splitting year span colunn*/
ALTER TABLE test.cleaned_ranking_1 
ADD start_year VARchar(4),
add end_year VARchar(4)

/* split year_span into start, end_ year columns*/
update test.cleaned_ranking_1 
  set start_year = split_part(year_span, '-', 1), 
      end_year = split_part(year_span, '-', 2)

/* drop year_span column */
alter table test.cleaned_ranking_1 
drop column year_span;

/* check start_year and end_year columns for integrity*/
select start_year, count(*) 
from test.cleaned_ranking_1 hr 
group by start_year;

select end_year, count(*) 
from test.cleaned_ranking_1 hr 
group by end_year;

/* clean start_year and end_year columns*/
UPDATE test.cleaned_ranking_1 SET start_year= NULL where start_year ='.';
UPDATE test.cleaned_ranking_1 SET start_year= NULL where start_year ='';
UPDATE test.cleaned_ranking_1 SET end_year= NULL where end_year ='';

/* find duplicate records*/
select hr.state,hr.county,hr.state_code,hr.county_code,hr.start_year, 
		hr.end_year,hr.measure_name,hr.measure_id,hr.numerator,
		hr.denominator, hr.raw_value,hr.confidence_interval_lower,
		hr.confidence_interval_upper,hr.data_release_year,hr.fips_code, count(*)
from test.cleaned_ranking_1 hr 
group by hr.state,hr.county,hr.state_code,hr.county_code,hr.start_year, 
		hr.end_year,hr.measure_name,hr.measure_id,hr.numerator,
		hr.denominator, hr.raw_value,hr.confidence_interval_lower,
		hr.confidence_interval_upper,hr.data_release_year,hr.fips_code
having count(*) >1;

/* dispaly duplicate records*/
SELECT * 
FROM (SELECT *, count(*) over (PARTITION by hr.state,hr.county,hr.state_code,
		hr.county_code,hr.start_year,hr.end_year,hr.measure_name,hr.measure_id,
		hr.numerator,hr.denominator, hr.raw_value,hr.confidence_interval_lower,
		hr.confidence_interval_upper,hr.data_release_year,hr.fips_code) AS count
  	  FROM test.cleaned_ranking_1 hr) tableWithCount
  	  WHERE tableWithCount.count > 1;
       		  
/* delete duplicate records without primary key*/        		  
delete from test.cleaned_ranking_1 a using test.cleaned_ranking_1 b 
where a=b and a.ctid < b.ctid; /* deleted 6793 rows*/

/* check state, state_code column integrity*/
select state, state_code, count(*) 
from test.cleaned_ranking_1 
group by state, state_code
order by state_code;

/* delete 93 records with US as state*/
delete from test.cleaned_ranking_1 
where state='US';

select *
from test.cleaned_ranking_1 
where state_code = 2 and state is NULL;

/*update state='AK' and county='Alaska' for statec-code='2'*/
update test.cleaned_ranking_1 set state='AK' where county='' and state_code='2'

/* check county, county_code column integrity*/
select county, county_code, count(*) c
from test.cleaned_ranking_1 hr 
group by county, county_code
order by c; 

select county, county_code, count(*) c
from test.cleaned_ranking_1 hr 
group by county, county_code
order by c; ?\/*two county code 105 and 230 has no county_name*/

/* check measure_name, measure_id column integrity*/
select measure_name, measure_id,count(*) 
from test.cleaned_ranking_1 hr 
group by measure_name, measure_id;

/*delete 79 records with no measure_name*/
delete from test.cleaned_ranking_1 where measure_name ='';

/* check numerical column integrity*/
select  count(*) from test.cleaned_ranking_1 
where numerator is null or denominator is null; 
/*161,868 missing values*/
select  count(*) from test.cleaned_ranking_1 where raw_value is null; 
/*13,503 missing values*/
select  count(*) from test.cleaned_ranking_1 where confidence_interval_lower is null;
/*113,976 missing values*/
select  count(*) from test.cleaned_ranking_1 where confidence_interval_upper is null;
/*113,976 missing values*/

/* check data_release_year, fips_code column integrity*/
select data_release_year,count(*) 
from test.cleaned_ranking_1 hr 
group by data_release_year
order by data_release_year;
/*146,862 missing values*/

/*check fips_code*/
select count(*) 
from test.cleaned_ranking_1 hr
where fips_code is null;
/* 9575 missing missing values*/

/* check county, county code*/
select county, county_code,fips_code
from test.cleaned_ranking_1
order by fips_code;

select end_year,count(*) from test.cleaned_ranking_1 hr group by end_year
/*217,182 null values,*/

/*check start_year*/
select start_year,count(*) from test.cleaned_ranking_1 hr group by start_year

select count(*) from test.cleaned_ranking_1

/*use psql command to write to local machine*/
\copy (SELECT * FROM test.cleaned_ranking_1) to '\Collaborative-Projects\cleaned_ranking_1.csv' with CSV HEADER;