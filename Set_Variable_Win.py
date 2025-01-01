****SETAR PATH

ENTRA NO SYSTEM

ADVANCED SYSTEM SETTINGS

ENVIRONMENT VARIABLES

***PROCURA O PATH

E INCLUI O CAMINO DO ORACLE_HOME DENTRO DO PATH EM PRIMEIRO LUGAR

EXEMPLO

E:\oracle\product\10.2.0\db_1\bin;E:\oracle\product\client_32x\bin;C:\windows\system32;C:\windows;C:\Windows\SysWOW64;%SystemRoot%;%SystemRoot%\System32;%SystemRoot%\System32\Wbem;%SystemRoot%\system32\WindowsPowerShell\v1.0\;

ou

# Para setar as variavéis de ambiente do Oracle:

# Ambiente UNIX / Linux:

export ORACLE_SID=<nome-da-instancia>
export ORACLE_HOME=<diretório-binario-oracle>
export PATH=$ORACLE_HOME/bin:$PATH

# ou

setenv ORACLE_SID <nome-da-instancia>
setenv ORACLE_HOME <diretório-binario-oracle>
setenv PATH $ORACLE_HOME/bin:$PATH

# Ambiente Windows:

set ORACLE_SID=<nome-da-instancia>
set ORACLE_HOME=<diretório-binario-oracle>
set PATH=%ORACLE_HOME%\bin;%PATH%



export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=/opt/oracle/product/23ai/dbhomeFree
export ORACLE_SID=FREE
export PATH=$ORACLE_HOME/bin:$PATH



export ORACLE_SID=PMS
export ORACLE_HOME=/oracle/PMS/19.0.0



SELECT PARA HONDA  CHECKPOINT - RESTORE


set lin 200 pages 999
COLUMN osuser FOR A10
COLUMN username FOR A12
COLUMN inst_id FOR 99
COLUMN sid FOR 99999
COLUMN serial# FOR 999999
COLUMN spid FOR A6
COLUMN message FOR A40 WORD_WRAPPED

SELECT s.inst_id, s.SID, s.serial#, p.spid,
       s.username, s.osuser,
       l.sql_address, 
       -- l.sql_id,
       ROUND((sofar/DECODE(totalwork,0,1,totalwork))*100,2) "% COMPLETED", time_remaining,
       l.message
  FROM gv$session_longops l
  JOIN gv$session s
    ON (s.inst_id = l.inst_id AND s.SID = l.SID AND s.serial# = l.serial#)
  JOIN gv$process p
    ON (p.inst_id = s.inst_id AND p.addr = s.paddr)
WHERE ROUND((sofar/DECODE(totalwork,0,1,totalwork))*100,2) != 100
   AND l.time_remaining IS NOT NULL
   and l.message like '%RMAN%'
ORDER BY ROUND((sofar/DECODE(totalwork,0,1,totalwork))*100,2) DESC;