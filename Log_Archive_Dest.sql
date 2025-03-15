--verifica erro de log_archive_dest
set colsep '|'
set linesize 200
COL DEST_NAME for a20
COL STATUS for a20
COL destination for a30
COL error for a40
select DEST_NAME,status,destination,error from V$ARCHIVE_DEST where DEST_NAME = 'LOG_ARCHIVE_DEST_2';

--verifica os redo logs
SELECT GROUP#, THREAD#, SEQUENCE#, STATUS 
FROM V$STANDBY_LOG;


--localizar uma sequencia especifica
SELECT NAME 
FROM V$ARCHIVED_LOG 
WHERE SEQUENCE# = 111205;


archive log list
ALTER SYSTEM ARCHIVE LOG CURRENT;
select instance_name from v$instance;
-- enable log archive dest 
ALTER SYSTEM SET LOG_ARCHIVE_DEST_STATE_2=ENABLE;


ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='SERVICE=AFPDG LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=AFPDG';

select DEST_NAME,DESTINATION,STATUS,ERROR
from V$ARCHIVE_DEST_STATUS;

sqlplus sys/AFPDG@AFPDG AS SYSDBA;
CONNECT sys/AFPDG@AFPDG AS SYSDBA;




NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
log_archive_dest_2                   string      SERVICE=AFPDG LGWR ASYNC  VALI
                                                 D_FOR=(ONLINE_LOGFILES,PRIMARY
                                                 _ROLE)  DB_UNIQUE_NAME=AFPDG

SELECT THREAD#, SEQUENCE#, APPLIED, FIRST_TIME, NEXT_TIME 
FROM V$ARCHIVED_LOG
ORDER BY SEQUENCE# asc;