----identifica o standby-----------

SELECT * FROM V$DATAGUARD_CONFIG;
SELECT DEST_ID, STATUS, DESTINATION, ERROR FROM V$ARCHIVE_DEST;

--No banco de dados primário, você pode verificar se os logs estão sendo enviados para o standby:
SELECT SEQUENCE#, DEST_ID, STATUS, APPLIED
FROM V$ARCHIVED_LOG
WHERE DEST_ID = 2
ORDER BY SEQUENCE# DESC;

-- CHECK THE QUANTITY OF GAP with column status 
SELECT al.thrd "Thread",
       almax "Last Seq Received",
       lhmax "Last Seq Applied",
       (almax - lhmax) GAP,
       CASE
           WHEN almax = lhmax THEN 'Synchronized'
           ELSE 'Not Synchronized'
       END AS "Sync Status"
FROM (SELECT thread# thrd, MAX(sequence#) almax 
      FROM v$archived_log 
      WHERE resetlogs_change# = (SELECT resetlogs_change# FROM v$database) 
      GROUP BY thread#) al,
     (SELECT thread# thrd, MAX(sequence#) lhmax 
      FROM v$log_history 
      WHERE resetlogs_change# = (SELECT resetlogs_change# FROM v$database) 
      GROUP BY thread#) lh 
WHERE al.thrd = lh.thrd;

col name for a15
SELECT SEQUENCE#, FIRST_TIME, NEXT_TIME, NAME
FROM V$ARCHIVED_LOG
WHERE SEQUENCE# BETWEEN 210120 AND 210122
ORDER BY SEQUENCE#;


-- verifica recebido e aplicado standby
SELECT sequence#, first_time, next_time, applied, status
FROM v$archived_log
WHERE sequence# BETWEEN 210257 AND 210120
ORDER BY sequence#;


-- CHECK THE QUANTITY OF GAP
SELECT al.thrd "Thread", almax "Last Seq Received", lhmax "Last Seq Applied" , (almax-lhmax) GAP
FROM (select thread# thrd, MAX(sequence#) almax FROM v$archived_log WHERE resetlogs_change#=(SELECT resetlogs_change# FROM v$database) GROUP BY thread#) al, (SELECT thread# thrd, MAX(sequence#) lhmax 
FROM v$log_history WHERE resetlogs_change#=(SELECT resetlogs_change# FROM v$database) 
GROUP BY thread#) lh WHERE al.thrd = lh.thrd;


-- CHECK THE LATEST APLICATIONS
select sequence#, applied, first_time, next_time, name filename from v$archived_log  where applied='NO' order by sequence#;

ou

alter session set nls_date_format ='dd-mm-yyyy hh24:mi:ss';
set lines 200
col filename for a60
select sequence#, applied, first_time, next_time, name filename from v$archived_log where FIRST_TIME > ('&data') order by sequence#;


set lines 100
select b.instance_name,a.THREAD# "Thread",a.SEQUENCE# "Sequencia",to_char(a.FIRST_TIME
     ,'dd-mon-yyyy hh24:mi:ss')"Data da Sequencia", to_char(sysdate,'dd-mon-yyyy hh24:mi:ss') "Data Atual"
from   v$log_history a,v$instance b
where (a.THREAD#,a.SEQUENCE#) in
      ( select THREAD#, max(SEQUENCE#)
        from v$log_history group by THREAD#)
order by 2;




-- CHECK IF THE APLLY PROCESS IS RUNNING 
select process,status from v$managed_standby;

-- CHECK THE APLLY LOGS, TO FIND ERRORS 
select message from v$dataguard_status;


-- GAP, execute in standby database  
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE  DISCONNECT FROM SESSION;

set lines 100
col NAME for a40
SELECT 
    SEQUENCE#, THREAD#, ARCHIVED, 
    NAME, FIRST_TIME, NEXT_TIME
FROM 
    V$ARCHIVED_LOG 
WHERE 
    SEQUENCE# = '14454' AND ARCHIVED = 'YES';



--TURN OFF PROCESS MRPO
alter database recover managed standby database cancel;

--TURN ON PROCESS MRP0
alter database recover managed standby database using current logfile disconnect from session;

--CHECK IF THE MRP0 PROCESS IS APPLYING_LOG
select process, client_process, sequence#, status from V$managed_standby;