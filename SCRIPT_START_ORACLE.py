#!/bin/bash
# Script de inicialização do Oracle

export ORACLE_HOME=/opt/oracle/product/23ai/dbhomeFree
export ORACLE_SID=FREE
export PATH=$PATH:$ORACLE_HOME/bin
ORA_OWNER=oracle
[root@oradblab01 init.d]# cd /etc/systemd/system
[root@oradblab01 system]# systemctl start oracle.service
[root@oradblab01 system]# systemctl status oracle.service
● oracle.service - Oracle Database Service
     Loaded: loaded (/etc/systemd/system/oracle.service; enabled; vendor preset: disabled)
     Active: active (exited) since Thu 2024-05-30 04:35:27 -03; 1h 8min ago
        CPU: 54ms

mai 30 04:35:25 oradblab01 systemd[1]: Starting SYSV: start | stop | restart |status do Oracle...
mai 30 04:35:25 oradblab01 oracle[793]: Iniciando o oracle:
mai 30 04:35:25 oradblab01 oracle[810]: /etc/rc.d/init.d/oracle: linha 32: /bin/su: Permissão negada
mai 30 04:35:27 oradblab01 oracle[1212]: /etc/rc.d/init.d/oracle: linha 35: /bin/su: Permissão negada
mai 30 04:35:27 oradblab01 oracle[1213]: /etc/rc.d/init.d/oracle: linha 37: /bin/su: Permissão negada
mai 30 04:35:27 oradblab01 systemd[1]: Started SYSV: start | stop | restart |status do Oracle.
[root@oradblab01 system]# systemctl daemon-reload
[root@oradblab01 system]# systemctl start oracle.service
[root@oradblab01 system]# systemctl status oracle.service

case "$1" in
  'start')
    echo "Iniciando o listener do Oracle..."
     su - $ORA_OWNER -c lsnrctl start
    echo "Iniciando o banco de dados Oracle..."
    sqlplus / as sysdba <<EOF
    startup;
    exit;
EOF
    ;;
  'stop')
    echo "Parando o banco de dados Oracle..."
    sqlplus / as sysdba <<EOF
    shutdown immediate;
    exit;
EOF
    echo "Parando o listener do Oracle..."
    lsnrctl stop
    ;;
  *)
    echo "Uso: $0 {start|stop}"
    exit 1
    ;;
esac
exit 0


systemctl enable oracle.service
systemctl start oracle.service





# ------------------OR----------------------------------------




#!/bin/sh
#
# chkconfig: 0123456 11 89
#
# Autor      : Guilherme Poli
# description: start | stop | restart |status do Oracle 
#
# para configurar corretamente o chkconfig proceda os seguintes comandos:
#
# chkconfig --add oracle
# chkconfig --level 2345 oracle on
# chkconfig --level 016  oracle off
#
# Configuracoes
# Biblioteca de funcoes
. /etc/rc.d/init.d/functions
# Carrega Variáveis de ambiente Oracle

ORATAB=/etc/oratab
ORA_HOME=/opt/oracle/product/23ai/dbhomeFree
ORA_OWNER=oracle
oinstall
systemctl enable oracle
systemctl daemon-reload
systemctl start oracle.service
systemctl status oracle.service
# Inicia banco de dados Oracle

case "$1" in

      start)
            # Inicia o banco de dados Oracle:
            echo -n "Iniciando o oracle: "
            # Iniciando o LISTENER
            su - $ORA_OWNER -c "$ORA_HOME/bin/lsnrctl start"
            sleep 2s
            # Iniciando o banco
            su - $ORA_OWNER -c $ORA_HOME/bin/dbstart
            # Iniciando o EM
            su - $ORA_OWNER -c "$ORA_HOME/bin/emctl start dbconsole"
            touch /var/lock/subsys/oracle
      ;;

      stop)
            # Para o banco de dados Oracle:
            echo -n "Parando o oracle: "
            # Parando o EM
            su - $ORA_OWNER -c "$ORA_HOME/bin/emctl stop dbconsole"
            # Parando o LISTENER
            su - $ORA_OWNER -c "$ORA_HOME/bin/lsnrctl stop"
            # Parando o banco
            su - $ORA_OWNER -c $ORA_HOME/bin/dbshut
            rm -f /var/lock/subsys/oracle
            echo
      ;;	  
	  
      restart)
		# Reiniciando o banco de dados Oracle:
		echo -n "Reiniciando o oracle: "
		$0 stop
		sleep 5s
		$0 start
		echo
      ;;    
	  
      status)
		cat $ORATAB | while read LINE
		do
		    case $LINE in
		        \#*)                ;;        #comment-line in oratab
		        *)
		#       Proceed only if last field is 'Y'.
		#       Entries whose last field is not Y or N are not DB entry, ignore them.
		        if [ "`echo $LINE | awk -F: '{print $NF}' -`" = "Y" ] ; then
		            ORACLE_SID=`echo $LINE | awk -F: '{print $1}' -`
		            if [ "$ORACLE_SID" != '*' ] ; then
		                status "ora_pmon_$ORACLE_SID"
		            fi
		        fi
		        ;;
		    esac
		done
      ;;

      *)
		echo "Usage: oracle { start | stop | restart |status}"
		exit 1
      ;;
	
esac    
    
