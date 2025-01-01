-- Verificar o DBLink existente
 set linesize 100
 set pagesize 200
 col DB_LINK FOR a15
 col HOST FOR a15
 col USERNAME FOR a20
SELECT DB_LINK, HOST, USERNAME
FROM DBA_DB_LINKS
WHERE DB_LINK = 'DBLINK_DBPSPROD';


--> Ver dblinks existentes (ORIGEM)

SET linesize 300 
SET pagesize 1000 
col owner FOR a20 
col db_link FOR a20 
col username FOR a20 
col host FOR a20 
SELECT owner, 
       db_link, 
       username, 
       host, 
       To_char(created, 'MM/DD/YYYY HH24:MI:SS') Criacao 
FROM   dba_db_links 
--WHERE db_link = 'DBLINK_NAME'
WHERE username = 'INTERFACE_RETAIL'
ORDER  BY Criacao, db_link; 

-- Excluir o DBLink
DROP DATABASE LINK meu_dblink;

-- Recriar o DBLink com novos parâmetros
CREATE DATABASE LINK dblink_name
CONNECT TO user_destino IDENTIFIED BY nova_senha
USING '(DESCRIPTION=
    (ADDRESS=(PROTOCOL=TCP)(HOST=novo_host)(PORT=1521))
    (CONNECT_DATA=(SERVICE_NAME=novo_servico))
)';

CREATE DATABASE LINK dblink_name 
CONNECT TO user_destino IDENTIFIED BY nova_senha USING 'BD_DESTINO';

-- Testar o novo DBLink
SELECT * FROM dual@meu_dblink;
SELECT * FROM dual@DBLINK_DBPSQA;
      

---validar a conexao
--da origem
sqlplus user_destino/senha@name_destino

--do destino
connect user/senha;


--validar global named da origem que deve estar como false

show parameter global;
alter session set GLOBAL_NAMES=FALSE;
