SET ECHO       OFF
SET FEEDBACK   6
SET HEADING    ON
SET LINESIZE   256
SET PAGESIZE   50000
SET TERMOUT    ON
SET TIMING     OFF
SET TRIMOUT    ON
SET TRIMSPOOL  ON
SET VERIFY     OFF
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES
COLUMN sid               FORMAT 999999    HEADING 'SID'
COLUMN serial_id         FORMAT 99999999  HEADING 'Serial ID'
COLUMN machine           FORMAT a20       HEADING 'machine'
COLUMN oracle_username   FORMAT a18       HEADING 'Oracle User'
COLUMN logon_time        FORMAT a18       HEADING 'Login Time'
COLUMN owner             FORMAT a20       HEADING 'Owner'
COLUMN object_type       FORMAT a16       HEADING 'Object Type'
COLUMN object_name       FORMAT a30       HEADING 'Object Name'
COLUMN locked_mode       FORMAT a11       HEADING 'Locked Mode'
prompt
prompt +----------------------------------------------------+
prompt | Table Locking Information                         |
prompt +----------------------------------------------------+
SELECT
   a.session_id                   sid
, c.serial#                      serial_id
, c.machine                      machine
, a.oracle_username              oracle_username
, TO_CHAR(
     c.logon_time,'mm/dd/yy hh24:mi:ss'
   )                              logon_time
, b.owner                        owner
, b.object_type                  object_type
, b.object_name                  object_name
, DECODE(
       a.locked_mode
     , 0, 'None'
     , 1, 'Null'
     , 2, 'Row-S'
     , 3, 'Row-X'
     , 4, 'Share'
     , 5, 'S/Row-X'
     , 6, 'Exclusive'
   )                              locked_mode
FROM
   v$locked_object a
, dba_objects b
, v$session c
WHERE
     a.object_id = b.object_id
AND a.session_id = c.sid
ORDER BY
   b.owner
, b.object_type
, b.object_name;


SELECT 
    sid,
    serial#,
    username,
    machine,
    osuser,
    status,
    sql_id,
    event
FROM 
    v$session
WHERE 
    status = 'ACTIVE';
    and sid = '1799';

    SELECT SID, SERIAL#, USERNAME, STATUS, SQL_ID
FROM V$SESSION
WHERE sid = '1799';

SELECT SID, SERIAL#, OPNAME, SOFAR, TOTALWORK, ROUND(SOFAR/TOTALWORK*100, 2) AS PERCENT_COMPLETE
FROM V$SESSION_LONGOPS
WHERE ROUND(SOFAR/TOTALWORK*100, 2) < '100';



set linesize 300 
col event for a30 
col machine for a30 
col program for a30 
select SID,BLOCKING_SESSION,event,machine,OSUSER,PROGRAM,status,LAST_CALL_ET/60 IN_MIN from v$session where sid = '1799';