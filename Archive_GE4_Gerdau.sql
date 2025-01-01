--verificar se o backup está rodando
set line 999
set pages 0
SELECT SESSION_KEY, INPUT_TYPE, STATUS,
       TO_CHAR(START_TIME,'dd/mm/yy hh24:mi') start_time,
       TO_CHAR(END_TIME,'dd/mm/yy hh24:mi')   end_time,
       ELAPSED_SECONDS/3600                   hrs
FROM V$RMAN_BACKUP_JOB_DETAILS
ORDER BY SESSION_KEY;


--tempo que falta para acabar o backup piece por canal(qdo chegar em 100% ele reinicia e ai diminui a area do ARCH)
select sid,serial#, context, sofar, totalwork, round(sofar/totalwork*100,2) "%_complete"
  from v$session_longops
  where  opname like 'RMAN%'
         and opname not like '%aggregate%'
         and totalwork != 0
        and sofar <> totalwork;

        select opname, sid,serial#, context, sofar, totalwork
  from v$session_longops where  opname like '%arch%';
  

   set pagesize 1000
set linesize 1000
col block for a5
col module for a10
col action for a1
SELECT s.sid, username as "user", program, module, action, logon_time as "Logon", l.*
FROM v$session s, v$enqueue_lock l;
WHERE  program like 'RMAN%' 
and l.type = 'CF' 
AND l.id1 = 0 
and l.id2 = 2;


###############################################  ASM ############################################


set lines 200
set pages 80
col total_mb for 9999999999
select group_number,name,
       type,
       total_mb,
       free_mb,
       usable_file_mb,
       ROUND(100 * NVL(usable_file_mb,0) / total_mb, 2) percent_empty
from v$asm_diskgroup
where group_number > 0
order by name;



select b.sid, b.serial#, a.spid, b.client_info
from v$process a, v$session b
where a.addr=b.paddr and client_info like 'rman%';





      alter system kill session '3868,58879' immediate;
      alter system kill session '425,30371' immediate; 
      alter system kill session '780,17079' immediate; 
   