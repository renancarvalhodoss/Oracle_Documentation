
#------------------------------------SEND TO SEVER----------------------------------------------------------
scp -r  C:/Users/RenanCarvalhoDosSant/Desktop/health_check/alpargatas_out_2024/alpargatas_hc_gap  soadm1@172.22.0.135:/tmp
scp -r  C:/Users/RenanCarvalhoDosSant/Desktop/executor_sql.sh moliv@192.168.0.110:/tmp
scp -r C:/Users/RenanCarvalhoDosSant/Downloads/LINUX.X64_193000_db_home.zip root@192.168.0.129:/tmp
scp -r /tmp/awr.12_14_24 soadm1@10.1.10.138:/tmp
scp -o MACs=hmac-sha2-512 -r C:/Users/RenanCarvalhoDosSant/Desktop/health_check/gerdau_jul_2024/gerdau_hc_full soadm2@10.1.10.202:/tmp

o4DhRSRqk2)H
#----------------------------------PERMISSIONS------------------------------------------------------
#------------------------always execute like root--------------------------------------
chown -R oracle.oinstall /u01/restore_db
chown -R soadml1.system /u01/restore_db/backup_rman/oecomp
mv gerdau_hc_full /home/oracle
cd /home/oracle/gerdau_hc_full
mv gerdau_hc_full /tmp
chown -R root.root /tmp/executor_sql.sh
chmod -R 777 /tmp/executor_sql.sh

cd alpargatas_hc_gap
sh ./kHC.ksh
 cd $ORACLE_HOME/network/admin
#---------------------SEND FROM THE SERVER TO MY MACHINE-----------------------------#
scp -r moliv@192.168.0.110:/tmp/executor_sql.sh C:/Users/RenanCarvalhoDosSant/Desktop/
scp -r soadm1@10.202.224.163:/tmp/snap_05-12_to_09-12.html C:/Users/RenanCarvalhoDosSant/Desktop/changes/SAINT_GOBAIN/SR13345910
scp -r soadm1@10.202.224.163:/tmp/awr_01-02_12_24.html C:/Users/RenanCarvalhoDosSant/Desktop/changes/SAINT_GOBAIN/SR13347889/
sudo scp -r soadm2@172.18.0.38:/u01/app/grid/diag/tnslsnr/dpdb05/listener/trace/listener.log C:/Users/RenanCarvalhoDosSant/Desktop/DPSP/
sudo scp -r soadm4@10.206.25.6:/mongodb/log/ c:/Users/RenanCarvalhoDosSant/Desktop/mongo
scp -o MACs=hmac-sha2-512 -r soadm2@10.1.10.202:/tmp/gerdau_hc_full C:/Users/RenanCarvalhoDosSant/Desktop/health_check/gerdau_jul_2024/po4dbhtlq01
bgAKu3cxMY3Xbpr

alter tablespace PSAPSR3 add datafile '/oracle/PYE/sapdata15/sr3.data79/data79' size 31767m


DqNh6kGo)@)5p6JO
6E)iA^0gCUfgAVk2l$
0jopIGRO#sIbvUr
ssh soadm1@10.113.129.19
ssh soadm4@172.22.165.51
IP Address	172.16.81.12
Username	lc5698249
Password	K38tVrZHm5,*y3-
dqm@2024vncdqm@2024vnc
pEbjxrRaLrYm3E4
K38tVrZHm5,*y3-
oXSXCknEadyrc15
srvctl start service -d ogld02pr -s report_gold
unzip -qd $IHRDBMS/sapbundle SGR19V2P_2408-70004550.ZIP 'SBP_192400240716_202408/MOPatch/*'

I99SVC-TUMDEV01@10.202.164.133 
g00d2talk4MYSEL#1
21S(E6Z^EHcPJeC

psql -c "SELECT pg_database.datname, pg_size_preHy(pg_database_size(pg_database.datname)) AS size FROM pg_database"





DqDUrsFRL&TUk@9
 

EhFoS4oQKVi$hYs)m8
 


hoafp001alp, hobip001alp, hobiq001alp, hopid001alp, hopip001alp, hoprj01alp, hosol001alp, hospd001alp

ssh -m hmac-sha2-512 soadm2@10.1.10.202

scp -o MACs=hmac-sha2-512 <and the rest of your scp command>
J$pyz0dF2NBl5DAe
ggadb010,ggadb042,ggadb043,ggadb108,ggadb110,ggadb111,ggadb127,ggadb128,po4dbhtlp01,sappdb18,sappdb22,sappdb26,sappdb29




tail -f100 /rhweb26/temp/rhweb26-idxfix.log


 _correcao-index-rhweb26.sh_{10-16-2024}_03:01.log 


/db/rhweb26/grep -i "SYSTEM ERROR: Index" rhweb.lg 

01 20 16 10 * /scripts/correcao-index-rhweb26.sh start
./correcao-index-rhweb26.sh 
crontab -e


select object_name , owner, object_type from dba_objects where object_name='ATTRIBUTE_VALUE';
select * from sw_app_cqi_clr.attribute_value where system_id = 'FEESQUAL'  and  attribute_value like '%{!ATTID} 50%' and attribute_id = '537' and program_id = '59ZZ09012';
select object_name , object_type from dba_objects where object_name='ATTRIBUTE_VALUE';


set lines 1000
set pagesize 100
col ATTRIBUTE_VALUE for a20
select * from CQI_CLR.attribute_value where system_id = 'FEESQUAL'  and  attribute_value like '%{!ATTID} 50%' and attribute_id = '537' and program_id = '59ZZ09012';

select * from CQI_CLR.attribute_value where system_id = 'FEESQUAL'  and  attribute_value like '%{!ATTID} 50%' and attribute_id = '537' and program_id = '59ZZ09022';

select * from CQI_CLR.attribute_value where system_id = 'FEESQUAL'  and  attribute_value like '%{!ATTID} 50%' and attribute_id = '537' and program_id = '59ZZ09212';

select * from CQI_CLR.attribute_value where system_id = 'FEESQUAL'  and  attribute_value like '%{!ATTID} 50%' and attribute_id = '537' and program_id = '59ZZ09222';

















set lines 1000
set pagesize 100
col ATTRIBUTE_VALUE for a20
select * from CQI_CLR.attribute_value where system_id = 'FEESQUAL' and attribute_id = '537' and program_id = '59ZZ09012';

select * from CQI_CLR.attribute_value where system_id = 'FEESQUAL' and attribute_id = '537' and program_id = '59ZZ09022';

select * from CQI_CLR.attribute_value where system_id = 'FEESQUAL' and attribute_id = '537' and program_id = '59ZZ09212';

select * from CQI_CLR.attribute_value where system_id = 'FEESQUAL' and attribute_id = '537' and program_id = '59ZZ09222';







               #!/usr/bin/env ksh

LOG_FILE="teste$(date +%Y%m%d_%H%M%S).log"

# Localização do arquivo oratab
ORATAB="/etc/oratab"
if [ ! -f "$ORATAB" ]; then
          ORATAB="/var/opt/oracle/oratab"
  fi

  # Verifica se o arquivo oratab existe
  if [ ! -f "$ORATAB" ]; then
            echo "Erro: Arquivo oratab não encontrado em /etc/oratab ou /var/opt/oracle/oratab"
              exit 1
      fi

          # Lê o arquivo oratab linha por linha
          while IFS=: read -r SID ORACLE_HOME AUTO_START; do
                    # Ignora linhas de comentário ou vazias
                      [[ "$SID" =~ ^#.*$ ]] || [[ -z "$SID" ]] || [[ "$SID" == +* ]] && continue
                        # Exibe o SID e o Oracle Home
                          INST+=$(printf "%s:%s\n" "$SID" "$ORACLE_HOME""\n")
                  done < "$ORATAB"
                  echo -e "$INST"

PSIV1:/u01/app/oracle/product/19.0.0/dbhome_1
PSW19C1:/u01/app/oracle/product/19.0.0/dbhome_1
PSW19CDG1:/u01/app/oracle/product/19.0.0/dbhome_1
PAGV1:/u01/app/oracle/product/19.0.0/dbhome_1
PSWACQ1:/u01/app/oracle/product/19.0.0/dbhome_1
PPAN1:/u01/app/oracle/product/19.0.0/dbhome_1
PMASTER1:/u01/app/oracle/product/19.0.0/dbhome_1


PAME1:/u01/app/oracle/product/19.0.0/dbhome_1
PBSE1:/u01/app/oracle/product/19.0.0/dbhome_1
PSWPOOL1:/u01/app/oracle/product/19.0.0/dbhome_1


/ibmdba/scripts/checklist

run_all_checklist.sh 
instancia.txt 
checklist.sql

chmod -R 777 run_all_checklist.sh 
chmod -R 777 instancia.txt 
chmod -R 777 checklist.sql

./run_all_checklist.sh instancia.txt checklist.sql












<Actual_Value>
#!/usr/bin/env ksh
Actual_Value=$(grep -i "encryption_server" $ORACLE_HOME/network/admin/sqlnet.ora)
echo "${Actual_Value}"
</Actual_Value>

<Finding_Level>
#!/usr/bin/env ksh
Actual_Value=$(grep -i "encryption_server" $ORACLE_HOME/network/admin/sqlnet.ora)
if [ -z "$Actual_Value" ]; then
  Finding_Level="Compliant"
else
  Finding_Level="Violation"
fi
echo "${Finding_Level}"
</Finding_Level>




hodbqess025,hodbqess028,essltlsidb01,essldlsidb01,esslpbr12db1,esslpbr12db2.

HODBQESS025
HODBQESS028


brvvaixdbmsf1p,brvvaixdbmsf1h,spo1rman1,brvvaixdbmsf1p




set lines 300
set pages 500
col PATH for a100
SELECT disk_number, path, mount_status, state, header_status 
FROM v$asm_disk;





