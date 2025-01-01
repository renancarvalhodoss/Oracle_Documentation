P92
/oracle/P92/saparch/OraPatch
 
P52 
/oracle/P52/saparch/OraPatch
 
P62 
/oracle/P62/saparch/OraPatch
 
B62 
/oracle/B62/saparch/OraPatch
 
PYE 
/oracle/PYE/saparch/OraPatch

-----------PASSO 1 setar variaveis mudando apenas o nome do banco --------------------
set IHRDBMS=/oracle/PYE/19.0.0 && echo $IHRDBMS
ou
export IHRDBMS=/oracle/P92/19.0.0 && echo $IHRDBMS


set OHRDBMS=/oracle/PYE/19 && echo $OHRDBMS
ou
export OHRDBMS=/oracle/P92/19 && echo $OHRDBMS

-------------PASSO 2 conferir o nome do listener e parar ele --------------------------
ps -ef|grep tns
lsnrctl stop <LISTENER_NAME>

-------------PASSO 3 verificar banco que estar conectado e baixar --------------------
sqlplus / as sysdba

set lin 200 pages 999
col host_name for a25
select instance_name, host_name, status, to_char(sysdate,'dd-mm-yyyy hh24:mi:ss') as CURDATE, 
to_char(startup_time,'dd-mm-yyyy hh24:mi:ss') as startup_time
from v$instance;

shut immediate

-------------PASSO 4 entrar no diretorio do patc e executar atualizacoes do bninario --------------------------
cd <DIR_COMPARTILHADO_NA_LOG_DA_CHANGE> 
env ORACLE_HOME=$IHRDBMS $IHRDBMS/MOPatch/mopatch.sh -v -s SAP19P_2308-70004506.ZIP


------------PASSO 5 realizar start do banco e listener --------------------------------
sqlplus / as sysdba

startup

set lin 200 pages 999
col host_name for a25
select instance_name, host_name, status, to_char(sysdate,'dd-mm-yyyy hh24:mi:ss') as CURDATE, 
to_char(startup_time,'dd-mm-yyyy hh24:mi:ss') as startup_time
from v$instance;

quit

lsnrctl start  <LISTENER_NAME>


------------PASSO 6 atualizacao de dicionario de dados ---------------------------------
env ORACLE_HOME=$OHRDBMS ORACLE_SID=$ORACLE_SID $OHRDBMS/sapbundle/catsbp




-----------FINALIZACAO validacao e evidencias -----------------------------------------

set lin 200 pages 999
col comp_name for a50
col status for a20
col comp_id for a30
select (select name from v$database) as DB_NAME,
COMP_ID, COMP_NAME, VERSION_FULL, STATUS, MODIFIED from dba_registry;


$ORACLE_HOME/OPatch/opatch lsinv
$ORACLE_HOME/OPatch/opatch lspatches
