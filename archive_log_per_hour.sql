-- Write redo change
set SERVEROUTPUT ON
COLUMN Log_Switch format 9999

prompt === Archive log switch / Hour ===
select count(first_change#) AS Log_Switch, to_char(first_time, 'YYYY-MM-DD HH') AS "Day_Hour" from v$log_history
group by to_char(first_time, 'YYYY-MM-DD HH')
order by 2
;

set SERVEROUTPUT OFF
