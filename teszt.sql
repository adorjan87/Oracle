set verify off
set serveroutput on
set linesize 200
accept pdb_name char prompt 'Enter exit PDB name: '
accept pdb_new_name char prompt 'Enter new PDB name: '

DECLARE

l_pdb_name VARCHAR2(5) := '&pdb_name';
l_pdb_new_name VARCHAR2(5) := '&pdb_new_name';

l_alter_str1 VARCHAR2(100);

BEGIN
    l_alter_str1:='alter pluggable database ' || l_pdb_name || ' close immediate';

    execute immediate l_alter_str1;
    --DBMS_OUTPUT.PUT_LINE(l_alter_str1);

END;
/
