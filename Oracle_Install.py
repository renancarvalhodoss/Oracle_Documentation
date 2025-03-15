# configuracao do LINUX
criacao de /   #8gb
criacao de /boot #1gb
criacao de /home #5gb
criacao de swap #2GB  ideal é ter pelo menos o mesmo tamanho da RAM ou o dobro se tiver até 4 GB de RAM)
criacao de /opt #10gb para os binarios
criacao de /u01 #40gb
criacao de /backup #10gb


# - desabilitando firewall

systemctl stop firewalld
systemctl disable firewalld


# - configurando hosts

vi /etc/hosts 
192.168.1.110   OLE8PRD OLE8PRD.localdomain 


# -- instalando pacote preinstall

yum search preinstall
yum install oracle-database-preinstall-19c.x86_64


# - criando grupos e ajustando user oracle

useradd oracle 
# Obs: caso não tenha criado na instalação do S.O

id oracle 

groupadd oinstall
groupadd dba
groupadd oper
groupadd backupdba
groupadd dgdba
groupadd kmdba
groupadd racdba
usermod -g oinstall -G dba,oper,backupdba,dgdba,kmdba,racdba oracle

passwd oracle 


# - configurando diretorios

mkdir -p /u01/app/oracle/product/19.3.0.0/dbhome_1
chown -R oracle:oinstall /u01 

# - envie o install zipado par ao server
# - descompactar no diretorio do home
mv LINUX.X64_193000_db_home.zip /u01/app/oracle/product/19.3.0.0/dbhome_1
chown -R oracle:oinstall LINUX.X64_193000_db_home.zip

# criar arquivo de inventory
 mkdir -p /u01/app/oraInventory
 chown -R oracle:oinstall /u01/app/oraInventory
 chmod -R 775 /u01/app/oraInventory
echo $ORA_INVENTORY


# - criar arquivo env
vi /home/oracle/env-db-SID.sh
chown -R oracle:oinstall /home/oracle/env-db-SID.sh
chmod +x /home/oracle/env-db-SID.sh
mv env-db-SID.sh env-db-ORCLPRD.sh

# - apos descompactar 

$ORACLE_HOME/cv/admin/cvu_config
CV_ASSUME_DISTID=OEL8


# EXECUTION IN MODE SILENT 

./runInstaller -ignorePrereq -waitforcompletion -silent                        \
    -responseFile ${ORACLE_HOME}/install/response/db_install.rsp               \
    oracle.install.option=INSTALL_DB_SWONLY                                    \
    ORACLE_HOSTNAME=${ORACLE_HOSTNAME}                                         \
    UNIX_GROUP_NAME=oinstall                                                   \
    INVENTORY_LOCATION=${ORA_INVENTORY}                                        \
    SELECTED_LANGUAGES=en,en_GB                                                \
    ORACLE_HOME=${ORACLE_HOME}                                                 \
    ORACLE_BASE=${ORACLE_BASE}                                                 \
    oracle.install.db.InstallEdition=EE                                        \
    oracle.install.db.OSDBA_GROUP=dba                                          \
    oracle.install.db.OSBACKUPDBA_GROUP=dba                                    \
    oracle.install.db.OSDGDBA_GROUP=dba                                        \
    oracle.install.db.OSKMDBA_GROUP=dba                                        \
    oracle.install.db.OSRACDBA_GROUP=dba                                       \
    SECURITY_UPDATES_VIA_MYORACLESUPPORT=false                                 \
    DECLINE_SECURITY_UPDATES=true



# executar como root
     /u01/app/oraInventory/orainstRoot.sh
     /u01/app/oracle/product/19.3.0.0/dbhome_1/root.sh




    #  -- comando criação listener (NETCA)
cd $ORACLE_HOME/assistants/netca
cp netca.rsp /home/oracle/netca.rsp
netca -silent -responsefile /home/oracle/netca.rsp


# -- Banco de dados (DBCA)

# Pode ser deito de duas formas

# - arquivo: dbca.rsp
local: $ORACLE_HOME/assistants/dbca

# - ou passando todos os atributos
dbca -silent -createDatabase                                                   \
     -templateName General_Purpose.dbc                                         \
     -gdbname ORCLPRD -sid  ORCLPRD -responseFile NO_VALUE                     \
     -characterSet AL32UTF8                                                    \
     -sysPassword SysPassword1                                                 \
     -systemPassword SysPassword1                                              \
     -createAsContainerDatabase true                                           \
     -numberOfPDBs 1                                                           \
     -pdbName PDBPRD                                                            \
     -pdbAdminPassword PdbPassword1                                            \
     -databaseType MULTIPURPOSE                                                \
     -memoryMgmtType auto_sga                                                  \
     -totalMemory 2000                                                          \
     -redoLogFileSize 200                                                      \
     -emConfiguration NONE                                                     \
     -ignorePreReqs



================================================================================================
# pre configurar o oraenv executar no usuario owner do banco
vi ~/.bash_profile
vi ~/.bashrc
export ORACLE_SID=ORCLPRD
export ORACLE_HOME=/u01/app/oracle/product/19.3.0.0/dbhome_1
export PATH=$ORACLE_HOME/bin:$PATH

source ~/.bash_profile
source ~/.bashrc




================================================================================================
# configurando as etapas start automatico do database executar como root
sudo vi /etc/init.d/oracle

#!/bin/bash
# chkconfig: 345 99 10
# description: Oracle Auto Start-Stop Script

# Define Oracle environment variables
ORACLE_HOME=/u01/app/oracle/product/19.3.0.0/dbhome_1
ORACLE_OWNER=oracle

case "$1" in
'start')
    echo "Starting Oracle Database..."
    su - $ORACLE_OWNER -c "$ORACLE_HOME/bin/dbstart $ORACLE_HOME"
    ;;
'stop')
    echo "Stopping Oracle Database..."
    su - $ORACLE_OWNER -c "$ORACLE_HOME/bin/dbshut $ORACLE_HOME"
    ;;
'restart')
    echo "Restarting Oracle Database..."
    $0 stop
    $0 start
    ;;
*)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
    ;;
esac
exit 0

# Dê permissões de execução ao script:
sudo chmod 750 /etc/init.d/oracle

# Adicione o script ao chkconfig:
sudo chkconfig --add oracle

# Habilite o script para iniciar nos níveis de execução apropriados:
sudo chkconfig oracle on

# Localize a linha correspondente ao seu banco de dados e altere o último campo para Y:
ORCL:/u01/app/oracle/product/19.0.0/dbhome_1:Y

sudo reboot


sudo ausearch -c 'oracle' --raw | audit2allow -M my-oracle
sudo semodule -X 300 -i my-oracle.pp