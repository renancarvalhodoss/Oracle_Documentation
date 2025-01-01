
----------------------------------------------listar archives-------------------------------------
 set linesize 1000
 set pagesize 1000
select DEST_NAME, status from V$ARCHIVE_DEST;

Archive Mode não está ligado:
SQL> archive log list
Database log mode	       No Archive Mode
Automatic archival	       Disabled
Archive destination	       /opt/oracle/product/12.2.0.1/dbhome_1/dbs/arch
Oldest online log sequence     15
Current log sequence	       17
 


Archive Mode ligado:
SQL> archive log list
Database log mode	       Archive Mode
Automatic archival	       Enabled
Archive destination	       USE_DB_RECOVERY_FILE_DEST
Oldest online log sequence     342354
Next log sequence to archive   342355
Current log sequence	       342355



tamanho do archive:
SQL> show parameters DB_RECO
NAME		    TYPE	  VALUE
--------------------------- ----------- ------------------------------
db_recovery_file_dest.      string	  +FRA
db_recovery_file_dest_size  big         integer 100G

df -g /oracle/Q61/saparch


porcentagem do archive utilizado:
SELECT space_used/space_limit*100 used FROM V$RECOVERY_FILE_DEST;

SELECT space_used, space_limit used FROM V$RECOVERY_FILE_DEST;

Este SQL ajuda na identificação da área de archives: 
col obs format a50
set linesize 1000
SELECT DEST_ID, STATUS, 'usando RECOVERY_FILE_DEST -> ' ||decode(DESTINATION,'USE_DB_RECOVERY_FILE_DEST','YES','NO') RECOVERY_FILE_DEST,
decode(substr(decode(DESTINATION,'USE_DB_RECOVERY_FILE_DEST',(select value from v$parameter where name='db_recovery_file_dest'),DESTINATION),1,1),'+','Verifique diskgroup: ',
'Verifique filesystem: df -k ')||
decode(DESTINATION,'USE_DB_RECOVERY_FILE_DEST',(select value from v$parameter where name='db_recovery_file_dest'),DESTINATION) OBS
FROM v$archive_dest WHERE status<>'INACTIVE' ;
 
  DEST_ID STATUS   RECOVERY_FILE_DEST 	              OBS
--------- -------- -------------------------------- -----------------------------------
        1 VALID     usando RECOVERY_FILE_DEST -> YES Verifique diskgroup: +FRA
 


 set linesize 1000
 set pagesize 1000
select file_type
,      percent_space_used
,      percent_space_reclaimable
,      number_of_files
from   v$recovery_area_usage;

------------- verifica archive log dest----------------
--------------log_archive_dest--------------------

 set linesize 150
 set pagesize 100
 col destination format a40
 col dest_name format a30
select dest_name,status,destination from V$ARCHIVE_DEST;

alter system set log_archive_dest_state_3=enable;

alter system set db_recovery_file_dest='+RECO' scope=both;
alter system switch logfile;
alter system switch logfile;
alter system checkpoint;