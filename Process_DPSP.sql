=================================================================================================================
  
--ver sessao
 set linesize 1000
 set pagesize 1000
select SID,
       SERIAL#,
       SQL_ID,
       WAIT_TIME,
       SECONDS_IN_WAIT,
       STATE,
       WAIT_TIME_MICRO,
       EVENT,
       --TIME_REMAINING_MICRO,
       TIME_SINCE_LAST_WAIT_MICRO
from V$SESSION
 where sid =301;
 
 
====================================================================================================================

Verificar lock de sessoes 

clear screen
		break on username
		col inst_id format 99
		col machine format a20
		col sid     format 99999
		col serial# format 999999
		col osuser format a15
		col ACTION format a35
		col username format a16
		col module format a45
		col logon format a18
		col module format a42
		col SQL_ID format a15
		col EVENT format a32
		col program format a36
		set linesize 1000
		set pagesize 1000
		select
	--          s.INST_ID
			    s.username
			   ,s.sid
			   ,s.serial#
			   ,s.INST_ID
			   ,to_char(s.logon_time,'ddmonyy hh24:mi:ss')  logon 
			   ,s.machine
	--		   ,s.ACTION
    		--    ,s.SQL_HASH_VALUE
			   ,s.sql_id
	--		   ,s.event
			--    ,s.program
			--    ,s.last_call_et
	--		   ,s.module
			--    ,s.osuser
	--         ,s.type
	           ,BLOCKING_INSTANCE
	           ,BLOCKING_SESSION
		from gv$Session s
		where s.status='ACTIVE'
		and s.username is not null
        -- and s.INST_ID = 2329299
		order by  1, 8
		/
		
=======================================================================================================================

VERIFICA HISTORICO SQL_IDS(somente DPSP)

select a.instance_number inst_id, a.snap_id,a.plan_hash_value, to_char(begin_interval_time,'dd-mon-yy hh24:mi') btime, abs(extract(minute from (end_interval_time-begin_interval_time)) + extract(hour from (end_interval_time-begin_interval_time))*60 + extract(day from (end_interval_time-begin_interval_time))*24*60) minutes,
executions_delta executions, round(ELAPSED_TIME_delta/1000000/greatest(executions_delta,1),4) "avg duration (sec)" from dba_hist_SQLSTAT a, dba_hist_snapshot b
where sql_id='&SQL_ID' and a.snap_id=b.snap_id
and a.instance_number=b.instance_number
--AND begin_interval_time >= trunc(sysdate-3)
AND executions_delta > 1
order by snap_id desc, a.instance_number;