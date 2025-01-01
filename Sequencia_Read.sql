set pagesize 1000
set linesize 1000
col megas format 9999990.00
COL FILE_NAME FORMAT A110
SELECT SID, EVENT, SECONDS_IN_WAIT FROM V$SESSION_WAIT WHERE WAIT_CLASS != 'Idle' ORDER BY SECONDS_IN_WAIT;


col c1 heading 'Average Waits|forFull| Scan Read I/O'        format 9999.999
col c2 heading 'Average Waits|for Index|Read I/O'            format 9999.999
col c3 heading 'Percent of| I/O Waits|for Full Scans'        format 9.99
col c4 heading 'Percent of| I/O Waits|for Index Scans'       format 9.99
col c5 heading 'Starting|Value|for|optimizer|index|cost|adj' format 999
select
   a.average_wait                                  c1,
   b.average_wait                                  c2,
   a.total_waits /(a.total_waits + b.total_waits)  c3,
   b.total_waits /(a.total_waits + b.total_waits)  c4,
   (b.average_wait / a.average_wait)*100           c5
from
  v$system_event  a,
  v$system_event  b
where
   a.event = 'db file scattered read'
and
   b.event = 'db file sequential read';


   select event, total_waits, time_waited, average_wait
   from v$system_event 
   where event like '%log';


   select sequence#, first_change#, first_time, trunc(1440*(first_time - lag(first_time) over (order by first_time)))
   as time_between_switch_min
   from v$log_history where first_time > '20-JUL-23' 
   order by sequence#;

  

set pagesize 10000
set linesize 10000
col username format a20
col machine format a20
col program format a20
  SELECT 
    s.username,
    s.sid,
    s.serial#,
    p.spid AS os_process_id,
    s.program,
    s.machine,
    ROUND((ses.value/1024/1024),2) AS mb_read,
    s.sql_id,
    s.sql_child_number,
    s.sql_exec_start,
    s.sql_exec_id
FROM
    v$session s,
    v$sesstat ses,
    v$statname sn,
    v$process p
WHERE
    s.sid = ses.sid
    AND ses.statistic# = sn.statistic#
    AND sn.name LIKE 'physical read total bytes'
    AND s.paddr = p.addr
    AND s.type <> 'BACKGROUND'
    AND ROUND((ses.value/1024/1024),2) > 5500000 -- Altere este valor conforme necessário
ORDER BY
    ROUND((ses.value/1024/1024),2) DESC;






set pagesize 1000
set linesize 1000
select
se.sid,
se.event,
sum(se.total_waits) TW,
sum(se.total_timeouts) TT,
sum(se.time_waited/100) time_waited
from
v$session_event se,
v$session sess
where
sess.sid = se.sid
and sess.wait_class != 'Idle'
group by
se.sid, se.event
order by 1,3 desc;