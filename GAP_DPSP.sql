
DB_NAME	VERSION	OPEN_MODE	HOST_NAME (PRIMARY)	STANDBY 1	STANDBY 2
DBCATRDF	12.1.0.2.0	READ WRITE	rdfcatdbsp	RDFCATDBSPDR	ASRDFDBKVDR
DBPSPROD	11.2.0.4.0	READ WRITE	dpspspdb06	DPDB02	DSPSPDB99
DBSTGPRD	12.1.0.2.0	READ WRITE	dpspdb021	DPDB021DR	ASSTGDBKVDR
ODIPRD	12.1.0.2.0	READ WRITE	dpspdb020	DPDB020DR	ASODIDBKVDR
DBRBPROD	12.1.0.2.0	READ WRITE	dpspspdb09	dpdb09dr	ASVRTDBKVDR
DBMSPPRD	19.0.0.0.0	READ WRITE	DPSPSPDB07	DPDB07DR	ASMSFSPDBKVDR
ODIPRD	12.1.0.2.0	READ ONLY WITH APPLY	dpdb020dr	dpspdb020	
DBPSPROD	11.2.0.4.0	READ ONLY WITH APPLY	DPDB02	dpspspdb06	DBPSDWST
DBMRJPRD	19.0.0.0.0	READ WRITE	DPSPSPDB12	DPDB012DR	ASMSFPADBKVDR
DBDHPROD	19.0.0.0.0	READ WRITE	asdthdbdcprd01	ASDTHDBKVDR	

-- Obs: Hoje os bancos PRIMARY e STANDBY estão assim, mas isso a qualquer momento pode mudar, caso seja realizado um switchover.



-- 1)	Abrir uma sessão e deixar um “tail -f” no arquivo alert.log do banco para acompanhar, segue uma query para ajudar a identificar o arquivo.


SELECT 'tail -f ' || VALUE || decode((select upper(substr(PLATFORM_NAME,1,9)) from v$database), 'MICROSOFT', '\alert_', '/alert_')
|| (select INSTANCE_NAME from v$instance) || '.log'  ALERT_LOG
FROM V$DIAG_INFO WHERE NAME = 'Diag Trace'

ALERT_LOG
--------------------------------------------------------------------------------
tail -f /u01/app/oracle/diag/rdbms/dbmrjdr1/DBMRJDR1/trace/alert_DBMRJDR1.log



-- 2)	Identificar os bancos PRIMARY e STANDBY:

set lines 200 pages 100
column DB_UNIQUE_NAME form a20
column PARENT_DBUN form a20
column DEST_ROLE form a30
column CURRENT_SCN form 9999999999999999999999
select * from v$dataguard_config;
"                                                                                             
DB_UNIQUE_NAME       PARENT_DBUN          DEST_ROLE                  CURRENT_SCN     CON_ID
-------------------- -------------------- --------------------- ---------------- ----------
DBMRJPRD             NONE                 PRIMARY DATABASE        16659923381160          0
DBMRJDR1             DBMRJPRD             PHYSICAL STANDBY        16659804695312          0
O19MRJ02             DBMRJPRD             PHYSICAL STANDBY        16659804773837          0"


-- 3) Rodar essa query em todos os bancos para identificar o GAP de archives verficando a saida nesse trecho "Last Applied=210291"

set lines 230 pages 1000
col Archive_sequence format a50
col instance format a10
col host_name format a30
col open_mode format a20
col SCN_DATE format a30
column SCN_DATE form a21
select
inst.host_name,
inst.instance_name Instance, dat.DATABASE_ROLE,
'Last Applied='||max(sequence#)||' (resetlogs_change#='||arc.resetlogs_change#||')' Archive_sequence,
flashback_on,
dat.OPEN_MODE,
inst.version,
to_char(inst.STARTUP_TIME,'dd/mm/yyyy hh24:mi') STARTUP
from v$archived_log arc, gv$instance inst, gv$database dat
where arc.applied = (select decode(database_role, 'PRIMARY', 'NO', 'YES') from v$database)
and arc.thread# = inst.INST_ID
and inst.inst_id = dat.inst_id
and arc.resetlogs_change# = (select resetlogs_change# from v$database)
group by inst.host_name, inst.instance_name,dat.DATABASE_ROLE ,arc.thread#, arc.resetlogs_change#,dat.OPEN_MODE,flashback_on,
inst.version, to_char(inst.STARTUP_TIME,'dd/mm/yyyy hh24:mi')
order by arc.thread#;
"                                                                                                                                                        
HOST_NAME   INSTANCE   DATABASE_ROLE    ARCHIVE_SEQUENCE                                   FLASHBACK_ON  OPEN_MODE  VERSION       STARTUP
----------- ---------- ---------------- -------------------------------------------------- ------------  ----------------------   ----------------
DPSPSPDB12  DBMRJPRD   PRIMARY          Last Applied=210291 (resetlogs_change#=76854820927 NO            READ WRITE 19.0.0.0.0    25/01/2025 12:53
                                                           46)                                                                   
                                                                                                                                                                                                                                                                                 
HOST_NAME   INSTANCE   DATABASE_ROLE    ARCHIVE_SEQUENCE                                   FLASHBACK_ON  OPEN_MODE  VERSION       STARTUP
----------  ---------- ---------------- -------------------------------------------------- ------------- ---------  ------------  ----------------
dpdb012dr   DBMRJDR1   PHYSICAL STANDBY Last Applied=210155 (resetlogs_change#=76854820927 NO            MOUNTED    19.0.0.0.0    25/01/2025 13:56
                                                           46)"

-- 4) Caso o GAP de archives do STANDBY para o PRIMARY estiver grande, por exemplo, acima de 10 archives, verificar no arquivo alert.log do banco standby
-- se aparecem essas mensagens com o GAP e archives que estão faltando para continuar atualizar:

PR00 (PID:29491382): FAL: Failed to request gap sequence
PR00 (PID:29491382):  GAP - thread 1 sequence 210165-210166
PR00 (PID:29491382):  DBID 4182823408 branch 1063046519
PR00 (PID:29491382): FAL: All defined FAL servers have been attempted

-- 5) Caso não encontrar, no banco STANDBY rode esses comandos para PARAR e INICIAR a aplicação de archives no STANDBY e assim a mensagem do GAP deverá aparecer.

ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;
alter database recover managed standby database disconnect nodelay;


-- 6) Identificando os archives faltantes, podemos a partir do banco PRIMARY realizar o restore do archives faltantes e assim que concluir o restore os archives serão transferidos para o Standby e aplicados:

-- Obs: esse é o comando do Networker daqui da DPSP, onde geralmente basta alterar o parametro “NSR_CLIENT=” colocando o nome do servidor PRIMARY.

rman target /
run {
allocate channel t1 type 'sbt_tape' parms 'SBT_PARMS=(NSR_SERVER=lsp1bkp03.dpsp.int,NSR_CLIENT=dpspspdb12.dpsp.int,NSR_DIRECT_ACCESS=yes)';
restore archivelog from logseq 210165 until logseq 210166 thread 1;
}


-- 7) No servidor PRIMARY podemos rodar esse comando para forçar a geração de archives e acompanhar nos logs se estão sendo replicados.

alter system switch logfile;
