crsctl stat res -t (status) 
crsctl stop has (parando) 
crsctl start has -wait (iniciando)
srvctl status scan_listener
crsctl stop crs

srvctl status service -d 'database_name' -s 'service_name'
ex:
srvctl status service -d ogld02pr -s report_gold
srvctl start service -d ogld02pr -s report_gold

select value from v$parameter where name like '%service_name%';

srvctl start scan_listener

select * from V$DIAG_INFO where name ='Diag Trace';
chown oracle:dba /dev/mapper/DISK_ASM02 ; chown oracle:dba /dev/mapper/DISK_ASM02p1 ; chown oracle:dba /dev/mapper/DISK_ARCH00p1 ; chown oracle:dba /dev/mapper/DISK_ASM04p1 ; chown oracle:dba /dev/mapper/DISK_ASM05p1 ; chown oracle:dba /dev/mapper/DISK_ASM06p1 ; chown oracle:dba /dev/mapper/DISK_ASM07p1 ; chown oracle:dba /dev/mapper/DISK_ASM08p1 ; chown oracle:dba /dev/mapper/DISK_ASM09p1 ; chown oracle:dba /dev/mapper/DISK_ASM10p1 ; chown oracle:dba /dev/mapper/DISK_ASM11p1 ; chown oracle:dba /dev/mapper/DISK_ASM12p1 ; chown oracle:dba /dev/mapper/DISK_ASM13p1 ; chown oracle:dba /dev/mapper/DISK_ASM14p1 ; chown oracle:dba /dev/mapper/DISK_ASM15p1 ; chown oracle:dba /dev/mapper/DISK_REDO00p1 ; chown oracle:dba /dev/mapper/DISK_ARCH00 ; chown oracle:dba /dev/mapper/DISK_ASM04 ; chown oracle:dba /dev/mapper/DISK_ASM05 ; chown oracle:dba /dev/mapper/DISK_ASM06 ; chown oracle:dba /dev/mapper/DISK_ASM07 ; chown oracle:dba /dev/mapper/DISK_ASM08 ; chown oracle:dba /dev/mapper/DISK_ASM09 ; chown oracle:dba /dev/mapper/DISK_ASM10 ; chown oracle:dba /dev/mapper/DISK_ASM11 ; chown oracle:dba /dev/mapper/DISK_ASM12 ; chown oracle:dba /dev/mapper/DISK_ASM13 ; chown oracle:dba /dev/mapper/DISK_ASM14 ; chown oracle:dba /dev/mapper/DISK_ASM15 ; chown oracle:dba /dev/mapper/DISK_REDO00 



set pagesize 2000
set linesize 2000
col PATH format a30
col ASMDISK for a30
col MOUNT_STATUS for a10
col STATE for a10
col DISKGROUP for a30
SELECT SUBSTR(d.name,1,16) AS asmdisk, d.mount_status, d.state, d.TOTAL_MB/1024, d.PATH,
        dg.name AS diskgroup FROM V$ASM_DISKGROUP dg, V$ASM_DISK d
         WHERE dg.group_number = d.group_number order by DISKGROUP, PATH;
