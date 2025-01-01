
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(
    ownname => 'FDSPPRD',
    tabname => 'PS_DPSP_REP3_TAO17',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    cascade => TRUE
  );
    END;
  /

  BEGIN
   DBMS_STATS.GATHER_TABLE_STATS(
    ownname => 'FDSPPRD',
    tabname => 'PS_LOCATION_TBL',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    cascade => TRUE
  );
    END;
  /

  BEGIN
   DBMS_STATS.GATHER_TABLE_STATS(
    ownname => 'FDSPPRD',
    tabname => 'PS_DPSP_LIN_RET_DV',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    cascade => TRUE
  );
    END;
  /

  BEGIN
   DBMS_STATS.GATHER_TABLE_STATS(
    ownname => 'FDSPPRD',
    tabname => 'PS_DSP_NF_LN_BRL',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    cascade => TRUE
  );
    END;
  /
  -------------------------------------------

  BEGIN
   DBMS_STATS.GATHER_TABLE_STATS(
    ownname => 'FDSPPRD',
    tabname => 'PS_DSP_WMS_IND_CTR',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    cascade => TRUE
  );
  END;
  /


  BEGIN
   DBMS_STATS.GATHER_TABLE_STATS(
    ownname => 'FDSPPRD',
    tabname => 'PS_MASTER_ITEM_TBL',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    cascade => TRUE
  );
    END;
  /
  

  BEGIN
   DBMS_STATS.GATHER_TABLE_STATS(
    ownname => 'FDSPPRD',
    tabname => 'PS_NF_HDR_BBL_FS',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    cascade => TRUE
  );
END;
/

EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'ODISTG', TABNAME=>'P2K_VIGENCIA_PRECO', cascade=>true);

---------------------coleta de uma tabela especifica-------------
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(
    ownname => 'SCHEMA_NOME',
    tabname => 'TABELA_NOME',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    cascade => TRUE
  );
END;
/





and  TABLE_NAME = 'PS_BUS_UNIT_TBL_FS'
and  TABLE_NAME = 'PS_LOCATION_TBL'
and  TABLE_NAME = 'PS_DPSP_LIN_RET_DV'
and  TABLE_NAME = 'PS_DSP_NF_LN_BRL'
and  TABLE_NAME = 'PS_DSP_WMS_IND_CTR'
and  TABLE_NAME = 'PS_MASTER_ITEM_TBL'
and  TABLE_NAME = 'PS_NF_HDR_BBL_FS'

========================================================================================================================

exec dbms_stats.gather_table_stats( -
ownname          => 'OWNER', -
tabname          => 'NOME DA TABELA', -
estimate_percent => 100, -
method_opt       => 'for all indexed  columns size auto', -
cascade          => true -
)







----------- evidencias da statistics--------------

set linesize 2000 pagesize 20000
col OWNER for a20
col TABLE_NAME for a25
col COLUMN_NAME for a30 
--col DENSITY for a40
--col NUM_BUCKETS for a40
col HISTOGRAM for a20
select OWNER,TABLE_NAME,COLUMN_NAME,DENSITY,NUM_BUCKETS,HISTOGRAM,to_char(LAST_ANALYZED,'DD-MM-YYYY HH24:MI:SS') 
from dba_tab_col_statistics 
where OWNER = 'FDSPPRD'
and  TABLE_NAME = 'PS_BUS_UNIT_TBL_FS'
or  TABLE_NAME = 'PS_LOCATION_TBL'
or  TABLE_NAME = 'PS_DPSP_LIN_RET_DV'
or  TABLE_NAME = 'PS_DSP_NF_LN_BRL'
or  TABLE_NAME = 'PS_DSP_WMS_IND_CTR'
or  TABLE_NAME = 'PS_MASTER_ITEM_TBL'
or  TABLE_NAME = 'PS_NF_HDR_BBL_FS';


column machine format a20
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
from V$SESSION;
where sid = 4482;

-------------- verificar longa execucao------------------

set pagesize 1000
set linesize 1000
set recsep off
column inicio format a17
column Previsao_Termino format a17
column opname format a20
column usuario format a10
column sid format 99999
column serial format 9999999
column spid format a8
column target format a30 trunc
select
--vs.inst_id,
vs.sid,
--vs.serial#,
vs.username Usuario,
--gp.spid,
--vs.sql_id,
vs.status,
vsl.opname,
to_char(Start_Time,'DD/MM/YYYY HH24:MI') Inicio,
case (totalwork*sofar) when 0 then '' else to_char(start_time+(sysdate-Start_Time)/(sofar/totalwork),'DD/MM/YYYY HH24:MI') end Previsao_Termino,
TotalWork Total,
Sofar Processado,
case (totalwork*sofar) when 0 then 0 else round(sofar/totalwork*100,2) end Perc_Processado,
vsl.target
from
gv$session_longops vsl
join gv$session vs on vsl.sid = vs.sid and vs.inst_id = vsl.inst_id
join gv$process gp on gp.addr = vs.paddr and gp.inst_id = vs.inst_id
where totalwork <> sofar
and vs.username = 'SYS'
order by perc_processado desc, vs.logon_time desc;





SELECT segment_name, 
       bytes / 1024 / 1024 AS tamanho_mb
  FROM dba_segments
 WHERE segment_name = 'PS_NF_HDR_BBL_FS'
   AND owner = 'FDSPPRD';

   SELECT segment_name, 
       SUM(bytes) / 1024 / 1024 AS tamanho_mb
  FROM dba_segments
 WHERE owner = 'FDSPPRD'
   AND segment_name = 'PS_NF_HDR_BBL_FS'
 GROUP BY segment_name;