SELECT al.thrd "Thread", almax "Last Seq Received", lhmax "Last Seq Applied" , (almax-lhmax) GAP
FROM (select thread# thrd, MAX(sequence#) almax FROM v$archived_log WHERE resetlogs_change#=(SELECT resetlogs_change# FROM v$database) GROUP BY thread#) al,
(SELECT thread# thrd, MAX(sequence#) lhmax
FROM v$log_history WHERE resetlogs_change#=(SELECT resetlogs_change# FROM v$database) GROUP BY thread#) lh WHERE al.thrd = lh.thrd;

set lines 999
set pagesize 999
 col DESTINATION for a12
SELECT DEST_ID "ID",
  STATUS "DB_status",
   DESTINATION "Archive_dest",
 ERROR "Error"
 FROM V$ARCHIVE_DEST;

Select
   THREAD#,
   LOW_SEQUENCE#,
   HIGH_SEQUENCE#
From
   V$ARCHIVE_GAP;
   
 col value for a12
 col con_id for a2
  col SOURCE_DBID SOURCE_DB_UNIQUE_NAME for a2
 select * from v$dataguard_stats;

SELECT ARCH.THREAD# "Thread", ARCH.SEQUENCE# "Last Sequence Received", APPL.SEQUENCE# "Last Sequence Applied", (ARCH.SEQUENCE# - APPL.SEQUENCE#) "Difference"
FROM
(SELECT THREAD# ,SEQUENCE# FROM V$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$ARCHIVED_LOG GROUP BY THREAD#)) ARCH,
(SELECT THREAD# ,SEQUENCE# FROM V$LOG_HISTORY WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$LOG_HISTORY GROUP BY THREAD#)) APPL
WHERE
ARCH.THREAD# = APPL.THREAD#;



  select thread#,max(primary) primary, max(transf) transf,
        max(standby) standby, MAX(primary)-MAX(transf) transf_gap, MAX(primary)-MAX(standby) apply_gap,
        max(timegap) hoursgap
  from (
  SELECT thread#,max(sequence#) primary, 0 transf, 0 standby, 0 timegap
      FROM v$archived_log
      WHERE archived = 'YES'
        AND resetlogs_change# = ( select d.resetlogs_change# from v$database d )
  GROUP BY thread#
  union all
  SELECT thread#,0 primary, max(sequence#) transf, 0 standby, 0 timegap
      FROM v$archived_log
      WHERE STANDBY_DEST='YES'
        and archived = 'YES'
        AND resetlogs_change# = ( select d.resetlogs_change# from v$database d )
  GROUP BY thread#
  union all
  SELECT thread#,0 primary, 0 transf, max(sequence#) standby, trunc((sysdate-max(FIRST_TIME))*24) timegap
      FROM v$archived_log
      WHERE STANDBY_DEST='YES'
        and applied = 'YES'
        AND resetlogs_change# = ( select d.resetlogs_change# from v$database d )
  GROUP BY thread#
  ) asd
  group by thread#
  order by 1
  /










col name for a20;
alter session set nls_date_format='DD-MM-YYYY HH24:MI:SS';
select RECID,NAME,DEST_ID,THREAD#,SEQUENCE#,APPLIED,COMPLETION_TIME from v$archived_log where dest_id=2 and COMPLETION_TIME > CURRENT_TIMESTAMP - 0.1 order by 7;

select RECID,NAME,DEST_ID,THREAD#,SEQUENCE#,APPLIED,COMPLETION_TIME from v$archived_log where dest_id=2 and APPLIED = 'NO' order by 7 desc;

select RECID,NAME,DEST_ID,THREAD#,SEQUENCE#,APPLIED,COMPLETION_TIME from v$archived_log where dest_id=2 order by 7 asc;











O MRP esta no ar sem poblema de interrupcao, evidencias abaixo

 SQL>  select instance_name,host_name from v$instance;

INSTANCE_NAME
----------------
HOST_NAME
----------------------------------------------------------------
CARDUSDG
hodb004rc.riocardti.com.br


SQL> select process,status from v$managed_standby;

PROCESS   STATUS
--------- ------------
ARCH      CLOSING
ARCH      CLOSING
ARCH      CLOSING
ARCH      CLOSING
RFS       IDLE
RFS       IDLE
RFS       IDLE
RFS       IDLE
MRP0      APPLYING_LOG
RFS       IDLE
RFS       IDLE

PROCESS   STATUS
--------- ------------
RFS       IDLE
RFS       IDLE

13 rows selected.