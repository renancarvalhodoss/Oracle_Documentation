-- ativa flashback
SQL> alter database flashback on;

Database altered.

--criar restore point
SQL> create restore point CLEAN_DB guarantee flashback database;

Restore point created.


col name for a60;
select * from v$tablespace
where flashback_on != 'YES';

col name for a10
set lines 1000
col time for a20
col RESTORE_POINT_TIME for a20
select SCN,DATABASE_INCARNATION#, GUARANTEE_FLASHBACK_DATABASE, STORAGE_SIZE/1024/1024 TAMANHO_MB, TO_CHAR(TIME, 'dd/mm/yyyy hh24:mi') "DATA", RESTORE_POINT_TIME, PRESERVED, NAME
 from v$restore_point;

       SCN DATABASE_INCARNATION# GUA TAMANHO_MB DATA             RESTORE_POINT_TIME   PRE NAME
---------- --------------------- --- ---------- ---------------- -------------------- --- ----------
2278876227                     1 YES        800 12/11/2023 05:18                      YES CLEAN_DB