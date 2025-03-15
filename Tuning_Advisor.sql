--=============================SID LENTIDÃO DPSP ======================
                                    ========
                                    1 PASSO
                                    ========
set lines 300
set pages 300
col SQL_TEXT format a60
col machine format a25
col username format a15
select a.sql_id,a.sid, a.serial#, a.username, a.status, a.action, a.module, a.machine, b.sql_text from gv$session a, gv$sqlarea b where a.sql_address=b.address
and a.status = 'ACTIVE'
and a.sid in (386); <<--- colocar SID informado no chamado para conseguir o SQL_ID
and a.serial in (45693); 

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
SQL>                                    ===========
                                    2 PASSO
                                    ===========
SET SERVEROUTPUT ON 
declare stmt_task VARCHAR2(40);
  begin
    stmt_task := DBMS_SQLTUNE.CREATE_TUNING_TASK(sql_id => 'bzss22wz2gcky', scope => 'comprehensive', time_limit  => 600);
    DBMS_OUTPUT.put_line('task_id: ' || stmt_task );
    end;
/
                                    ================
                                    3 PASSO
                                    ================
begin
DBMS_SQLTUNE.EXECUTE_TUNING_TASK(task_name => 'TASK_258083');
end;
/
                                    ===================
                                    4 PASSO
                                    ===================
set long 999999999
set lines 190
col recommendations for a180
set pages 500
SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK('TASK_258083') AS recommendations FROM dual;



set long 999999999
set lines 190
col recommendations for a180
set pages 500
SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK('') AS recommendations FROM dual;
 Recommendation
  --------------
  - Consider collecting optimizer statistics for this index.


    execute dbms_stats.gather_table_stats(ownname => 'FDSPPRD', tabname =>'PS_DPSP_RED_EU_PND', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, method_opt => 'FOR ALL COLUMNS SIZE AUTO', cascade => TRUE);

             execute dbms_sqltune.accept_sql_profile(task_name => 'TASK_256569', task_owner => 'SYS', replace => TRUE);