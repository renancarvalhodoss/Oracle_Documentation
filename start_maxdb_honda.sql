-- Login: 
-- Logar como soadm1,soadm2 ou soadm3

Start: 
sudo su - sdb 
/sapdb/programs/bin/x_server start 
dbmcli -d ${SID} -u superdba,F1t@C1ty 
db_admin 
db_online 
db_state -v 



sudo su - sdb 

-- logar no banco: 
dbmcli -d ${SID} -u superdba,F1t@C1ty 

-- Checar status no banco: 
info state 

-- filesystem com checklist do banco:
-- Executar o script abaixo: 
/home/sdb/ibm_maxdb_checklist.sh

-- Verificar as logs:
/home/sdb/ibm_maxdb_checklist.log





-- Login: 
-- Logar como soadm1,soadm2 ou soadm3

Stop: 
sudo su - sdb 
dbmcli -d ${SID} -u superdba,F1t@C1ty 
db_admin 
db_offline 
db_state –v 
/sapdb/programs/bin/x_server stop 