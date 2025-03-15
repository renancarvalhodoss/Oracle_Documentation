set lines 9999
col opname for a35
SELECT SID, SERIAL#, opname, SOFAR, TOTALWORK,
ROUND(SOFAR/TOTALWORK*100,2) COMPLETE
FROM  V$SESSION_LONGOPS
WHERE
TOTALWORK != 0
AND   SOFAR != TOTALWORK
order by 1;

nohup sqlplus "/ as sysdba" @csv_26022025.sql & 
nohup sqlplus "/ as sysdba" @FNCT_RET_MSG.fnc >> FNCT_RET_MSG.fnc.log &
nohup sqlplus "/ as sysdba" @PRCD_FECPVD.prc >> PRCD_FECPVD.prc.log &


------------verificar ultimos backups 

set line 200
col START_TIME for a30
col END_TIME for a30
select SESSION_KEY, INPUT_TYPE, STATUS, OUTPUT_DEVICE_TYPE,to_char(START_TIME,'dd/mm/yy hh24:mi') start_time,to_char(END_TIME,'dd/mm/yy hh24:mi') end_time,round(elapsed_seconds/60,2) minutos from V$RMAN_BACKUP_JOB_DETAILS order by session_key;



---------verifica incremental
set line 200
col START_TIME for a30
col END_TIME for a30
select SESSION_KEY, INPUT_TYPE, STATUS, OUTPUT_DEVICE_TYPE,to_char(START_TIME,'dd/mm/yy hh24:mi') start_time,to_char(END_TIME,'dd/mm/yy hh24:mi') end_time,round(elapsed_seconds/60,2) minutos 
from V$RMAN_BACKUP_JOB_DETAILS 
where INPUT_TYPE LIKE '%INCR%'
order by session_key;

======================================================================================


col STATUS format a9
col hrs format 999.99
select SESSION_KEY, INPUT_TYPE, STATUS, to_char(START_TIME,'dd/mm/yy hh24:mi') start_time, to_char(END_TIME,'dd/mm/yy hh24:mi')  end_time, elapsed_seconds/3600 hrs 
from V$RMAN_BACKUP_JOB_DETAILS order by session_key;




SELECT SID,
SERIAL#,
START_TIME,
((SOFAR/TOTALWORK)*100),'%',
MESSAGE
FROM V$SESSION_LONGOPS
WHERE TIME_REMAINING > 0 ORDER BY start_time;