Mostra os discos candidatos e o tamanho deles:
set line 200
col path for a40
set pagesize 500
select group_number, path, header_status, total_mb, free_mb, OS_MB from v$asm_disk where header_status !='MEMBER' order by 2;


Ex:
GROUP_NUMBER DISK_NUMBER MOUNT_S MODE_ST STATE      TOTAL_MB    FREE_MB NAME            PATH
------------ ----------- ------- ------- -------- ---------- ---------- --------------- --------------------------------------------------
           0           0 CLOSED  ONLINE  NORMAL            0          0                 /dev/oracleasm/disks/LUN011_DATA
           0           1 CLOSED  ONLINE  NORMAL            0          0                 /dev/oracleasm/disks/LUN012_DATA




alter diskgroup DATA add disk  
'/dev/oracleasm/disks/LUN011_DATA',
'/dev/oracleasm/disks/LUN012_DATA' rebalance power 8;

select * from v$asm_operation; 



col state for a10
col name for a10
col failgroup for a10
col label for a15
col path for a15
set lines 200
set pages 200
select GROUP_NUMBER, DISK_NUMBER, MOUNT_STATUS
, MODE_STATUS, STATE, REDUNDANCY, TOTAL_MB, FREE_MB
, NAME, FAILGROUP, LABEL, PATH, to_char(MOUNT_DATE,'DD-MM-YYYY HH24/:MI/:SS') from v$asm_disk;



ALTER DISKGROUP DATA ADD DISK 
'ORCL:DISK009',
'ORCL:DISK010'
DROP DISK 'DISK002',
'DISK008' rebalance power 2;














