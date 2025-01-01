-- visualiza as views e tables de um schema especifico
SELECT object_name 
    FROM dba_objects 
    WHERE owner = 'AVUSER' 
      AND object_type IN ('TABLE', 'VIEW')





-- dar grant de visualização de tables e views de um schema especifico, para um usuario especifico
        BEGIN
    FOR obj IN (
        SELECT object_name 
        FROM dba_objects 
        WHERE owner = 'AVUSER' 
        AND object_type IN ('TABLE', 'VIEW')
    )
    LOOP
        EXECUTE IMMEDIATE 'GRANT SELECT ON AVUSER.' || obj.object_name || ' TO USR_INT_DATABRICKS ';
    END LOOP;
    END;
    /

     set pagesize 0
    SELECT 'GRANT SELECT ON AVUSER.'||object_name||' TO USR_INT_DATABRICKS;'    
    FROM dba_objects    
    WHERE owner = 'AVUSER'      
    AND object_type IN ('TABLE', 'VIEW'); 




    
-- verificar previlegios do usuario
 set linesize 1000
 set pagesize 1000
    COLUMN GRANTEE FORMAT A25
    COLUMN OWNER FORMAT A15
    COLUMN TABLE_NAME FORMAT A40
    COLUMN PRIVILEGE FORMAT A15
    column HOST_IP format a15
    SELECT B.GRANTEE, B.PRIVILEGE, B.OWNER, B.TABLE_NAME, UTL_INADDR.GET_HOST_ADDRESS AS host_ip,
c.host_name
    FROM v$instance c, DBA_TAB_PRIVS B
    WHERE GRANTEE = 'USR_INT_DATABRICKS'
    AND OWNER = 'AVUSER';




    GRANT INSERT ANY TABLE TO ODISTG;

    REVOKE INSERT ANY TABLE FROM ODISTG;


set linesize 1000
 set pagesize 1000
    COLUMN GRANTEE FORMAT A25
    COLUMN TABLE_NAME FORMAT A40
    COLUMN PRIVILEGE FORMAT A15
    SELECT grantee, privilege, table_name
FROM dba_tab_privs
WHERE GRANTEE = 'ODISTG';