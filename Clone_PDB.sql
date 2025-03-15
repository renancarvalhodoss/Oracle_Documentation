    -- listar os pdbs existentes
    show pdbs;

    -- verificar se esta na raiz(root) do cdb
    show con_name
    ALTER SESSION SET CONTAINER=CDB$ROOT;


    -- colocar o pdb a ser clonado em read only
    alter Pluggable database PDBPRD close immediate;
    alter Pluggable database PDBPRD open read only;

    show parameter create
    SELECT FILE_NAME FROM DBA_DATA_FILES WHERE TABLESPACE_NAME = 'SYSTEM';

    -- realize o clone
    CREATE PLUGGABLE DATABASE PDBDEV 
    FROM PDBPRD 
    FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCLPRD/PDBPRD', '/u01/app/oracle/oradata/ORCLPRD/PDBDEV');

     -- realize sem copiar dados dados
    CREATE PLUGGABLE DATABASE PDBQA 
    FROM PDBPRD 
    FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCLPRD/PDBPRD', '/u01/app/oracle/oradata/ORCLPRD/PDBQA') NO DATA;


    -- abra os pdbs
    alter Pluggable database PDBPRD close immediate;
    alter Pluggable database PDBPRD open; 
    alter Pluggable database PDBDEV open; 
    alter Pluggable database PDBQA open; 

    alter session set container=PDBPRD;
    alter session set container=PDBDEV;
    alter session set container=PDBQA;



    -- comparar dbf ou tabelas
    set pagesize 1000
    set linesize 1000
    col megas format 999999990.00
    COL FILE_NAME FORMAT A110
    SELECT d.bytes/1024/1024 megas,v.CREATION_TIME, d.autoextensible,maxbytes/1024/1024, 
    chr(39)||d.file_name||chr(39) file_name
    FROM dba_data_files D,v$datafile v WHERE d.file_id=v.file#
    and d.bytes/1024/1024 < 32767
    --and d.tablespace_name in ('&TBS') 
    --and FILE_NAME LIKE '%J:%'
    ORDER BY v.CREATION_TIME;



    set linesize 1000
            set pagesize 1000
            COLUMN object_name FORMAT a50
            COLUMN OWNER FORMAT A15
            SELECT object_name,owner 
                FROM dba_objects 
                WHERE owner = 'TESTE_DB' 
                AND object_type IN ('TABLE', 'VIEW');

                Select * from TESTE_DB.CLIENTES;
