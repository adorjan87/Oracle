--The script prits information about diskroup.
--It uses gv$asm_diskgroup view.

set linesize 400;
COLUMN INST_ID FORMAT 9 heading INST_ID;
COLUMN GROUP_NUMBER  FORMAT 99 heading GR_NUM;
COLUMN NAME  FORMAT a6 heading GROUP_NAME;
COLUMN STATE  FORMAT a7 heading STATE;
COLUMN TYPE  FORMAT a7 heading TYPE;
COLUMN TOTAL_MB  FORMAT 9999999 heading TOTAL_MB;
COLUMN FREE_MB  FORMAT 9999999 heading FREE_MB;
COLUMN USABLE_FILE_MB  FORMAT 9999999 heading "USABLE|FILE_MB";

select
  INST_ID,
  GROUP_NUMBER,
  NAME,
  STATE,
  TYPE,
  TOTAL_MB,
  FREE_MB,
  USABLE_FILE_MB
from gv$asm_diskgroup
order by INST_ID asc;
