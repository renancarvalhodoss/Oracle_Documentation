ssh -p port user@ip = conexão
id = dados do usuario
ps -ef|grep smon| grep -v grep
ps -ef|grep inh| grep -v grep
select instance_name, status from v$instance;
du -sk * | sort -n
cat /etc/passwd

ssh -oHostKeyAlgorithms=+ssh-dss root@192.168.8.109

--rodar script
./script name_intance

set lines 200
col instance_name for a15
col host_name for a35
col dt for a20
select instance_name, host_name, to_char(STARTUP_TIME, 'dd/mm/yy hh24:mi:ss') dt, status, logins from gv$instance;


select owner,index_name,partitioned,table_name ,status from dba_indexes where index_name in ('IPCC_ID1');
 
--------------------------check datafile especifico---------------------------

select FILE#,CREATION_TIME,STATUS,NAME,LAST_TIME 
from v$datafile 
where NAME='+DATA/lbstcdb/datafile/tsp_clinica_data10';


alter system set control_files='+DG_P2K_DATA/dbdhprod/control01.ctl' scope=spfile;

UNXORADR100
set lines 200;
select open_mode,database_role, dataguard_broker, SWITCHOVER_STATUS,guard_status,flashback_on from v$database;

-----------------------------checklist-------------------------------------
alter system checkpoint;
prompt Instance OK-> STATUS=OPEN, LOGINS=ALLOWED
select instance_name, to_char(STARTUP_TIME, 'dd/mm/yy hh24:mi:ss') dt, status, logins from gv$instance;
prompt Database OK-> OPEN_MODE=READ WRITE (se DATABASE_ROLE=PRIMARY)
select open_mode,database_role, dataguard_broker, SWITCHOVER_STATUS,guard_status,flashback_on from v$database;
prompt Datafiles OK-> somente ONLINE e SYSTEM
select count(*),status from v$datafile group by status;
prompt Temp_files OK-> somente ONLINE e SYSTEM
select distinct status from dba_temp_files;	
select distinct status from v$logfile;
alter system switch logfile;
prompt pdbs OK-> RESTRICTED=NO, OPEN_MODE=READ ONLY(PDB$SEED) e READ WRITE (demais bancos)
show pdbs

iDNnTF2ZfO&7VkZL1u
dtqcd3Pr@kU0cZj






z1!ZY^z(50a((KC
not spooling currently

set lin 200 pages 999
col comp_name for a50
col status for a20
col comp_id for a20
select (select name from v$database) as DB_NAME,
COMP_ID, COMP_NAME, VERSION_FULL, STATUS, MODIFIED from dba_registry;

select to_char(SYSDATE, 'dd/mm/yy hh24:mi:ss'), hostname data_atual from DUAL;

set lines 10000
colopen_mode for a8
select open_mode,database_role, dataguard_broker, SWITCHOVER_STATUS,guard_status,flashback_on from v$database;



alter system set control_files='/+DG_HOMOL/dbhom7/control01.ora' scope=spfile;
--------------------------------check parameters-----------------------------------
show parameters dump
show parameters diag


lines 200
col instance_name for a10
col host_name for a12
select host_name, instance_name, to_char(SYSDATE, 'dd/mm/yy hh24:mi:ss') current_date, to_char(STARTUP_TIME, 'dd/mm/yy hh24:mi:ss') start_date, status from v$instance;

--------------------------------encontrar caminho do trace ------------------------------
adrci
ADR base = "/opt/oracle"
adrci> show homes
ADR Homes:
diag/rdbms/orcl/ORCL

juntar os dois caminhos + trace
/oracle/EWD/saptrace/diag/rdbms/ewd/EWD


-----------------------------------------check listener-----------------------------------------
 
lsnrctl stop listener  //parar listener 
lsnrctl start LISTENER_CYBER //iniciar listener listener
lsnrctl start LISTENER
lsnrctl status LISTENER_CYBER




--------------------------------------checklist completo------------------------------------------
Oracle instances (sqlplus)
Verificar se todos os bancos do /etc/oratab estão ativos.
Espaço utilizado nas tablespaces(% utilizado).
Área de archives (% utilizado)
Verificar log das instancias (alert<sid>.log)
Listener
Verificar listener.ora se todos os listener estão UP ($ORACLE_HOME/network/admin/listener.ora)
Ultimos backups executados















col name for a60;
select * from v$tablespace
where flashback_on != 'YES';

col name for a60;
select ts#,file#,name,status,bytes from v$datafile;




[2:27 AM] Debora Rossi
U.qF+1-Hj693Zjz


ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy hh24:mi:ss';
UPDATE fdspprd.ps_in_demand SET IN_FULFILL_STATE = 90
WHERE BUSINESS_UNIT IN ('VD909')
AND IN_FULFILL_STATE = '30'
AND DEMAND_DATE  <= '18/01/2023';
COMMIT;





D:\usr\sap\NFP\SYS\exe\uc\NTAMD64\brspace.exe  -u / -c force -f tbreorg -t J*,K*,R* -parallel 5 -degree 5  -c ctablobind



root@hoapp006ceb /oracle/FIQ/stage $ su - oracle
oracle@hoapp006ceb /oracle/FIQ $ cd /oracle/FIQ/stage
oracle@hoapp006ceb /oracle/FIQ/stage $ export IHRDBMS=/oracle/FIQ/19.0.0
oracle@hoapp006ceb /oracle/FIQ/stage $ export OHRDBMS=/oracle/FIQ/19

export IHRDBMS=/oracle/SEQ/19.0.0 && echo $IHRDBMS
export OHRDBMS=/oracle/SEQ/19 && echo $OHRDBMS 
export OHGRID=/oracle/GRID/19.0.0 && echo $OHGRID

/oracle/SEQ/19.20.0/OraPatch
set lin 200 pages 999 col
host_name for a25
select instance_name, host_name, status, to_char(sysdate,'dd-mm-yyyy hh24:mi:ss') as
CURDATE, to_char(startup_time,'dd-mm-yyyy hh24:mi:ss') as startup_ime from v$instance; 

$OHGRID/bin/srvctl status nodeapps
roothas.sh -prepatch
oracle@hoapp007ceb /home/oracle $ ps -ef| grep tns
  oracle  8388954        1   3   Jun 23      -  1:44 /oracle/SEQ/19.0.0/bin/tnslsnr LISTENER_SEQ -inherit
  oracle 51839234 49479962   0 06:23:52  pts/0  0:00 grep tns
oracle@hoapp007ceb /home/oracle $ lsnrctl stop LISTENER_SEQ

$OHGRID/bin/cluu`l \ -ckpt -oraclebase `env ORACLE_HOME=$OHGRID $OHGRID/bin/orabase` \ -writeckpt -name ROOTCRS_PREPATCH -state START

SELECT username, account_status, FROM dba_users
WHERE username IN ('ANONYMOUS', 'APEX_PUBLIC_USER', 'DBSNMP', 'OUTLN', 'SYSTEM', 'SYS', 'HR', 'SCOTT')
AND account_status = 'OPEN';

SET SERVEROUTPUT ON
BEGIN
    FOR c IN (SELECT username FROM dba_users) LOOP
        BEGIN
            EXECUTE IMMEDIATE 'ALTER USER ' || c.username || ' IDENTIFIED BY values (''new_password'')';
            DBMS_OUTPUT.PUT_LINE('User ' || c.username || ' has default password!');
        EXCEPTION
            WHEN OTHERS THEN
                NULL; -- A senha não é padrão se der erro
        END;
    END LOOP;
END;
/

set linesize 100
set pages 999
col username for a10
SELECT username, account_status FROM dba_users;
c8^AL(xbmy)2XJm




