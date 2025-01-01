SQL> select name, storage_size from v$restore_point;

-- CHECK DATABASE OFFENDER
set lines 200 pages 200
col dbname for a15
col diskgroup for a30
break on diskgroup
SELECT  diskgroup, dbname, round(sum(space/1024/1024/1024),1) GB 
FROM
    ( SELECT 
        substr(SYS_CONNECT_BY_PATH(a.name, '/'),2,instr(SYS_CONNECT_BY_PATH(a.name, '/'),'/',2)-2) dbname 
        , CONCAT(g.name, NULL) diskgroup 
        , f.space              space 
      FROM 
          v$asm_file f RIGHT OUTER JOIN v$asm_alias     a USING (group_number, file_number) 
                                   JOIN v$asm_diskgroup g USING (group_number) 
WHERE f.type IS NOT NULL
START WITH (MOD(a.parent_index, POWER(2, 24))) = 0
    CONNECT BY PRIOR a.reference_index = a.parent_index 
    ) 
group by diskgroup,dbname
order by 1,2 desc; 



--CHECK WHAT IS USING FRA
set pages 2000
set lines 2000
select * from V$FLASH_RECOVERY_AREA_USAGE;

-- CHECK USED FRA SPACE
set pages 2000
set lines 2000
col name format a15
clear breaks
clear computes 
set lines 280
select name
,      round(space_limit / 1024 / 1024) size_mb
,      round(space_used  / 1024 / 1024) used_mb
,      decode(nvl(space_used,0),0,0,round((space_used/space_limit) * 100)) pct_used
from v$recovery_file_dest
order by name;



-- CHECK PATH FRA 
SHOW parameter db_recovery_file_dest

-- por padrao a seguntes pastas amarzenarao
archivelog: armazena os archives ciados no banco .arc
backupset: armazena os backups realizados .bkp
autobackup: armazena o bkp do SPfile e Controfile .arc

drwxr-x---   2 oracle oinstall  4096 Oct 25  2017 controlfile
drwxr-x---   2 oracle oinstall  4096 Oct 25  2017 onlinelog
drwxr-x---   3 oracle oinstall  4096 Jul 18  2023 backupset
drwxr-x---   5 oracle oinstall  4096 Jul 18  2023 autobackup
drwxr-x--- 489 oracle oinstall 20480 Dec 30 08:00 archivelog

-- ALTER THE FRA PATH
--altera o caminho dos archives
ALTER SESSION SET LOG_ARCHIVE_DEST_1='LOCATION=+GROBSMP_DATA';

--atera o caminho padrao dos backups
ALTER SYSTEM SET DB_RECOVERY_FILE_DEST='+GROBSMP_DATA' SCOPE=BOTH;

ALTER SYSTEM SET LOG_ARCHIVE_DEST_STATE_1='ENABLE' SCOPE=BOTH;

-- ALTER FRA SIZE
ALTER system  SET db_recovery_file_dest_size=128000M  scope=BOTH ;  

NAME       SIZE_MB    USED_MB   PCT_USED
------- ---------- ---------- ----------
+FRA        716800     701339         98




set linesize 121
col name format a26
col time format a32
col scn format 99999999999999
SELECT name, scn, time, database_incarnation#, guarantee_flashback_database, (storage_size/1024/1024/1024) SIZE_GB
FROM gv$restore_point;

ALTER DATABASE FLASHBACK ON;

ALTER DATABASE FLASHBACK OFF;

SELECT
    SUM(bytes) / (1024 * 1024) AS total_size_mb
FROM
    v$flashback_database_log;