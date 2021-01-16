with ts_total (ts_name, df_total, df_max) as
    (
    select
        tablespace_name,
        sum(bytes),
        sum(maxbytes)
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
    round(((tst.df_total - tsf.ts_free_space) / tst.df_total) * 100, 2) as "Current usages (%)",
    round(((tst.df_total - tsf.ts_free_space) / tst.df_max) * 100, 2) as "Real usages (%)" -- It is a real usages in %. It uses dba_data_files.maxbytes
from
    ts_total tst,
    ts_free_space tsf
where
    tst.ts_name = tsf.ts_name
order by 6 desc
;
