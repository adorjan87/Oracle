set verify off
set serveroutput on
set linesize 200
accept pdb_name char prompt 'Enter exit PDB name: '
accept pdb_new_name char prompt 'Enter new PDB name: '

DECLARE

-- SQLPLUS variables
l_pdb_name VARCHAR2(5) := '&pdb_name';
l_pdb_new_name VARCHAR2(5) := '&pdb_new_name';

-- SQL querys
l_alter_str1 VARCHAR2(100);
l_create_pdb_qry VARCHAR2(100);
l_pdb_read_only_qry VARCHAR2(100);
l_new_pdb_exist_qry VARCHAR2(100);

-- PL/SQL variables
l_name v$containers.name%TYPE;

BEGIN

    SELECT name INTO l_name from v$containers
    where name = l_pdb_name;

    l_alter_str1 := 'alter pluggable database ' || l_pdb_name || ' close immediate';
    execute immediate l_alter_str1;

    l_pdb_read_only_qry := 'alter pluggable database ' || l_pdb_name || ' open read only';
    execute immediate l_pdb_read_only_qry;


    l_create_pdb_qry := 'create pluggable database ' || l_pdb_new_name || ' FROM ' || l_pdb_name ;
    execute immediate l_create_pdb_qry;

    DBMS_OUTPUT.PUT_LINE(l_name);
EXCEPTION
    WHEN no_data_found THEN DBMS_OUTPUT.PUT_LINE('It does not exist ' || l_pdb_name || ' database' );

END;
/
