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


setenv ORACLE_SID P82
setenv ORACLE_HOME /oracle/P82/19
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