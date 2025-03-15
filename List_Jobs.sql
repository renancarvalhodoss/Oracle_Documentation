set line 200
col START_TIME for a30
col END_TIME for a30
select  SESSION_KEY, INPUT_TYPE, STATUS, OUTPUT_DEVICE_TYPE,to_char(START_TIME,'dd/mm/yy hh24:mi') start_time,to_char(END_TIME,'dd/mm/yy hh24:mi') end_time,round(elapsed_seconds/60,2) minutos 
from V$RMAN_BACKUP_JOB_DETAILS 
order by session_key;

set pages 200
set lines 900
COLUMN sid FORMAT 99999
COLUMN serial# FORMAT 999999
COLUMN username FORMAT A15
COLUMN status FORMAT A10
COLUMN program FORMAT A20
COLUMN module FORMAT A20
-- COLUMN action FORMAT A30
COLUMN logon_time FORMAT A15
COLUMN sql_id FORMAT A15
COLUMN prev_sql_id FORMAT A15
SELECT 
    sid, 
    serial#, 
    username, 
    status, 
    program, 
    module, 
    -- action, 
    logon_time, 
    sql_id, 
    prev_sql_id
FROM 
    v$session 
WHERE 
    sql_id IN (
        SELECT 
            sql_id 
        FROM 
            v$sql 
        WHERE 
            sql_text LIKE '%+FRA/MESSAHP1_STB/ARCHIVELOG/2025_02_15/thread_1_seq_14454.887.1193173163%'
    )
ORDER BY 
    logon_time DESC;


    SELECT sql_id, sql_text
FROM v$sql
WHERE sql_id = '2h5zd97ttdaq4';




set pages 200
set lines 900
COLUMN sid FORMAT 99999
COLUMN serial# FORMAT 999999
SELECT sid, serial#, opname, sofar, totalwork, 
       ROUND(sofar/totalwork*100, 2) AS progress
FROM v$session_longops;
WHERE sid = 3776;

 set lines 200
 alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';
 select recid,stamp ,status,start_time,end_time 
 from v$rman_status 
 where status not in ('COMPLETED','FAILED','COMPLETED WITH WARNINGS','COMPLETED WITH ERRORS');


set pages 200
set lines 200
col START_TIME for a30
col END_TIME for a30
select  SESSION_KEY, INPUT_TYPE, STATUS, OUTPUT_DEVICE_TYPE,to_char(START_TIME,'dd/mm/yy hh24:mi') start_time,to_char(END_TIME,'dd/mm/yy hh24:mi') end_time,round(elapsed_seconds/60,2) minutos 
from V$RMAN_BACKUP_JOB_DETAILS  where INPUT_TYPE LIKE '%INCR%'
order by session_key;

set line 200
col START_TIME for a30
col END_TIME for a30
select  
from V$RMAN_BACKUP_JOB_DETAILS;

while sleep 60;
do jobs
done

while sleep 60; do jobs; done


SELECT SID, SERIAL#, CONTEXT, SOFAR, TOTALWORK,OPNAME,
ROUND (SOFAR/TOTALWORK*100, 2) "% COMPLETE"
FROM V$SESSION_LONGOPS
WHERE OPNAME LIKE 'RMAN%'; AND OPNAME NOT LIKE '%aggregate%';
AND TOTALWORK! = 0 AND SOFAR <> TOTALWORK

set pagesize 500
set lines 200
SELECT 'alter system kill session '''|| s.sid || ',' || s.serial# ||''' immediate;' 
  FROM gv$process p, gv$session s
 WHERE p.addr = s.paddr 
   AND client_info LIKE 'rman%';

set lines 1000
   SELECT * FROM V$TEMP_SPACE_HEADER;

set pagesize 500
set lines 200
SELECT s.sid , s.serial#, module, status ,client_info
  FROM gv$process p, gv$session s
 WHERE p.addr = s.paddr
   AND client_info LIKE 'rman%';

cx5GeQ&Eim6Fnx#h
-- To simply stop job without killing session:
BEGIN
    DBMS_SCHEDULER.STOP_JOB(JOB_NAME => 'scheme.job_name', FORCE => TRUE);
END;
-- Killing job's session: first get Job session IDs
SELECT jr.JOB, s.USERNAME, s.SID, s.SERIAL#, p.SPID, s.LOCKWAIT, s.LOGON_TIME
FROM DBA_JOBS_RUNNING jr, V$SESSION s, V$PROCESS p
WHERE jr.SID = s.SID AND s.PADDR = p.ADDR
ORDER BY jr.JOB;

hotsm001mul event standard weekly_backup node=goodell enddate=today+7
query event nodes=joe domain2 standard begindate=02/26/2002 enddate=02/27/2002 format=detailed
query event standard SP1FRHODB201_CORAD_PRM02_RST node=sp1frhodb202

set pagesize 500
set lines 200
col JOB_NAME for a30
col DESTINATION for a30
col OWNER for a30
select job_name,DESTINATION,RUNNING_INSTANCE,SESSION_ID,OWNER from dba_scheduler_running_jobs where job_name like '%JOB_TRS_VENDA_PAGTO_SANG_%';


SELECT 
    job_name,
    log_date,
    status,
    additional_info
FROM 
    dba_scheduler_job_log
WHERE 
    job_name LIKE 'JOB_TRS_VENDA_PAGTO_SANG_%'
     AND trunc(log_date) = trunc(SYSDATE)
     AND status = 'SUCCEEDED'
ORDER BY 
    log_date ASC;




SELECT  to_char(round(sysdate-nvl(MAX(rd.start_time),sysdate-10000)))
            FROM   v$rman_backup_job_details RD,v$backup_set_details SD
            where  rd.session_recid = sd.session_recid AND RD.status='COMPLETED' and
            (rd.input_type='DB FULL' or (rd.input_type='DB INCR' AND sd.incremental_level=0));



            
------------------verifica backups em execucao-------------------------------------
set line 999
set pages 0

SELECT  SESSION_KEY, INPUT_TYPE, STATUS,COMMAND_ID,
       TO_CHAR(START_TIME,'dd/mm/yy hh24:mi') start_time,
       TO_CHAR(END_TIME,'dd/mm/yy hh24:mi')   end_time,
       ELAPSED_SECONDS/3600                   hrs
FROM V$RMAN_BACKUP_JOB_DETAILS
ORDER BY SESSION_KEY;

------------verifica sid e serial de job em execucao--------------------
set line 999
col MODULE for a20
select b.sid, a.PID, b.serial#, a.spid, b.MODULE, status
from v$process a, v$session b
where a.addr=b.paddr
and client_info like 'rman%' and status = 'ACTIVE';

------------verifica porcetange para o termino do bkp ---------------------
set line 999
col MESSAGE for a90
SELECT SID,
SERIAL#,
START_TIME,
((SOFAR/TOTALWORK)*100),'%',
MESSAGE
FROM V$SESSION_LONGOPS
WHERE TIME_REMAINING > 0 ORDER BY start_time;

-------------kill backup-----------------------------
alter system kill session '462,57455' immediate; 
alter system kill session '33,33345' immediate;
alter system disconnect session '455,61124' immediate;

alter system kill session '1600,64908' immediate;
alter system kill session '3855,4819' immediate;
alter system kill session '1609,38830' immediate;
alter system kill session '3868,9583' immediate;

select 'alter system kill session '''||sid||','||serial#||''' immediate;' from v$session where client_info like 'rman%';




SQL> select CAPTURE_NAME, CAPTURE_TYPE, STATUS from DBA_CAPTURE;


alter system kill session '3892,59469' immediate;
alter system kill session '613,23112' immediate;


      prompt
prompt
prompt +----------------+
prompt |Connected users |
prompt +----------------+
prompt
prompt
set lines 100 pages 999
set linesize 505
col ID         format a12
col username     format a20
col status     format a10
col machine     format a22
col program     format a40
select  username
,       sid || ',' || serial# "ID"
,       status
,    machine
,    program
,    logon_time
,    osuser
--,    action
from
    v$session
where
    username is not null
order by
    status desc
,       last_call_et desc;



SELECT 
*
FROM 
    V$BACKUP_DATAFILE;









set lin 200 pages 500
COLUMN osuser FOR A10
COLUMN username FOR A12
COLUMN inst_id FOR 99
COLUMN sid FOR 99999
COLUMN serial# FOR 999999
COLUMN spid FOR A6
COLUMN message FOR A40 WORD_WRAPPED

SELECT s.inst_id, s.SID, s.serial#, p.spid,
       s.username, s.osuser,
       l.sql_address, 
       -- l.sql_id,
       ROUND((sofar/DECODE(totalwork,0,1,totalwork))*100,2) "% COMPLETED", time_remaining,
       l.message
  FROM gv$session_longops l
  JOIN gv$session s
    ON (s.inst_id = l.inst_id AND s.SID = l.SID AND s.serial# = l.serial#)
  JOIN gv$process p
    ON (p.inst_id = s.inst_id AND p.addr = s.paddr)
WHERE ROUND((sofar/DECODE(totalwork,0,1,totalwork))*100,2) != 100
   AND l.time_remaining IS NOT NULL
   and l.message like '%RMAN%'
ORDER BY ROUND((sofar/DECODE(totalwork,0,1,totalwork))*100,2) DESC;
















SELECT 
    job_name,
    running_instance,
    session_id,
    owner,
    SYSDATE - start_date AS duration_in_days,
    ROUND((SYSDATE - start_date) * 24 * 60, 2) AS duration_minutes
FROM 
    dba_scheduler_running_jobs
WHERE 
    job_name LIKE '%JOB_TRS_VENDA_PAGTO_SANG_%'
ORDER BY 
    duration_in_days DESC;

ALTER SYSTEM KILL SESSION '1490, 46283';




SELECT status_integracao, count(1)
FROM dbcsi_dsp.transacao_p2k
WHERE TRUNC(data_transacao) = TRUNC(SYSDATE) 
  AND status_integracao IN ('PR', 'NP')
GROUP BY status_integracao
ORDER BY status_integracao;
