#!/bin/bash
########################################################################## 
# PROGRAMA:		env-db-<SID>.sh
# Objetivo:		Configurar variaveis de ambientes
##########################################################################


umask 022
EDITOR=vi;                   export EDITOR
TERM=xterm;                  export TERM
TEMP=/tmp;                   export TEMP
TMPDIR=/tmp;                 export TMPDIR


##########################################################################
# CONFIGURAR AMBIENTE ORACLE  
##########################################################################

export ORACLE_SID=ORCLPRD
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/19.3.0.0/dbhome_1
export ORA_INVENTORY=/u01/app/oraInventory
export ORACLE_UNQNAME=ORCLPRD

export NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1
#export LANG=us_EN.UTF-8

export ORACLE_OWNER=oracle
export ORACLE_TERM=xterm



#########################################################################
# CONFIGURAR PATH        
#########################################################################

export PATH=$ORACLE_HOME/bin:$ORA_CRS_HOME/bin:$PATH:/usr/local/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$ORA_CRS_HOME/lib:/usr/local/lib:$LD_LIBRARY_PATH
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib


##########################################################################
# Extra
##########################################################################
alias dba='sqlplus "/ as sysdba"'