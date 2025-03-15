
#------------------------------------SEND TO SEVER----------------------------------------------------------
scp -r  C:/Users/RenanCarvalhoDosSant/Documents/ISOS/LINUX.X64_193000_db_home.zip root@192.168.0.110:/u01
scp -r  C:/Users/RenanCarvalhoDosSant/Desktop/health_check/shinagawa_marc_2025/shinagawa_hc_full soadm2@10.210.253.69:/tmp
scp -o MACs=hmac-sha2-512 -r C:/Users/RenanCarvalhoDosSant/Desktop/health_check/gerdau_jul_2024/gerdau_hc_full soadm2@10.1.10.202:/tmp

#----------------------------------PERMISSIONS------------------------------------------------------
#------------------------always execute like root--------------------------------------
chown -R soadm1.users /tmp/SFWHDA_ora_15126.trc
chown -R soadml1.system /u01/restore_db/backup_rman/oecomp
mv gerdau_hc_full /home/oracle
chown -R orapdw.dba /tmp/SR13351875
chown -R soadm1.staff /ibmdba/backup/log/relat_bkp_on.html
chown -R root.system /tmp/shinagawa_hc_full
chmod -R 777 /tmp/shinagawa_hc_full
chmod +x check_db.sh
 
cd shinagawa_hc_full
executorhc.sh
sh ./kHC.ksh
sh -x ./kHC.ksh
#!/bin/ksh
sqlplus / as sysdba @MSEG_202407_DATA.sql
gzip MSEG_202407_DATA.txt
 
set -x
#---------------------SEND FROM THE SERVER TO MY MACHINE-----------------------------#
scp -r soadm1@10.202.234.57:/tmp/relat_bkp_on.html C:/Users/RenanCarvalhoDosSant/Desktop/
scp -r soadm3@52.0.48.79:/oracle/stage/auditMSEG_202503/MSEG_202407_DATA.txt.gz C:/Users/RenanCarvalhoDosSant/Desktop/LASAMSEXTR/
scp -r soadm1@172.22.165.47:/tmp/hc_esslpbr12db2 C:/Users/RenanCarvalhoDosSant/Desktop/health_check/essilor_out_2024/REPORT_PDB
scp -r soadm1@172.22.165.47:/tmp/hc_essldlsidb01 C:/Users/RenanCarvalhoDosSant/Desktop/health_check/essilor_out_2024/REPORT_PDB

scp -i C:\Clientes\Essilor\OCI_Acesso\172.22.164.94\mock1_openssh.pem -r opc@172.22.164.94:/tmp/kHC_*aggregate_FINAL.report.txt "C:/Users/RenanCarvalhoDosSant/Desktop/health_check/essilor_out_2024/"
scp -i C:\Clientes\Essilor\OCI_Acesso\172.22.164.73\mock1_openssh.pem -r opc@172.22.164.94:/tmp/kHC_*aggregate_FINAL.report.txt "C:/Users/RenanCarvalhoDosSant/Desktop/health_check/essilor_out_2024/"
scp -i C:\Clientes\Essilor\OCI_Acesso\172.22.165.80\DLSI-OCI_private_openssh.pem -r opc@172.22.164.94:/tmp/kHC_*aggregate_FINAL.report.txt "C:/Users/RenanCarvalhoDosSant/Desktop/health_check/essilor_out_2024/"
scp -i C:\Clientes\Essilor\OCI_Acesso\172.22.165.73\DLSI-OCI_openssh.pem -r opc@172.22.164.94:/tmp/kHC_essldlsidb01_aggregate_FINAL.report.txt "C:/Users/RenanCarvalhoDosSant/Desktop/health_check/essilor_out_2024/"
scp -o MACs=hmac-sha2-512 -r soadm2@10.1.10.202:/tmp/gerdau_hc_full C:/Users/RenanCarvalhoDosSant/Desktop/health_check/gerdau_jul_2024/po4dbhtlq01





jMcl8Xem17#4xoui
DqNh6kGo)@)5p6JO
6E)iA^0gCUfgAVk2l$
0jopIGRO#sIbvUr




i99sv422mic0d,i99sv400uc0d,i99sv424ecc0d

i99sv400ssm0p,i99sv400uc0d,i99sv400uc0p,i99sv403db0p,i99sv403db0q,i99sv403ecc0d,i99sv403ecc0p,i99sv403psf1d,i99sv403psf2p,i99sv407ntw0d,i99sv407ntw0p,i99sv407spo0d,i99sv407spo0p,i99sv421ecc0d,i99sv421ecc0p,i99sv422eai2d,i99sv422eai8p,i99sv422ecc0d,i99sv422ecc0p,i99sv422ict0d,i99sv422ict0p,i99sv422mic0d,i99sv422mic0p,i99sv424ecc0d,i99sv424ecc0p,i99sv427ecc0d,i99sv427ecc0p,i99sv427ewm0d,i99sv427ewm0p,i99sv430ecc0d,i99sv430ecc0p,i99sv430xxzye

i99sv422mic0d,i99sv400uc0d,i99sv424ecc0d

rdfcatdbspdr,asdthdbkvdr,dpdb07dr,asvrtdbkvdr,dpdb09dr