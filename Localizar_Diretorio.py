find / -type d -name 'backup'
find / -type d -name "ibmdba"
find / -name 'BKP_RDFCATDEVDB_CATDB01_ARCHIVE'
find . -name '.aud'

Used TNSNAMES adapter to resolve the alias
Attempting to contact (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 10.100.30.61)(PORT = 1555)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = rman1.world)))



 WARNING: You are trying to use the MEMORY_TARGET feature. This feature requires the /dev/shm file system to be mounted for at least 5368709120 bytes. /dev/shm is either not mounted or is mounted with available space less than this size. 
Please fix this so that MEMORY_TARGET can work as expected. Current available is 5173637120 and used is 3416297472 bytes. Ensure that the mount point is /dev/shm for this directory.

mount -o remount,size=6G /dev/shm
tmpfs    /dev/shm   tmpfs   size=6G  0 0
startup pfile='/u01/app/oracle/admin/DBFPPRD/pfile/init.ora.6272016144235';
startup nomount pfile='/u01/app/oracle/product/12.1.0/dbs/spfileDBFPPRD.ora';
/u01/app/oracle/admin/DBFPPRD/pfile/init.ora.6272016144235
SPFILE= /u01/app/oracle/admin/DBFPPRD/pfile/init.ora.6272016144235
DBFPPRD.__db_cache_size=2080374784
DBFPPRD.__java_pool_size=16777216
DBFPPRD.__large_pool_size=50331648
DBFPPRD.__oracle_base='/u01/app/oracle'#ORACLE_BASE set from environment
DBFPPRD.__pga_aggregate_target=1879048192
DBFPPRD.__sga_target=3489660928
DBFPPRD.__shared_io_pool_size=167772160
DBFPPRD.__shared_pool_size=1157627904
DBFPPRD.__streams_pool_size=0
*.audit_file_dest='/u01/app/oracle/admin/DBFPPRD/adump'
*.audit_trail='db'
*.compatible='12.CC"fd1.0.2.0'
*.control_file_record_keep_time=60
C"^@^@^A^@^@^@^@^@^@^@^@^@^A^Dqé^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^G^@^@^@^@^B^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^B^@^@¤^D^@^@<88>Ë^XC^@^@^@^@^@^@^@^@^@^@^@^@^@*.control_files='/u01/oradata/DBFPPRD/CTL/control01.ctl','/u01/oradata/DBFPPRD/CTL/control02.ctl'
*.db_block_checksum='FALSE'
*.db_block_size=8192
*.db_domain=''
*.db_name='DBFPPRD'
*.db_recovery_file_dest_size=322122547200
*.db_recovery_file_dest='/u01/oradata/DBFPPRD/ARC'
*.diagnostic_dest='/u01/app/oracle'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=DBFPPRDXDB)'
*.local_listener='LISTENER_DBFPPRD'
*.log_archive_dest_1='LOCATION=USE_DB_RECOVERCC"Y@Y_FILE_DEST'
*.log_archive_format='%t_%s_%r.dbf'
*.memory_max_target=5368709120
*.memory_target=5368709120
*.open_cursors=500
*.processes=700
*.remote_login_passwordfile='EXCLUSIVE'
*.undo_tablespace='UNDOTBS1'















oracle12@dpspsp-db01] /u01/app/oracle/admin/DBFPPRD/pfile > cat /u01/app/oracle/admin/DBFPPRD/pfile/init.ora.6272016144235
##############################################################################
# Copyright (c) 1991, 2013 by Oracle Corporation
##############################################################################

###########################################
# Archive
###########################################
log_archive_dest_1='LOCATION=/u01/oradata/DBFPPRD/ARC'
log_archive_format=%t_%s_%r.dbf

###########################################
# Cache and I/O
###########################################
db_block_size=8192

###########################################
# Cursors and Library Cache
###########################################
open_cursors=500

###########################################
# Database Identification
###########################################
db_domain=""
db_name="DBFPPRD"

###########################################
# File Configuration
###########################################
control_files=("/u01/oradata/DBFPPRD/CTL/control01.ctl", "/u01/oradata/DBFPPRD/CTL/control02.ctl")

###########################################
# Miscellaneous
###########################################
compatible=12.1.0.2.0
diagnostic_dest=/u01/app/oracle
memory_target=6144m

###########################################
# Network Registration
###########################################
local_listener=LISTENER_DBFPPRD

###########################################
# Processes and Sessions
###########################################
processes=700
db_domain=""

###########################################
# Security and Auditing
###########################################
audit_file_dest="/u01/app/oracle/admin/DBFPPRD/adump"
audit_trail=db
remote_login_passwordfile=EXCLUSIVE

###########################################
# Shared Server
###########################################
dispatchers="(PROTOCOL=TCP) (SERVICE=DBFPPRDXDB)"

###########################################
# System Managed Undo and Rollback Segments
###########################################
undo_tablespace=UNDOTBS1

compatible=12.1.0.2.0
diagnostic_dest=/u01/app/oracle
memory_target=7144m

###########################################
# Network Registration
###########################################
local_listener=LISTENER_DBFPPRD

###########################################
# Processes and Sessions
###########################################
processes=700

###########################################
# Security and Auditing
###########################################
audit_file_dest="/u01/app/oracle/admin/DBFPPRD/adump"
audit_trail=db
remote_login_passwordfile=EXCLUSIVE

###########################################
"init.ora.6272016144235" 66L, 2003C                                                                                                                                                                                        45,1          77% 











nohup ./RmanBackupOnline.ksh prd5132 DIA &