SELECT
INF.user_email,
REGEXP_EXTRACT(INF.query, r"\/\*.username=(.*)\*\/") as AtScaleUser,
REGEXP_EXTRACT(INF.query, r"\/\*.queryId=(.*)\*\/") as AtScaleQueryId,
INF.creation_time as timestamp_id,
EXTRACT(hour from INF.creation_time) as hour,
EXTRACT(minute from INF.creation_time) as minute,
EXTRACT(second from INF.creation_time) as second,
timestamp(DATE_TRUNC(date(INF.creation_time), day)) as creation_date,
timestamp(DATE_TRUNC(date(INF.creation_time), week)) as week_id,
extract(week from INF.creation_time) as Week,
timestamp(DATE_TRUNC(date( INF.creation_time), month)) as Month,
FORMAT_DATETIME('%B', DATE_TRUNC(date( INF.creation_time), month)) as MonthName,
timestamp(DATE_TRUNC(date( INF.creation_time), year)) as Year,
extract(year from INF.creation_time) as YearName,
INF.job_id,
INF.total_bytes_processed,
INF.total_slot_ms,
INF.total_bytes_billed,
CASE When INF.total_bytes_processed is Null Then 0
  ELSE
  Round(INF.total_bytes_billed/(1000*1000*1000), 3)
  End as Data_Billed_GB,
  CASE When contains_substr(INF.query,"as_agg") then 1
  ELSE 0
  End as agg_hit
  destination_table.project_id,
  destination_table.table_id,
  CASE When contains_substr(destination_table.table_id, "as_agg_") then 1 else 0 end as atscale_build
FROM
  `region-EU`.INFORMATION_SCHEMA.JOBS INF
WHERE
INF.user_email in('atscale@semantic-project.iam.gserviceaccount.com') and 
INF.total_bytes_billed > 0 
ORDER BY creation_time  desc;
