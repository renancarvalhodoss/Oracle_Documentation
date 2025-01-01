RMAN_CATUSER=rmanxid							=> Informar o nome do usuario do RMAN
RMAN_CATPWD=sT4#x7Jnh73r						=> Informar a pwd do usuario do RMAN
RMAN_STRING_CONNECT=RMAN						=> Informar a string de conexao ao RMAN
RMAN_SID=RMAN	


SQL> connect /@RMAN04;


ex:
SQL> connect rmangoldexa/bkpcar123@RMAN; 
Connected.


cbdx103 - [prd5101]
/oem10g> tnsping RMAN1

TNS Ping Utility for IBM/AIX RISC System/6000: Version 10.2.0.4.0 - Production on 10-MAY-2022 00:41:53

Copyright (c) 1997,  2007, Oracle.  All rights reserved.

Used parameter files:
/oracle/app/oracle/product/10.2.0/network/admin/sqlnet.ora


Used TNSNAMES adapter to resolve the alias
Attempting to contact (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 10.100.30.61) (PORT = 1555)) (CONNECT_DATA = (SID=RMAN1)))   
OK (10 msec)


crosscheck backup;
------CONECT CATALOG-----------------------
rman

connect target;

connect catalog /@RMAN04;

rman catalog rmangoldexa/bkpcar123@RMAN target /

rman catalog  MESCHRP1/MESCHRP1#REP@RMANSL target /

rman catalog RMAN/pwduser$rman12@NFE target /

connect catalog RMANMSTR9IP/d*LmRj0kJ9biv+st@RMAN;
  update pdb_node set high_rsr_recid=0 where (db_key) in (select db_key from rc_database where dbid=<<dbid of database facing issue>>);
           commit;

RMAN_CATUSER=RMAN							=> Informar o nome do usuario do RMAN
RMAN_CATPWD=pwduser$rman12						=> Informar a pwd do usuario do RMAN
RMAN_STRING_CONNECT=NFE						=> Informar a string de conexao ao RMAN
RMAN_SID=NFE                                          => Inform the string of conection to RMAN    



allocate channel for maintenance device type 'sbt_tape'
 parms 'ENV=(TDPO_OPTFILE=C:\progra~1\tivoli\TSM\AgentOBA64\tdpo_D30.opt)';

 >  allocate channel t0 type 'sbt_tape'
10>   parms 'ENV=(TDPO_OPTFILE=C:\progra~1\tivoli\TSM\AgentOBA64\tdpo_D30.opt)';

allocate channel for maintenance device type 'sbt_tape'
 parms 'SBT_LIBRARY=/opt/veeam/VeeamPluginforOracleRMAN/libOracleRMANPlugin.so';

 
SELECT * FROM RC_BACKUP_PIECE WHERE HANDLE LIKE '%DRAWB_ON_FULL_MONTHLY_k320s806_1_1.DBF%';



crosscheck backup;

crosscheck archivelog all;

delete noprompt expired archivelog all;

delete expired archivelog all;

DELETE ARCHIVELOG UNTIL TIME 'SYSDATE-3';



crosscheck backuppiece 'DRAWB_ON_FULL_MONTHLY_k320s806_1_1.DBF';

--  RUNNING BACKUP MANUAL

configure controlfile autobackup ON;
configure retention policy to none;
  
  CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET; 
 run {
 # Configure controlfile backup format
 set controlfile AUTOBACKUP FORMAT FOR DEVICE TYPE SBT_TAPE TO 'CONTROL_DAILY_%F';

 allocate channel t3 type 'sbt_tape'
  parms 'ENV=(TDPO_OPTFILE=C:\Program Files\Tivoli\TSM\AgentOBA64\tdpo_RRDVHOA2502_FORAD_XID.opt)';
 
 sql 'alter system archive log current';
 sql 'alter system switch logfile';
 #Oracl3!Kyndryl.2024
 backup check logical
   format 'XID_ARC_DAILY_%U.ARC'
    tag 'BK_ARC_DAI_20240327131057'
    filesperset 10
    (archivelog all delete input
     skip inaccessible );
 }




  configure controlfile autobackup ON;
  configure retention policy to none;
   
  sql 'alter session set optimizer_mode=RULE';
  
   CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET; 
  run {
  # Configure controlfile backup format
  set controlfile AUTOBACKUP FORMAT FOR DEVICE TYPE SBT_TAPE TO 'CONTROL_DAILY_%F';
  allocate channel t0 type 'sbt_tape'
   parms 'ENV=(TDPO_OPTFILE=C:\progra~1\tivoli\TSM\AgentOBA64\tdpo_BWQ.opt)';
  allocate channel t1 type 'sbt_tape'
   parms 'ENV=(TDPO_OPTFILE=C:\progra~1\tivoli\TSM\AgentOBA64\tdpo_BWQ.opt)';
  allocate channel t2 type 'sbt_tape'
   parms 'ENV=(TDPO_OPTFILE=C:\progra~1\tivoli\TSM\AgentOBA64\tdpo_BWQ.opt)';
  allocate channel t3 type 'sbt_tape'
   parms 'ENV=(TDPO_OPTFILE=C:\progra~1\tivoli\TSM\AgentOBA64\tdpo_BWQ.opt)';
  allocate channel t4 type 'sbt_tape'
   parms 'ENV=(TDPO_OPTFILE=C:\progra~1\tivoli\TSM\AgentOBA64\tdpo_BWQ.opt)';
  allocate channel t5 type 'sbt_tape'
   parms 'ENV=(TDPO_OPTFILE=C:\progra~1\tivoli\TSM\AgentOBA64\tdpo_BWQ.opt)';
  allocate channel t6 type 'sbt_tape'
   parms 'ENV=(TDPO_OPTFILE=C:\progra~1\tivoli\TSM\AgentOBA64\tdpo_BWQ.opt)';
  allocate channel t7 type 'sbt_tape'
   parms 'ENV=(TDPO_OPTFILE=C:\progra~1\tivoli\TSM\AgentOBA64\tdpo_BWQ.opt)';
  allocate channel t8 type 'sbt_tape'
   parms 'ENV=(TDPO_OPTFILE=C:\progra~1\tivoli\TSM\AgentOBA64\tdpo_BWQ.opt)';
  allocate channel t9 type 'sbt_tape'
   parms 'ENV=(TDPO_OPTFILE=C:\progra~1\tivoli\TSM\AgentOBA64\tdpo_BWQ.opt)';
  
  sql 'alter system archive log current';
  sql 'alter system switch logfile';
  
  backup check logical
    format 'BWQ_ARC_DAILY_%U.ARC'
     tag 'BK_ARC_DAI_20240909011018'
     filesperset 10
     (archivelog all delete input
      skip inaccessible );
  }