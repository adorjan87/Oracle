set linesize 200
set pagesize 300
set serveroutput on


column CON_ID format 99;
column NAME format a8;
column DATABASE_ROLE format a8 heading "DATABASE|ROLE";
column OPEN_MODE format a10;
column DB_UNIQUE_NAME format a9 heading "DB_UNIQUE|NAME"; 
column CDB format a4;
column LOG_MODE format a11;


PROMPT ====================
PROMPT ===== CDB INFO ===== 

select 
 con_id, 
 name,
 database_role, 
 open_mode,
 db_unique_name,
 cdb,
 log_mode
from v$database;


------ PDB infok ------------------------------------------------------
PROMPT
PROMPT
PROMPT ====================
PROMPT ===== PDB INFO =====

column NAME format a20;
column CON_ID format 99;
column OPEN_MODE format a11;

SELECT 
 NAME, 
 CON_ID, 
 DBID, 
 open_mode, 
 total_size, 
 CON_UID, 
 guid 
FROM V$CONTAINERS 
 ORDER BY CON_ID;


------ Sevices infok ----------------------------------------------
PROMPT
PROMPT
PROMPT ========================
PROMPT ===== SERVICE INFO =====


column service_id format 99 heading "service|id";
column name format a18;
column creation_date heading "creation|date"; 
column pdb format a20;
column con_id format 99;


SELECT
 service_id,
 name,
 creation_date,
 pdb,
 con_id
FROM v$services
order by 1
;


TTITLE OFF
