set lines 300
set pages 999
col "Group Name"   form a35
col "Disk Name"    form a30
col "State"  form a15
col "group_number" form a20
col "Type"   form a7
col "gbtotal_Bruto"   	form 9999999999
col gbtotal_livre_bruto form 9999999999
col "Total GB"			form 9999999999
col "Free GB"			form 9999999999
col LivrePerc		form 999.99
prompt
prompt ASM Disk Groups
prompt ===============
select group_number,path , name "Group Name", state , type , total_mb/1024 gbtotal_Bruto,free_mb/1024 gbtotal_livre_bruto,
(total_mb-REQUIRED_MIRROR_FREE_MB)/decode(type,'EXTERN',1,'NORMAL',2,'HIGH',3)/1024 
"Total GB",
(USABLE_FILE_MB/1024) "Free GB",
(USABLE_FILE_MB/1024)/((total_mb-REQUIRED_MIRROR_FREE_MB)/decode(type,'EXTERN',1,'NORMAL',2,'HIGH',3)/1024)*100 LivrePerc
from v$asm_diskgroup;




-- VERIFY THE PATH THE DG IS MOUNTED

set pagesize 2000
set linesize 2000
col PATH format a30
col ASMDISK for a30
col MOUNT_STATUS for a10
col STATE for a10
col DISKGROUP for a30
SELECT SUBSTR(d.name,1,16) AS asmdisk, d.mount_status, d.state, d.TOTAL_MB/1024, d.PATH, dg.name AS diskgroup 
FROM V$ASM_DISKGROUP dg, V$ASM_DISK d
WHERE dg.group_number = d.group_number  and dg.name LIKE '%22%' order by DISKGROUP, PATH;
