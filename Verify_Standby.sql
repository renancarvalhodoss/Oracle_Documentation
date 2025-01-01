set lines 132
column current_scn format 99999999999999999999
select * from v$dataguard_config;

-- verifica se o primario esta aplicando pro standby
set lines 200
setpages 20000 
col name for a20
alter session set nls_date_format='DD-MM-YYYY HH24:MI:SS';
select RECID,NAME,DEST_ID,THREAD#,SEQUENCE#,APPLIED,COMPLETION_TIME from v$archived_log where dest_id=2 and COMPLETION_TIME > CURRENT_TIMESTAMP - 0.1 order by 7;

select RECID,NAME,DEST_ID,THREAD#,SEQUENCE#,APPLIED,COMPLETION_TIME from v$archived_log where dest_id=2 and APPLIED = 'NO' order by 7 desc;


set lines 200
setpages 20000 
select RECID,NAME,DEST_ID,THREAD#,SEQUENCE#,APPLIED,COMPLETION_TIME from v$archived_log where dest_id=2 order by 7 asc;


--  verifica policys----
rman
connect target /
show all;

show parameter archive

--  verifica se o segundario esta com MPR ativo
select process,status from v$managed_standby;



--- verifica a quantidade de aplicacao do primario e standby ( executa nos dois e comparar
select max(sequence#) from v$loghist;



-- DESATIVAR APLICAÇÃO DE ARCHIVES

ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;

 

-- ATIVAR APLICAÇÃO DE ARCHIVES

ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT FROM SESSION;

---- VERIFICA LOG DO MPR 
select process, client_process, sequence#, status from V$managed_standby;

--- caso extremos com autorizacao apagar manual
[oracle@exadbadm01 ~]$ . oraenv
ORACLE_SID = [CEP001] ? +ASM1
The Oracle base remains unchanged with value /u01/app/oracle
[oracle@exadbadm01 ~]$ asmcmd
ASMCMD> cd reco
ASMCMD> ls -ltr
WARNING:option 'r' is deprecated for 'ls'
please use 'reverse'

Type  Redund  Striped  Time  Sys  Name
                             Y    BDGRAPH/
                             Y    BDVALEXA/
                             N    CEP_X4/
                             Y    CFP_X4/
                             Y    Cluster-c1/
                             Y    DBAUDIT/
                             Y    DBDPSOFT/
                             Y    DBHPSOFT/
                             Y    DBM/
                             N    DBPSOFT_X4/
                             Y    ECD/
                             Y    EM12C/
                             N    EPD/
                             Y    EPP_X4/
                             Y    EPQ_X4/
                             Y    EQ2_X4/
                             Y    EQ3_X4/
                             Y    EQ6/
                             Y    ESD/
                             N    FID/
                             N    GNP/
                             N    GNP_X4/
                             Y    GNQ/
                             Y    LBSTCDB/
                             Y    MULTIMED/
                             N    PID/
                             Y    PIQ_X4/
                             Y    PLSFTOUV/
                             N    cpp_x4/
                             N    dbpsoft_dg/
                             N    epq/
ASMCMD> cd CEP_X4 
ASMCMD> ls -ltr
WARNING:option 'r' is deprecated for 'ls'
please use 'reverse'

Type         Redund  Striped  Time             Sys  Name
                                               N    ARCHIVELOG/
                                               Y    AUTOBACKUP/
                                               Y    CONTROLFILE/
                                               N    onlinelog/
CONTROLFILE  HIGH    FINE     FEB 11 17:00:00  N    cntrlcep.dbf => +RECO/CEP_X4/CONTROLFILE/current.27501.1114860277
ASMCMD> cd ARCHIVELOG 
ASMCMD> ls -ltr
WARNING:option 'r' is deprecated for 'ls'
please use 'reverse'

Type  Redund  Striped  Time  Sys  Name
                             Y    2023_06_13/
                             Y    2023_06_14/
                             Y    2023_06_15/
                             Y    2023_06_16/
                             Y    2023_06_17/
                             Y    2023_06_18/
                             Y    2023_06_19/
ASMCMD> rm -rf 2023_07_03
ASMCMD> rm -rf 2023_07_04
ASMCMD> rm -rf 2023_07_05
ASMCMD> rm -rf 2023_06_16
ASMCMD> rm -rf 2023_06_17 
ASMCMD> rm -rf 2023_06_18
ASMCMD> exit

/oracle/EWD/saptrace/diag/rdbms/ewd/EWD/trace

rm -rf 2024_02_10/
rm -rf 2024_02_11
rm -rf 2024_02_12
rm -rf 2024_02_13
rm -rf 2024_02_14
rm -rf 2024_02_15
rm -rf 2024_02_16
rm -rf 2024_02_17
rm -rf 2024_02_18
rm -rf 2024_02_19
rm -rf 2024_02_20


select CLIENT_ROLE, role, type, thread#, sequence#, action from V$DATAGUARD_PROCESS; where NAME='MRP0';

select STOP_STATE, CLIENT_ROLE, ACTION, role, type, name  from V$DATAGUARD_PROCESS;