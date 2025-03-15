-- identifica planos de execucao
col SQL_ID format a15
SELECT sql_id, elapsed_time/1000000 AS elapsed_time_sec, executions, cpu_time/1000000 AS cpu_time_sec 
FROM v$sql 
WHERE sql_text LIKE '%UPDATE%PS_AUTO_NUM_INSTAL%';


-- identifica a hash
SELECT sql_id, plan_hash_value, child_number
FROM v$sql_plan
WHERE sql_id IN ('3gqac97qrgphc')
GROUP BY sql_id, plan_hash_value, child_number;

select DISTINCT sql_text , sql_id from v$sql where sql_id in ('3gqac97qrgphc','bzss22wz2gcky');

-- OU

SELECT sql_id, child_number, plan_hash_value
FROM v$sql
WHERE sql_id IN ('5jubpb19n40j3', '17htk75mtw9y5', '9ppvxunm94baw', 'gurrvvxx9np6m', '8pu1xj4pgwpt5');

SELECT sql_id, plan_hash_value
FROM dba_hist_sql_plan
WHERE sql_id IN ('5jubpb19n40j3', '17htk75mtw9y5', '9ppvxunm94baw', 'gurrvvxx9np6m', '8pu1xj4pgwpt5')
GROUP BY sql_id, plan_hash_value;

SELECT sql_id, plan_hash_value, operation, options, object_name, cost
FROM dba_hist_sql_plan
WHERE sql_id = 'SQL_ID_DESEJADO'
ORDER BY id;


DECLARE
  v_plans_loaded PLS_INTEGER;
BEGIN
  v_plans_loaded := DBMS_SPM.LOAD_PLANS_FROM_CURSOR_CACHE(
    sql_id      => '926brpaw3wcqf', 
    plan_hash_value => 3924418374
  );
END;
/




-- texto sid
SELECT sql_text 
FROM gv$sql 
WHERE sql_id = (SELECT sql_id FROM gv$session WHERE sid = 5614);

==============================SID LENTIDÃO DPSP ======================

 

                                    ========

                                    1 PASSO

                                    ========

 

set lines 900
set pages 900
col SQL_TEXT format a60
col SQL_ID format a15
col MODULE format a10
col ACTION format a10
col machine format a20
col username format a15
select a.sql_id,a.sid, a.serial#, a.username, a.status, a.action, a.module, a.machine, b.sql_text from gv$session a, gv$sqlarea b where a.sql_address=b.address
and a.sql_id = b.sql_id
--and a.status = 'ACTIVE'
and a.sid in (952);  <<--- colocar SID informado no chamado para conseguir o SQL_ID

SQL_ID               SID    SERIAL# USERNAME        STATUS   ACTION                                                           MODULE                                                           MACHINE                   SQL_TEXT

------------- ---------- ---------- --------------- -------- ---------------------------------------------------------------- ---------------------------------------------------------------- ------------------------- ------------------------------------------------------------

1yj04bqvns1cm        395      35873 FDSPPRD         ACTIVE                                                                    PSAESRV@dpspspps024 (TNS V1-V3)                                  dpspspps024               DELETE FROM PS_DSP_PEND_ATEND T1 WHERE ROWID IN ( SELECT /*+

                                                                                                                                                                                                                         USE_NL(T2 T1) LEADING(T2) NO_PARALLEL(T1)*/ T1.ROWID FROM PS

                                                                                                                                                                                                                         _DSP_PEND_ATEND T1 , ( SELECT /*+NO_MERGE*/DISTINCT BUSINESS

                                                                                                                                                                                                                         _UNIT_IN FROM PS_DSP_PLD05_TMP4) T2 WHERE DECODE(T1.DSP_QTD_

                                                                                                                                                                                                                         PENDENTE,0,T1.BUSINESS_UNIT_IN, NULL)=T2.BUSINESS_UNIT_IN AN

                                                                                                                                                                                                                         D EXISTS( SELECT/*+MERGE_SJ*/ NULL FROM PS_DSP_PLD05_TMP4 T3

                                                                                                                                                                                                                          WHERE T1.BUSINESS_UNIT=T3.BUSINESS_UNIT AND T1.BUSINESS_UNI

                                                                                                                                                                                                                         T_IN = T3.BUSINESS_UNIT_IN AND T1.INV_ITEM_ID = T3.INV_ITEM_

                                                                                                                                                                                                                         ID AND T3.PROCESS_INSTANCE = :1))

SQL>

 

                                    ===========

                                    2 PASSO

                                    ===========

 

SET SERVEROUTPUT ON 
declare stmt_task VARCHAR2(40);
  begin
    stmt_task := DBMS_SQLTUNE.CREATE_TUNING_TASK(sql_id => '2tqsyjwbj4b70', scope => 'comprehensive', time_limit  => 600);
    DBMS_OUTPUT.put_line('task_id: ' || stmt_task );
    end;
/

 

 

                                    ================

                                    3 PASSO

                                    ================

 

begin
DBMS_SQLTUNE.EXECUTE_TUNING_TASK(task_name => 'TASK_258375');
end;
/

 

                                    ===================

                                    4 PASSO

                                    ===================

 

set long 999999999
set lines 190
col recommendations for a180
set pages 500
SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK('TASK_258375') AS recommendations FROM dual;


 execute dbms_stats.gather_table_stats(ownname => 'FDSPPRD', tabname => 'PS_DSP_IN_RN_TMP4', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, method_opt => 'FOR ALL COLUMNS SIZE AUTO', cascade => TRUE);

            execute dbms_stats.gather_table_stats(ownname => 'FDSPPRD', tabname => 'PS_DPSP_MVAE_TMP14', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, method_opt => 'FOR ALL COLUMNS SIZE AUTO');



             execute dbms_sqltune.accept_sql_profile(task_name => 'TASK_258375', task_owner => 'SYS', replace => TRUE);