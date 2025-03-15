-- identifica quantidade de processo em execucao
set lines 2000
SET PAGESIZE 20000
col RESOURCE_NAME for a30
select RESOURCE_NAME, CURRENT_UTILIZATION, MAX_UTILIZATION,  ROUND((CURRENT_UTILIZATION/MAX_UTILIZATION)*100, 2) pct_used
from v$resource_limit 
where RESOURCE_NAME = 'processes';

-- identifica quantidade de processos inativos
SELECT count(*) as POCESSOS_INATIVOS
FROM v$session
WHERE status = 'INACTIVE';

-- listar processos inativos
SELECT sid, serial#, username, program, status, schemaname
FROM v$session
WHERE status = 'INACTIVE'
ORDER BY last_call_et DESC;

SELECT sql_id, executions, disk_reads, buffer_gets
FROM v$sql
ORDER BY buffer_gets DESC
FETCH FIRST 10 ROWS ONLY;

-- cria query pra kill em processos inativos
set pagesize 0
select 'alter system kill session '''||sid||','||serial#||''' immediate;' from v$session where status='INACTIVE';

select 'kill -9 ' || p.SPID, s.USERNAME, 'alter system kill session '''||sid||',' || s.serial# || ''';',s.STATUS
from v$session s, v$process p
where s.PADDR = p.ADDR (+)
and s.STATUS='INACTIVE'
order by 1;

alter system kill session '2316,16809' immediate;
alter system kill session '23,4495' immediate;
alter system kill session '45,913' immediate;