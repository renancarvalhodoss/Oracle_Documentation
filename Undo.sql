 col "ACTUAL UNDO SIZE [MByte]" for 999999999
 col "UNDO RETENTION [Sec]" for a20
 col "OPTIMAL UNDO RETENTION [Sec]" for 999999999
 SELECT d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MB]",SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",(TO_NUMBER(e.value) * TO_NUMBER(f.value) *g.undo_block_per_sec) / (1024*1024) "NEEDED UNDO SIZE [MB]" 
 FROM (SELECT SUM(a.bytes) undo_size FROM v$datafile a,v$tablespace b,dba_tablespaces c 
 WHERE c.contents = 'UNDO' AND c.status = 'ONLINE' AND b.name = c.tablespace_name 
 AND a.ts# = b.ts#) d,v$parameter e, v$parameter f,
 (SELECT MAX(undoblks/((end_time-begin_time)*3600*24)) undo_block_per_sec FROM v$undostat) g 
 WHERE e.name = 'undo_retention' AND f.name = 'db_block_size';

set lines 2000
col table_name for a20
col column_name for a200
col pctversion for a10
col retention for a10
 select table_name, column_name, pctversion, retention
  from user_lobs
   where pctversion is null;
