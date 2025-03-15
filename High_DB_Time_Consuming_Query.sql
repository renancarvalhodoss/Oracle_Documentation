as we verified,,,requested SQLID is not there in db level,,it might completed the trancaction,,please check the below details.
 
 
SQL> select l1.sid, ' IS BLOCKING ', l2.sid from gv$lock l1, gv$lock l2 where l1.block =1 and l2.request > 0 and l1.id1=l2.id1 and l1.id2=l2.id2;

no rows selected

SQL> select USERNAME,SQL_ID,SQL_HASH_VALUE,SERIAL#,SID,inst_id,status,SECONDS_IN_WAIT from gv$session where sql_id='8vjgu00v977bj';

no rows selected

SQL>
 
 
 
 
DB_NAME   INSTANCE_NAME    ON_MODE        DATABASE_ROLE     DB Startup Time     HOST_NAME
--------- ---------------- -------------------- ---------------- ------------------- ----------------------------------------------------------------
RCLWTNP1  RCLWTNP1       READ WRITE        PRIMARY      07-09-2021 05:34:45 oradbrecwtnp101
 
 
 select RESOURCE_NAME, CURRENT_UTILIZATION, MAX_UTILIZATION  from v$resource_limit;