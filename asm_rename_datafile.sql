set heading off
set pagesize 0
set linesize 150
set space 0
set echo off
set verify off
set feedback off

accept dg_name char prompt 'Enter a new DG name: '

spool run_asm_rename_datafile.sql

prompt -- Rename datafile
select 'alter database rename file ' || ''''|| df1.name || '''' || ' to ' || '''' || '+&dg_name/DEMODB/DATAFILE' || substr(df1.name, instr(df1.name, '/', -1)) || '''' || ';' from v$datafile df1;

prompt -- Rename Redo
select 'alter database rename file ' || ''''|| member || '''' || ' to ' || '''' || '+&dg_name/DEMODB/ONLINELOG' || SUBSTR(member, INSTR(member, '/', -1)) || '''' || ';' from v$logfile ;

spool off
exit
