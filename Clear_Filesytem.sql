
-- o	Descobrindo quais diretórios ficam os logs e arquivos de audit do banco:

-- [oracle@localhost ~]$ sqlplus / as sysdba

-- SQL*Plus: Release 12.2.0.1.0 Production on Mon Jan 31 09:18:49 2022
-- Copyright (c) 1982, 2016, Oracle.  All rights reserved.
-- Connected to:
-- Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production


SQL> show parameters dump

NAME				     TYPE	 VALUE
------------------------------------ ----------- -----------------
background_dump_dest	     string	 /opt/oracle/product/12.2.0.1/dbhome_1/rdbms/log
core_dump_dest		     string	 /opt/oracle/diag/rdbms/orcl/ORCL/cdump
max_dump_file_size	           string	 unlimited
shadow_core_dump		     string	 partial
user_dump_dest		     string	 /opt/oracle/product/12.2.0.1/d
						 bhome_1/rdbms/log


/u01/app/oracle/diag/rdbms/dbeunprd/DBEUNPRD/cdump

SQL> show parameters diag

NAME				     TYPE	 VALUE
------------------------------------ ----------- -------------------
diagnostic_dest 		     string	 /opt/oracle
/oracle19/app/oracle/admin

SQL> show parameters audit_file_dest

NAME				     TYPE	 VALUE
------------------------------------ ----------- -------------------
audit_file_dest 		     string	 /opt/oracle/admin/ORCL/adump

o	a partir do diretório do alerta, liste os 10 maiores diretórios para facilitar a análise.



du -sg * | sort -nr 

	[oracle@localhost diag]$ du -sg * |sort -nr |head -30
	732	./tnslsnr
	732	./tnslsnr/localhost
	732	./tnslsnr/localhost/listener
	1004	./rdbms/orcl/ORCL/alert
	4004	./rdbms/orcl/ORCL/metadata
	17624	./rdbms/orcl/ORCL/trace
	22640	./rdbms
	22640	./rdbms/orcl 
	22640	./rdbms/orcl/ORCL
	23376	.

o	verifique os maiores diretórios e apague os arquivos mais antigos com extensão .aud, .trc e .trm.
o	Sempre que possível deixe 90 dias de arquivos para facilitar análise de problemas e atender a política de segurança do cliente. 



find . \( -name "*.xml" -a -mtime +05 \) -exec ls -ltr {} \; &
find . \( -name "*.aud" -a -mtime +0 \) -exec rm -r {} \; &
find . \( -name "*.gz" -a -mtime +2 \) -exec rm -r {} \; &
find . \( -name "*.trc" -a -mtime +05 \) -exec ls -ltr {} \; &
find . \( -name "*.log" -a -mtime +10 \) -exec rm -r {} \; &
find . \( -name "*.trc" -a -mtime +10  \) -exec rm -r {} \; &
find . \( -name "*.trm" -a -mtime +10  \) -exec rm -r {} \; &
find . \( -name "*.aud.gz" -a -mtime +30 \) -exec rm -r {} \; &
find . \( -name "*.trm" -a -cmin +1 \) -exec rm -r {} \; &
find . \( -name "*.trc" -a -cmin +1 \) -exec rm -r {} \; &
find . \( -name "*.xml" -a -cmin +5 \) -exec rm -r {} \; &
find . \( -name "*.log" -a -mtime +1 \) -exec rm -r {} \; &
find . -name "*.log" -mtime +104 -exec gzip {} \;
find . \( -name "*.aud" -a -cmin +1 \) -exec rm -r {} \; &

find /u01/app/oracle/admin/ogld01dr/adump \( -name "*.aud" -a -cmin +1 \) -exec rm -r {} \; &
find /u01/app/oracle/admin \( -name "*.aud" -a -cmin +1 \) -exec rm -r {} \; &


alter system switch logifle

set pages 2000
set lines 2000
select value from v$diag_info;


du -sg * | sort -nr |head -30
du -g . |sort -n 
du -sh * | sort -nr 
du -h .|sort -n |tail -30
echo > DBSAPDEV_arc1_57978.trc
echo > gipcd.trc

find /oracle/diag/tnslsnr/i99sv422mic0p \( -name "*.trc" -a -cmin +1 \) -exec rm -r {} \; &
find /oracle/diag/tnslsnr/i99sv422mic0p \( -name "*.trm" -a -cmin +1 \) -exec rm -r {} \; &
find /u01 \( -name "*.aud" -a -cmin +1 \) -exec rm -r {} \; &

find /u01 \( -name "*.dmp" -a -cmin +1 \) -exec ls -l {} \; &

find /oracle/soft/database/19.0.0/db_1/rdbms/audit \( -name "*.aud" -a -cmin +1 \) -exec rm -r {} \; &
find /u01/app/oracle/admin/DBPSTHST/adump \( -name "*.aud" -a -cmin +1 \) -exec rm -r {} \; &
find /u01/app/oracle/admin/DBMSPPRD/adump \( -name "*.aud" -a -cmin +1 \) -exec rm -r {} \; &
find . \( -name "*.trm" -a -cmin +1 \) -exec rm -r {} \; &
find . \( -name "*.trc" -a -cmin +1 \) -exec rm -r {} \; &
find /grid \( -name "*.trc" -a -cmin +1 \) -exec rm -r {} \; &
find /grid \( -name "*.trm" -a -cmin +1 \) -exec rm -r {} \; &
find . \( -name "*.xml" -a -cmin + \) -exec rm -r {} \; &

%Un%!I0*MX8Ot!*acH


gzip -c arquivo.txt > arquivo.txt.gz
gzip -c listener_sva.log > listener_sva.log_bkp23112024.gz

