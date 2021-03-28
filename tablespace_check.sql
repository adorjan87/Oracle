--This script shows TS usages
PROMPT
PROMPT ====================================================================
PROMPT TS name: Tablespace ts_name
PROMPT TS can grow (MB):  TS max physical what able to achieve
PROMPT Physical size (MB): TS actual real physical size. Actually it is all datafiles size in filesystem.
PROMPT Used (MB): Real usages in TS. This size depend on autoextend option
PROMPT: Free in TS (MB): Real free space in TS. Max size is allays autoextended max size
PROMPT: Current usages (%): It is a physical usages in filesystem.
PROMPT: Real usages (%): It is a real usages in tablespace.
PROMPT ====================================================================
PROMPT

set lines 9999
set feedback off
COLUMN "TS name" FORMAT a12

with ts_total (ts_name, df_total, df_max) as
    (
    select
        tablespace_name,
        sum(bytes),
        sum(maxbytes) --Max size where datafile can grow
    from dba_data_files
    group by tablespace_name
    ),
    ts_free_space(ts_name,ts_free_space) as
    (
    select
        tablespace_name,
        nvl(sum(bytes),0)
    from dba_free_space
    group by tablespace_name
    )
select
    tst.ts_name as "TS name",
    round(tst.df_max /1024/1024,2) as "TS can grow (MB)",
    round(tst.df_total/1024/1024,2) as "Physical size (MB)", --Datafile real physical size in filesystem
    round((tst.df_total - tsf.ts_free_space)/1024/1024,2) as "Used (MB)", --Real usages from TS
    round(tsf.ts_free_space/1024/1024,2)  as "Free in TS (MB)", -- Actual free space in TS
    round(((tst.df_total - tsf.ts_free_space) / tst.df_total) * 100, 2) as "Current usages (%)", --Usages in % where max size is a current, actual size
    round(((tst.df_total / tst.df_max) * 100), 2) as "Real usages (%)" -- It is a real usages in %. It uses dba_data_files.maxbytes
--round(((tst.df_total - tsf.ts_free_space) / tst.df_max) * 100, 2) as "Real usages (%)"
from
    ts_total tst,
    ts_free_space tsf
where
    tst.ts_name = tsf.ts_name
order by 7 desc
;
