-- Waits
col USERNAME for a15
col EVENT for a10
col STATE for a10
select w.sid,s.username, w.event, w.state, w.wait_time, w.seconds_in_wait
from gv$session_wait w, gv$session s
where s.sid=w.sid and s.status='ACTIVE'
and w.seconds_in_wait > 0
and w.sid in (1192)
and s.username != 'unknown'
and s.type     != 'background'
and s.osuser   != 'oracle'
order by 4, 5;

---Locks
set linesize 1000
SELECT  (SELECT trim(s1.USERNAME)||'-'||trim(s1.osuser)||'-status:'||status||'-spid:'||p1.spid
 FROM   V$SESSION s1, v$process p1
 WHERE  s1.SID = A.SID and s1.paddr=p1.addr) ||'-sid:'||
 A.SID||     '- BLOQUEANDO:'||
 (SELECT trim(USERNAME)||'-'||trim(osuser)
 FROM   V$SESSION
 WHERE  SID=B.SID) ||'-sid:'||
 B.SID
 FROM    V$LOCK A, V$LOCK B
WHERE   A.BLOCK     = 1
 AND B.REQUEST   > 0
 AND A.ID1       = B.ID1
 AND A.ID2       = B.ID2;



 -----------waits free
set linesize 1000
col USERNAME for a15
col EVENT for a50
col STATE for a10
 select w.sid,s.username, w.event, w.state, w.wait_time, w.seconds_in_wait
from gv$session_wait w, gv$session s
where s.sid=w.sid and s.status='ACTIVE'
and s.username != 'unknown'
and s.type     != 'background'
and s.osuser   != 'oracle'
order by 4, 5;

 col USERNAME for a15
col EVENT for a10
col STATE for a10
 select w.sid,s.username, w.event, w.state, w.wait_time, w.seconds_in_wait
from gv$session_wait w, gv$session s
where s.sid=w.sid and s.status='ACTIVE'
and s.username = 'REFCENT_USER'
and s.type     != 'background'
and s.osuser   != 'oracle'
order by 4, 5;

 select w.sid,s.username, w.event, w.state, w.wait_time, w.seconds_in_wait
from gv$session_wait w, gv$session s
where s.sid=w.sid and s.status='ACTIVE'
and s.username != 'unknown'
and s.osuser   != 'oracle'
order by 4, 5;

set lines 999
col USER# for a20
col CLIENT_IDENTIFIER for a20
 select SID,EVENT,USER#, SERIAL#,STATUS,PROCESS,wait_time,seconds_in_wait
from
   v$session;
where
   type ='BACKGROUND'
   and username != 'unknown'
   and SID ='2276';


-----------VERIFY LOCK ON SPECIFIC TABLE -----------------
col sid_serial for a10
col object_name for a30
col lock_mode for a10
col OS_USER_NAME for a12
col OS_USER for a10
col LAST_DDL for a10
SELECT l.session_id||','||v.serial# sid_serial,
 l.ORACLE_USERNAME ora_user,
 l.OS_USER_NAME,
 o.object_name, 
 o.object_type, 
 DECODE(l.locked_mode,
 0, 'None',
 1, 'Null',
 2, 'Row-S (SS)',
 3, 'Row-X (SX)',
 4, 'Share',
 5, 'S/Row-X (SSX)',
 6, 'Exclusive', 
 TO_CHAR(l.locked_mode)
 ) lock_mode,
 o.status,  
 to_char(o.last_ddl_time,'dd.mm.yy') last_ddl
FROM dba_objects o, gv$locked_object l, v$session v
WHERE o.object_id = l.object_id
 and l.SESSION_ID=v.sid
order by 2,3;



select sid, serial#, username, machine,
(select * from v$sqlcommand where cmmand_type = command) as COMMAND_NAME
from v$session
where username is not null and COMMAND_NAME is not null;


select sid, serial#, username, STATUS, last_call_et
from v$session
where 
status = 'INACTIVE' and username = 'CONTROL'
ORDER by 5;
(blocking_session is not null
or sid in (select distinct blocking_session from v$session) );

set pages 900
set linesize 900
column HOST for a10
column USERNAME for a10
column DB_LINK for a20

SELECT DB_LINK, HOST, USERNAME 
FROM DBA_DB_LINKS
WHERE DB_LINK = 'DBLINK_KNAPP_PRD_WMS';




set verify off
set echo off
set pages 1500
set linesize 110
set heading off;
select '' from dual;
SELECT 'Data/Hora:', TO_CHAR(SYSDATE, 'fmDD month yyyy fmHH:MI:SS AM') FROM DUAL;
select '' from dual;
column sid format 9999999999
column username format a30
column "Logon Time" format a32
column blocking_session format 9999999999
column program format a30;
column machine format a30;
select
'SID..........................................: '||sid,
'SERIAL#......................................: '||serial#,
'STATUS.......................................: '||status,
'SQL_ID.......................................: '||sql_id,
'CHILDN.......................................: '||SQL_CHILD_NUMBER,
'module.......................................: '||module,
'terminal.....................................: '||terminal,
'USERNAME.....................................: '||username,
'Logon Time...................................: '||TO_CHAR(logon_time, 'fmDD month yyyy fmHH:MI:SS AM')  ,
'PROGRAM......................................: '||program,
'MACHINE......................................: '||machine,
'started......................................: '||round(SECONDS_IN_WAIT/60,1) as "Wait(min)" ,
'last_call ...................................: '||last_call_et/60,
'last_call Hr.................................: '||to_char(sysdate-last_call_et/24/60/60,'hh24:mi:ss'),
'EVENT........................................: '||EVENT,
'EVENT#.......................................: '||EVENT#,
'PREV_SQL_ID..................................: '||PREV_SQL_ID
from gv$session where SID = '1192';






set LINES 1500
set pages 600

prompt ==================================
prompt BLOCKING SESSIONS
prompt ==================================



col osuser      format a10
col username    format a10
col sid         format a50
col serial#     format a10
col status      format a10
col machine     format a10
col logon_time  format a10
col terminal    format a10
col program     format a10
col lockwait    format a10
col SQL_ID    format a6
col PREV_SQL_ID    format a6
col INSTANCIA_BLOQUEADA format a6
col SESSAO_BLOQUEADA format a6
col SESSAO_BLOQUEADORA format a6

SELECT LH.INST_ID INSTANCIA_BLOQUEADORA, LH.SID SESSAO_BLOQUEADORA, sh.serial#, sh.osuser,sh.username,sh.status,sh.last_call_et lcet, sh.sql_id, sh.prev_sql_id,
       LW.INST_ID INSTANCIA_BLOQUEADA,   LW.SID SESSAO_BLOQUEADA,   sw.osuser,sw.username,sw.status,sw.last_call_et lcet, sw.sql_id, sw.prev_sql_id,
       DECODE(LH.TYPE, 'MR', 'MEDIA_RECOVERY',
                       'RT', 'REDO_THREAD',
                       'UN', 'USER_NAME',
                       'TX', 'TRANSACTION',
                       'TM', 'DML',
                       'UL', 'PLSQL USER_LOCK',
                       'DX', 'DISTRTED_TRANSAXION',
                       'CF', 'CONTROL_FILE',
                       'IS', 'INSTANCE_STATE',
                       'FS', 'FILE_SET',
                       'IR', 'INSTANCE_RECOVERY',
                       'ST', 'DISKSPACE TRANSACTION',
                       'IV', 'LIBCACHE_INVALIDATION',
                       'LS', 'LOGSTAARTORSWITCH',
                       'RW', 'ROW_WAIT',
                       'SQ', 'SEQUENCE_NO',
                       'TE', 'EXTEND_TABLE',
                       'TT', 'TEMP_TABLE', 'NOTHING-') WAITER_LOCK_TYPE,
       DECODE(LW.REQUEST, 0, 'NONE',
                          1, 'NOLOCK',
                          2, 'ROW-SHARE',
                          3, 'ROW-EXCLUSIVE',
                          4, 'SHARE-TABLE',
                          5, 'SHARE-ROW-EXCLUSIVE',
                          6, 'EXCLUSIVE', 'NOTHING-') WAITER_MODE_REQ
FROM GV$LOCK LW,
     gv$session sw,
     GV$LOCK LH,
     gv$session sh
WHERE LH.ID1     = LW.ID1
  AND LH.ID2     = LW.ID2
  AND LH.REQUEST = 0
  AND LW.LMODE   = 0
  and sw.inst_id = lw.inst_id
  and sw.sid     = lw.sid
  and sh.inst_id = lh.inst_id
  and sh.sid     = lh.sid
  AND (LH.ID1, LH.ID2) IN
  (
    SELECT ID1, ID2
    FROM GV$LOCK
    WHERE REQUEST = 0
    INTERSECT
    SELECT ID1, ID2
    FROM GV$LOCK
    WHERE LMODE   = 0
  )
/



/*
select
  s.INST_ID,
  s.OSUSER,
  s.USERNAME,
  s.SID,
  s.SERIAL#,
  s.LAST_CALL_ET,
  --sysdate-s.LAST_CALL_ET/60/60/24 last_active_time,
  s.STATUS,
  --s.SERVER,
  --s.TERMINAL,
  s.MACHINE,
  --s.LOGON_TIME,
  s.PROGRAM,
  --s.MODULE,
  --s.ACTION,
  s.LOCKWAIT,
  s.sql_hash_value,
  G.TYPE,
  --S.PROCESS,
  DECODE(LMODE,  0,'None',
                 1,'Null',
                 2,'Row-S',
                 3,'Row-X',
                 4,'Share',
                 5,'S/ROW',
                 6,'Exclusive')        LMODE,
  DECODE(REQUEST,0,'None',
                 1,'Null',
                 2,'Row-S',
                 3,'Row-X',
                 4,'Share',
                 5,'S/ROW',
                 6,'Exclusive')        REQUEST,
  DECODE(REQUEST,0,'BLOCKER','WAITER') STATE,
  o.object_name,o.object_type
FROM GV$GLOBAL_BLOCKED_LOCKS G,
     GV$SESSION              S,
     dba_objects             o
WHERE G.SID           = S.SID
  AND G.INST_ID       = S.INST_ID
  and o.object_id (+) = s.ROW_WAIT_OBJ#
ORDER BY STATE;
*/

















set lines 200 pages 50000
col inst        format 999
col osuser      format a15
col username    format a20
col blocker     format 9999
col blocked     format 9999
col serial#     format 999999
col status      format a10
col logon_time  format a20
col lcet        format 9999999
SELECT /*+ rule */ distinct
       LH.INST_ID inst, LH.SID BLOCKER, sh.serial#, sh.osuser,sh.username,sh.status,sh.last_call_et lcet,sh.row_wait_obj# objid,decode(sh.lockwait,null,null,'LOCKED') locked,sh.sql_hash_value, sh.SQL_ID,count(*) qtd
FROM GV$LOCK LW, gv$session sw,
     GV$LOCK LH, gv$session sh
WHERE LH.ID1     = LW.ID1
  AND LH.ID2     = LW.ID2
  AND LH.REQUEST = 0
  AND LW.LMODE   = 0
  and sw.inst_id = lw.inst_id
  and sw.sid     = lw.sid
  and sh.inst_id = lh.inst_id
  and sh.sid     = lh.sid
  AND (LH.ID1, LH.ID2) IN
  (
    SELECT ID1, ID2 FROM GV$LOCK WHERE REQUEST = 0
    INTERSECT
    SELECT ID1, ID2 FROM GV$LOCK WHERE LMODE   = 0
  )
  and sh.lockwait is null
group by LH.INST_ID, LH.SID, sh.serial#, sh.osuser,sh.username,sh.status,sh.last_call_et,sh.row_wait_obj#,decode(sh.lockwait,null,null,'LOCKED'),sh.sql_hash_value,sh.SQL_ID;

select distincts, id from v$mystat;

set lines 2000
col object_name format a45
select owner, object_name, object_type, status from dba_objects where object_name = 'STG_OFERTA_REL_ITEM';


set verify off
set echo off
set pages 1500
set linesize 110
set heading off;
select '' from dual;
SELECT 'Data/Hora:', TO_CHAR(SYSDATE, 'fmDD month yyyy fmHH:MI:SS AM') FROM DUAL;
select '' from dual;
column sid format 9999999999
column username format a30
column "Logon Time" format a32
column blocking_session format 9999999999
column program format a30;
column machine format a30;
select
'SID..........................................: '||sid,
'SERIAL#......................................: '||serial#,
'STATUS.......................................: '||status,
'SQL_ID.......................................: '||sql_id,
'CHILDN.......................................: '||SQL_CHILD_NUMBER,
'module.......................................: '||module,
'terminal.....................................: '||terminal,
'USERNAME.....................................: '||username,
'Logon Time...................................: '||TO_CHAR(logon_time, 'fmDD month yyyy fmHH:MI:SS AM')  ,
'PROGRAM......................................: '||program,
'MACHINE......................................: '||machine,
'started......................................: '||round(SECONDS_IN_WAIT/60,1) as "Wait(min)" ,
'last_call ...................................: '||last_call_et/60,
'last_call Hr.................................: '||to_char(sysdate-last_call_et/24/60/60,'hh24:mi:ss'),
'EVENT........................................: '||EVENT,
'EVENT#.......................................: '||EVENT#,
'PREV_SQL_ID..................................: '||PREV_SQL_ID
from gv$session where sid = '1192';
547,5588  
set lines 2000
set pages 2000
select SQL_ID, LAST_ACTIVE_TIME, EXECUTIONS, OBJECT_STATUS from v$sql; where SQL_TEXT LIKE '%STG_OFERTA_REL_ITEM%' ;

select OWNER,OBJECT_NAME,PROCEDURE_NAME,OBJECT_ID
 from all_procedures
 where  OBJECT_NAME like '%STG_OFERTA_REL_ITEM%';

 SELECT 
    object_name
FROM 
    user_procedures
WHERE
    object_type like '%SP_JOB_TRS_VENDA_PAGTO_SANG%';

Select TEXT
From USER_SOURCE;
Where NAME LIKE '%VENDA%'
Order by LINE;


set lines 2000
set pages 2000
select SQL_ID, LAST_ACTIVE_TIME, SQL_TEXT, EXECUTIONS, OBJECT_STATUS from v$sql where SQL_ID = '99pk53nqa027r' ;

set lines 1000
set pages 100
col sql_id for a20
select  RUNTIME_MEM, PLSQL_EXEC_TIME, CONCURRENCY_WAIT_TIME, APPLICATION_WAIT_TIME 
from v$sql where SQL_ID = '99pk53nqa027r'; and   sid in (select blocking_session from gv$session);


set verify off
set echo off
set pages 1500
set linesize 110
set heading off;
select '' from dual;
SELECT 'Data/Hora:', TO_CHAR(SYSDATE, 'fmDD month yyyy fmHH:MI:SS AM') FROM DUAL;
select '' from dual;
column sid format 9999999999
column username format a30
column "Logon Time" format a32
column blocking_session format 9999999999
column program format a30;
column machine format a30;
select
'SID..........................................: '||sid,
'SERIAL#......................................: '||serial#,
'STATUS.......................................: '||status,
'SQL_ID.......................................: '||sql_id,
'CHILDN.......................................: '||SQL_CHILD_NUMBER,
'module.......................................: '||module,
'terminal.....................................: '||terminal,
'USERNAME.....................................: '||username,
'Logon Time...................................: '||TO_CHAR(logon_time, 'fmDD month yyyy fmHH:MI:SS AM')  ,
'PROGRAM......................................: '||program,
'MACHINE......................................: '||machine,
'started......................................: '||round(SECONDS_IN_WAIT/60,1) as "Wait(min)" ,
'last_call ...................................: '||last_call_et/60,
'last_call Hr.................................: '||to_char(sysdate-last_call_et/24/60/60,'hh24:mi:ss'),
'EVENT........................................: '||EVENT,
'EVENT#.......................................: '||EVENT#,
'PREV_SQL_ID..................................: '||PREV_SQL_ID
from gv$session where SQL_ID = '99pk53nqa027r';



COL SID FORMAT A4
COL USERNAME FORMAT A5
COL SQL_HASH_VALUE FORMAT 99999999
COL SQLID FORMAT A14
COL SQL_CHILD_NUMBER FORMAT 9
COL NAME FORMAT A4
COL VALUE_STRING FORMAT A20
COL LAST_CAPTURED FORMAT A9

SELECT S.SID,
S.USERNAME,
S.SQL_HASH_VALUE,
S.SQL_CHILD_NUMBER,
SPC.NAME,
SPC.VALUE_STRING,
LAST_CAPTURED
FROM V$SQL_BIND_CAPTURE SPC, V$SESSION S,V$SQL SQ
WHERE  SQ.SQL_ID = '99pk53nqa027r'
AND S.STATUS='ACTIVE';

select  object_status, first_load_time, username,spid   from v$process ses, v$sql sql where sql.sql_id = '99pk53nqa027r' ;

select sid from gv$session where SQL_ID = '99pk53nqa027r';
select sid, sql_id from gv$session where status = 'ACTIVE';

SELECT sql_fulltext
FROM v$sql
WHERE sql_id = '99pk53nqa027r';















set pages 2000
set lines 3000
col message for a45
col sid for 99999
col serial# for 999999
col started for a14
col state for a10
col event for a30
col ToDo_MM format 99,999
col "Elap_MM" format 99,999.00
col "Wait SS"format 999,999,999
col "%done" format 999.00
col username for a18
SELECT s.username, s.sid, s.serial#,
TO_CHAR(l.start_time,'dd/mm/yy HH24:MI') AS "Started",
round((sofar/totalwork)*100,2) AS "%done",
TIME_REMAINING/60 "ToDo_MM",
ELAPSED_SECONDS/60 as "Elap_MM",
sw.State,
sw.SECONDS_IN_WAIT "Wait SS",
message, sw.EVENT
from v$session_longops l, V$SESSION s, V$SESSION_WAIT sw
where s.SID=sw.SID
and s.SID=l.SID
and (sofar/totalwork)*100 <> 100
and totalwork <> 0
order by 3;









---------------------consumo tbs temp --------------------------------

SET LINES 300;
SET PAGES 5000;
COLUMN USERNAME FOR A23;
COLUMN MACHINE FOR A33;
COLUMN LOCKWAIT FOR A8;
COLUMN PROGRAM FOR A45;
COLUMN EVENT FOR A35;
COLUMN OSUSER FOR A20;
COLUMN SCHEMANAME FOR A30;
COLUMN MODULE FOR A35;
COLUMN SID_SERIAL FOR A25;
COLUMN TEMP_SIZE FOR A15;
COLUMN TABLESPACE FORMAT A15;
--TEMP 
SELECT B.TABLESPACE,
       ROUND(((B.BLOCKS*P.VALUE)/1024/1024/1024),2)||' GB' AS TEMP_SIZE,
       A.MACHINE AS MACHINE,
       A.SID||','||A.SERIAL# AS SID_SERIAL,
       NVL(A.USERNAME, '(oracle)') AS USERNAME,
       A.PROGRAM,
       A.STATUS,
       A.SQL_ID
FROM   GV$SESSION A,
       GV$SORT_USAGE B,
       GV$PARAMETER P
WHERE  P.NAME  = 'db_block_size'
AND    A.SADDR = B.SESSION_ADDR
AND    A.INST_ID=B.INST_ID
AND    A.INST_ID=P.INST_ID
AND    ROUND(((B.BLOCKS*P.VALUE)/1024/1024/1024),2) > '0.02'
ORDER BY B.TABLESPACE, B.BLOCKS desc








set pages 100
set lines 200
col name format a60
col value format a30
col issys_modifiable format a10
select name, value, issys_modifiable from v$parameter order by 1;











SELECT OBJECT_ID,SESSION_ID,ORACLE_USERNAME FROM  V$LOCKED_OBJECT;

col OBJECT_NAME for a50 
SELECT OBJECT_NAME, OBJECT_TYPE,OBJECT_ID FROM DBA_OBJECTS WHERE  OBJECT_ID  = 3130011;

SELECT A.OBJECT_ID, A.SESSION_ID, A.ORACLE_USERNAME, B.OBJECT_NAME , B.OBJECT_TYPE FROM v$locked_object A , DBA_OBJECTS B
WHERE A.OBJECT_ID = B.OBJECT_ID;






SET LINESIZE 500
SET PAGESIZE 1000
SET VERIFY OFF
COLUMN owner FORMAT A20
COLUMN username FORMAT A20
COLUMN object_owner FORMAT A20
COLUMN object_name FORMAT A30
COLUMN locked_mode FORMAT A15
SELECT b.session_id AS sid,
NVL(b.oracle_username, '(oracle)') AS username,
a.owner AS object_owner,
a.object_name,
Decode(b.locked_mode, 0, 'None',
1, 'Null (NULL)',
2, 'Row-S (SS)',
3, 'Row-X (SX)',
4, 'Share (S)',
5, 'S/Row-X (SSX)',
6, 'Exclusive (X)',
b.locked_mode) locked_mode,
b.os_user_name
FROM   dba_objects a,
v$locked_object b
WHERE  a.object_id = b.object_id
ORDER BY 1, 2, 3, 4;
SET PAGESIZE 14
SET VERIFY ON




BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(
   sql_id => 'a0x3g0x6p7yzg',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    method_opt => 'FOR ALL COLUMNS SIZE AUTO',
    cascade     => TRUE
  );
END;
/

BEGIN
  DBMS_STATS.GATHER_SQL_STATS (
    sql_id          => 'a0x3g0x6p7yzg',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    method_opt      => 'FOR ALL COLUMNS SIZE AUTO',
    cascade         => TRUE
  );
END;
/










SET LINESIZE 500
SET PAGESIZE 1000
COLUMN machine FORMAT A20
COLUMN username FORMAT A20
SELECT sid, username, machine, status, logon_time, last_call_et AS active_time_seconds
FROM v$session
WHERE status = 'ACTIVE'
ORDER BY logon_time ASC;



SET LINESIZE 500
SET PAGESIZE 1000
COLUMN machine FORMAT A20
COLUMN username FORMAT A20
COLUMN osuser FORMAT A20
COLUMN program FORMAT A20
SELECT sid, machine, osuser, program, status, logon_time, last_call_et
FROM v$session
WHERE status = 'ACTIVE'
ORDER BY logon_time ASC;


select module "PROGRAMA", count(*) "TOTAL" 
from gv$sessionwhere (module not like 'dw.sap%' and module not like 'DBSL%' and module not like
'rman%' and module not like 'oraagent%' and module not like 'krzstart%'
and module not like 'backup%' and module not like 'sqlplus%' and module not like 'TOAD%')
and status = 'ACTIVE'having count(*) > 10 
group by module 
order by 2 desc;


