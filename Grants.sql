    -- criar usuario
    CREATE USER SPB01634 IDENTIFIED BY "vPvtBjs$kz-V76ZUK";

    --Conceder Permissões Básicas: Conceda os privilégios básicos para o usuário se conectar ao banco de dados:
    GRANT CREATE SESSION TO sbp32448;

    --Conceder Permissões de Leitura e Escrita em Todos os Schemas:
    GRANT SELECT ANY TABLE, INSERT ANY TABLE, UPDATE ANY TABLE, DELETE ANY TABLE TO sbp32448;

    --conceder permissões específicas para os schemas ou objetos que o usuário deve acessar:
    GRANT SELECT, INSERT, UPDATE, DELETE ON schema_name.table_name TO sbp32448;

    --Opcional: Conceder Permissões Adicionais (se necessário): Caso o usuário precise criar objetos (tabelas, views, etc.), conceda também:
    GRANT CREATE ANY TABLE, ALTER ANY TABLE, DROP ANY TABLE TO sbp32448;


    -- Consultar privilégios de sistema
    -- SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'USUARIO_ORIGEM';
SELECT 'GRANT ' || PRIVILEGE || ' TO SPB01634;' AS COMANDO
FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'PECAS';


col PRIVILEGE for a40
SELECT GRANTEE, PRIVILEGE FROM DBA_SYS_PRIVS WHERE GRANTEE = 'PECAS'
ORDER BY PRIVILEGE DESC;

SELECT GRANTEE, PRIVILEGE FROM DBA_SYS_PRIVS WHERE GRANTEE = 'SPB01634'
ORDER BY PRIVILEGE DESC;

-- . Consultar privilégios de objeto
-- SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'USUARIO_ORIGEM';
SELECT 'GRANT ' || PRIVILEGE || ' ON ' || OWNER || '.' || TABLE_NAME || ' TO SPB01634;' AS COMANDO
FROM DBA_TAB_PRIVS
WHERE GRANTEE = 'PECAS';

set lines 200
col PRIVILEGE for a40
col TABLE_NAME for a20
col GRANTEE for a20
col OWNER for a20
SELECT GRANTEE,OWNER,TABLE_NAME,PRIVILEGE,TYPE  FROM DBA_TAB_PRIVS WHERE GRANTEE = 'PECAS'
ORDER BY TABLE_NAME DESC;

SELECT GRANTEE,OWNER,TABLE_NAME,PRIVILEGE,TYPE  FROM DBA_TAB_PRIVS WHERE GRANTEE = 'SPB01634'
ORDER BY TABLE_NAME DESC;

-- . Consultar roles atribuídas
-- SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'USUARIO_ORIGEM';
SELECT 'GRANT ' || GRANTED_ROLE || ' TO SPB01634;' AS COMANDO
FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'PECAS';


SELECT GRANTEE, GRANTED_ROLE FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'PECAS'
ORDER BY GRANTED_ROLE DESC;

SELECT GRANTEE, GRANTED_ROLE FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'SPB01634'
ORDER BY GRANTED_ROLE DESC;
    -- dar grant de visualização de tables e views de um schema especifico, para um usuario especifico
            BEGIN
        FOR obj IN (
            SELECT object_name 
            FROM dba_objects 
            WHERE owner = 'USRSOPDB' 
            AND object_type IN ('TABLE', 'VIEW')
        )
        LOOP
            EXECUTE IMMEDIATE 'GRANT SELECT ON SAPR3.' || obj.object_name || ' TO USRSOPDB ';
        END LOOP;
        END;
        /

    --ou

    spool grants-usrsopdb2.log
        set pagesize 0
        SELECT 'GRANT SELECT, INSERT, UPDATE, DELETE ON SAPR3.'||object_name||' TO USRSOPDB;'    
        FROM dba_objects    
        WHERE owner = 'SAPR3'      
        AND object_type IN ('TABLE', 'VIEW'); 
    spool off;



    --Testar o Usuário: 
    sqlplus SPB01634/"vPvtBjs$kz-V76ZUK"



    -- visualiza as views e tables de um schema especifico
        set linesize 1000
        set pagesize 1000
        COLUMN object_name FORMAT a50
        COLUMN OWNER FORMAT A15
        SELECT object_name,owner 
            FROM dba_objects 
            WHERE owner = 'AVUSER' 
            AND object_type IN ('TABLE', 'VIEW')

--verificar todos os schemas do banco
    set linesize 1000
    set pagesize 1000
    COLUMN SCHEMA_NAME FORMAT a50
    COLUMN OWNER FORMAT A15
    SELECT USERNAME AS SCHEMA_NAME, ACCOUNT_STATUS
    FROM DBA_USERS
    ORDER BY USERNAME;


        
    -- verificar previlegios concedidos ao usuario
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
        WHERE GRANTEE = 'spb01634';
        AND OWNER = 'AVUSER';


    --remover grant
        REVOKE INSERT ANY TABLE FROM ODISTG;


    set linesize 1000
    set pagesize 1000
        COLUMN GRANTEE FORMAT A25
        COLUMN TABLE_NAME FORMAT A40
        COLUMN PRIVILEGE FORMAT A15
        SELECT grantee, privilege, table_name
    FROM dba_tab_privs;
    WHERE GRANTEE = 'sbp32448';


SELECT GRANTEE, PRIVILEGE 
FROM DBA_SYS_PRIVS 
WHERE GRANTEE = 'SBP32448';
