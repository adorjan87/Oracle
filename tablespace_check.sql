COLUMN TS_name FORMAT a12
select
tablespace_name AS TS_name,
round(sum(bytes)/1024/1024,2) AS Actual_size_M,
round(sum(maxbytes)/1024/1024,2) AS Max_size_M,
round((sum(bytes)/sum(maxbytes))*100,3) AS "Saturation_%"
from dba_data_files
group by tablespace_name
;
