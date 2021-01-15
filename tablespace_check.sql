select
tablespace_name AS TS_name,
sum(bytes)/1024/1024 AS Actual_size_M,
sum(maxbytes)/1024/1024 AS Max_size_M,
round((sum(bytes)/sum(maxbytes))*100,3) AS "Saturation_%"
from dba_data_files
group by tablespace_name
;
