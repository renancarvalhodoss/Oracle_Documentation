--verifica erro de log_archive_dest
set linesize 200
COL DEST_NAME for a20
COL STATUS for a20
COL destination for a30
COL error for a70
select DEST_NAME,status,destination,error from V$ARCHIVE_DEST where DEST_NAME = 'LOG_ARCHIVE_DEST_1';

archive log list

select instance_name from v$instance;
-- enable log archive dest 
log_archive_dest_state_1=enable;



select DEST_NAME,DESTINATION,STATUS,ERROR
from V$ARCHIVE_DEST_STATUS;