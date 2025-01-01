
-----------STOP --------------

sudo su - mongousr 
mongod -f /mongodb/prd/conf/mongod.conf --shutdown 

ou 

sudo su - mongousr 
/mongodb/prd/scripts/stopReplicaSet.sh 

 

--------------START -----------

sudo su - mongousr 
mongod -f /mongodb/prd/conf/mongod.conf 

ou 

sudo su - mongousr 
/mongodb/prd/scripts/startReplicaSet.sh 


/usr/local/bin/mongod --bind_ip_all --dbpath /u01/lib/mongo --logpath /u01/log/mongodb/mongod.log --fork



--------------Log do banco--------------- 


drwxr-s---. 2 mongousr mongo  8192 Feb 23 01:05 log 

 

--------------Scripts --------------------

drwxr-s---. 3 mongousr mongo    58 Feb 23 10:22 scripts   
-rwx------. 1 mongousr mongousr 2845 Feb 21 16:59 mongocheck.sh (checklist basico ) 
-rwx------. 1 mongousr mongousr  270 Feb 23 10:16 rotatelog.sh (limpeza de logs agendada na crontab) 
-rwx------. 1 mongousr mongousr 5145 Apr  1 19:44 BackupMongodb_rs.sh (Backup executado na madrugada) 
-rwx------. 1 mongousr mongousr   87 May 20 13:55 dbStats.sh (Script antigo, queries lentas) 
-rwx------. 1 mongousr mongousr  192 May 20 13:57 startReplicaSet.sh (Start mongo) 
-rwx------. 1 mongousr mongousr   69 May 20 14:02 stopReplicaSet.sh (Stop mongo) 










rfutil padrao65 -C mark backedup

rfutil padrao65 -C aimage begin  # If required​

rfutil padrao65 -C aiarchiver enable

proutil padrao65 -C enablesitereplication source # If after-imaging had to be enabled





















1 - validar se tem extent de AI e se o AI está habilitado:​

prostrct list padrao65 padrao65.st

proutil padrao65 -C describe

2 - habilitar online:​

probkup online padrao65 /dev/null enableaiarchiver -aiarcdir <dir1> -Bp 32​

3 - habilitar o aiw (serviço do aimage writer):​

proaiw padrao65​

4 - adicionar o parametro aiarcdir no properties de startup​

-aiarcdir = <dir>​

5 - validar se o AIMGT foi habilitado com sucesso:​

proutil dbname -C describe