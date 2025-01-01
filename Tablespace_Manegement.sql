--------listar tablespace--------

 set linesize 1000
 set pagesize 1000
 set trimspool on
 col free format 999999990.00
 col used format 999999990.00
 col megas format 999999990.00
 col PCT_USED format 99.00
 COL NAME FORMAT A17
 col banco format a30

 select i.host_name || '-'|| i.instance_name banco,nvl(b.tablespace_name,nvl(a.tablespace_name,'UNKOWN')) name,
       mbytes_alloc megas,
       round(mbytes_alloc-nvl(mbytes_free,0),2) used,
       round(nvl(mbytes_free,0),2) free, 
       --round(nvl(largest,0),2) largest,
       trunc(((mbytes_alloc-nvl(mbytes_free,0))/mbytes_alloc)*100,2) pct_used
  from ( select  sum(bytes)/1024/1024 mbytes_free, max(bytes)/1024/1024 largest, tablespace_name from sys.dba_free_space group by tablespace_name ) a,
       ( select sum(bytes)/1024/1024 mbytes_alloc, tablespace_name from sys.dba_data_files group by tablespace_name ) b,
       ( select sum(next_extent)/1024/1024 mbytes_nexts, tablespace_name from sys.dba_segments group by tablespace_name ) c, v$instance i
  where a.tablespace_name (+) = b.tablespace_name and
        c.tablespace_name (+) = b.tablespace_name
--and   trunc(((mbytes_alloc-nvl(mbytes_free,0))/mbytes_alloc)*100,2) >80
--AND  b.tablespace_name='TS_INTRANET_DT1'
   order by 6 asc;




SET LINESIZE 1000
SET PAGESIZE 100
COLUMN tablespace_name FORMAT A10
col host_ip for A20
col host_name for A20
col instance_name for A20
col platform_name for A30
SELECT B.name "Tablespace Name", UTL_INADDR.GET_HOST_ADDRESS AS host_ip,
c.host_name,c.instance_name, d.platform_name
from v$instance c, v$database d,v_$tablespace B
--WHERE B.name ='PSAPSR3'



compute sum of size SIZE_GB on report
break on report
 set pagesize 1000
set linesize 1000
col owner for a20
col table_name for a30
col type for a15
col segment_name for a35
col lob_table for a25
col lob_col for a25
col tbs_name for a25
select seg.owner, seg.segment_name, seg.segment_type as TYPE, 
nvl(lob.table_name,'---') as LOB_TABLE, nvl(lob.column_name,'---') as LOB_COL, 
seg.tablespace_name as TBS_NAME,
round(sum(seg.bytes/1024/1024/1024),2) as SIZE_GB 
from dba_segments seg left join dba_lobs lob on seg.segment_name = lob.segment_name
--where seg.segment_name in ('KONP')
--seg.owner in ('SAPSR3')
-- seg.tablespace_name = 'PSAPSR3DB2'
where round(seg.bytes/1024/1024/1024,2) > 10
--seg.segment_name in ('EDI40')
--lob.table_name = 'CDHDR'
group by seg.owner, seg.segment_name, seg.segment_type, seg.tablespace_name, lob.table_name, lob.column_name  
order by 7 desc;


   ------------=liste os datafile ta tablespace especificada=----------------

set pagesize 1000
set linesize 1000
 col megas format 999999990.00
COL FILE_NAME FORMAT A110
SELECT d.bytes/1024/1024 megas,v.CREATION_TIME, d.autoextensible,maxbytes/1024/1024, 
chr(39)||d.file_name||chr(39) file_name
FROM dba_data_files D,v$datafile v WHERE d.file_id=v.file#
--and d.bytes/1024/1024 < 32767
and d.tablespace_name in ('&TBS') 
--and FILE_NAME LIKE '%/oracle/PYE/sapdata15/sr3.data79/data79%'
ORDER BY v.CREATION_TIME;

set pages 1000
            set lines 300
            set trims on
            col tablespace_name format a30   TRUNC word_wrapped   heading "Tabsp Name"
            col file_name       format a50   TRUNC  word_wrapped  heading "File Name"
            col total_size      format 999,999,999     heading "Size Mb"
            col free_space      format 999.999,999     heading "Free Mb"
            col pct_used        format 999.00         heading "%|Used"
 
            clear breaks
 
            select df.file_id
            ,      df.file_name
            ,      df.tablespace_name
            ,      df.bytes/1024/1024                        total_size
            ,      nvl(fr.bytes/1024/1024,0)                 free_space
            ,      ((df.bytes-nvl(fr.bytes,0))/df.bytes)*100 pct_used
            , df.AUTOEXTENSIBLE
            from   (select sum(bytes) bytes
                    ,      file_id
                    from   dba_free_space
                    group by file_id)     fr
            ,       dba_data_files        df
            where df.file_id = fr.file_id(+)
                 and tablespace_name = '&1'
            order by free_space ASC
            /
EAIQAS

----------check Too many database files--------------------------

col max_data_files form a20
select value as max_data_files,
(SELECT COUNT(*) 
FROM dba_data_files D, v$datafile v
WHERE d.file_id=v.file#) curent_db_files,round((SELECT COUNT(*) 
FROM dba_data_files D, v$datafile v
WHERE d.file_id=v.file#)*100/value,2) as PCT_USED
from v$parameter p where p.name = 'db_files';

-------------------= caso asm verifica espaço do diskgroup listando os disk groups =------------------------

set lines 380
set pages 999
col "Group Name"   form a20
col "Disk Name"    form a25
col "State"  form a12

col "Type"   form a7
col "gbtotal_Bruto"   	form 9999999999
col gbtotal_livre_bruto form 9999999999
col "Total GB"			form 9999999999
col "Free GB"			form 9999999999
col LivrePerc		form 999.99
prompt
prompt ASM Disk Groups
prompt ===============
select  name "Group Name",  total_mb/1024 gbtotal_Bruto,free_mb/1024 gbtotal_livre_bruto,
(total_mb-REQUIRED_MIRROR_FREE_MB)/decode(type,'EXTERN',1,'NORMAL',2,'HIGH',3)/1024 
"Total GB",
(USABLE_FILE_MB/1024) "Free GB",
(USABLE_FILE_MB/1024)/((total_mb-REQUIRED_MIRROR_FREE_MB)/decode(type,'EXTERN',1,'NORMAL',2,'HIGH',3)/1024)*100 LivrePerc
from   v$asm_diskgroup;


set lines 380
set pages 999
col name   form a40
col state  form a12
col path  form a40
SELECT name, disk_number,state, path
FROM V$ASM_DISK
WHERE group_number = (SELECT group_number FROM V$ASM_DISKGROUP WHERE name = 'RECOC1');


set lines 200;
select group_number "Group",
name "Group Name",
state "State",
type "Type",
total_mb / 1024 "Total GB",
free_mb / 1024 "Free GB",
decode(total_mb,0,0,(ROUND((1- (free_mb / total_mb))*100, 2)))  pct_used from v$asm_diskgroup;


select name,total_mb / 1024 "Total GB", free_mb / 1024 "Free GB",
decode(total_mb,0,0,(ROUND((1- (free_mb / total_mb))*100, 2)))  pct_used 
 from v$asm_diskgroup where name='DATAC1';
ALTER database datafile '/u01/oradata/cybhom/expdados.dbf' resize 3921 M;
select name,  USABLE_FILE_MB, total_mb, free_mb from v$asm_diskgroup;


--------------------------senao verifica o datafile----------------------
3 - VERIFICAR TAMANHO DO DATAFILE

!df -k '/opt/oracle/oradata/ORCL/tbs402.dbf'
!df -gt |grep sapdata
!df -gt |grep data
!df -h |grep data


--------------------se houver espaço add ou aumentar datafile ------------------


-- resize datafile 
ALTER database datafile '/oracle/INTPRD/data3/ts_intranet_ix1_01.dbf' resize 27000m;
     ALTER DATABASE DATAFILE '/oracle/INTPRD/data3/ts_intranet_dt1_30.dbf' RESIZE 15500m;  
     ALTER DATABASE DATAFILE '+DATA/PID/DATAFILE/psapundo.276.1119903879' RESIZE 4000m;  
     ALTER database datafile '+DATA/PID/DATAFILE/sysaux.270.1119904063' resize 5500m;

--create new datafile
     alter tablespace EAIDEV add datafile '/oracle/DEAI/oradata/eaidev13.dbf' size 470m;
     alter tablespace EAIDEV add datafile '/oracle/DEAI/oradata3/eaidev14.dbf' size 520m;
     alter tablespace MSAF_DATA add datafile '+DG_MSAF_DATA' size 32767m;
     alter tablespace PSAPSR3 add datafile '/oracle/ACP/sapdata3/sr3_13/sr3.data18' size 32767m;




------------------------------shirink---------------------------------------------
set lines 300
set pages 500
col comando for a100
Select 'ALTER database datafile ''' || File_name || ''' resize ' || smallest_Mb || ' M;' Comando FROM (
  SELECT
       file_name as File_name,  ceil( (nvl(hwm,1)*C.VALUE)/1024/1024 ) as smallest_Mb,  ceil( blocks*C.VALUE/1024/1024) as currsize_Mb,
       ceil( blocks*C.VALUE/1024/1024) - ceil( (nvl(hwm,1)*C.VALUE)/1024/1024 ) as Shrink_Mb,
       a.autoextensible as Auto_extend , a.maxbytes/1024/1024 as Extend_max_MB
  FROM dba_data_files a,
       (select file_id, max(block_id+blocks-1) hwm from dba_extents group by file_id ) b,
       (select value from v$parameter where name = 'db_block_size') C
  WHERE a.file_id = b.file_id(+) AND a.file_name in (select FILE_NAME from  dba_data_files)
  and a.tablespace_name = '&tablespace'
) WHERE 1=1 order by smallest_Mb desc;



ALTER database datafile '+DATA/PID/DATAFILE/psapsr3db.305.1188572913' resize 3600m;
ALTER database datafile '+DG_MSAF_DATA/DBMSPDR1/DATAFILE/msaf_data.687.1164213171' resize 32676 M;

ALTER database datafile '+GROBSMPQ_DATA/GROBSMPQ/DATAFILE/undotbs1.299.1107285641' resize 32767m;
ALTER database datafile '+DATA_MSAF_2024/OMSFN/DATAFILE/msaf_data01.1685.1185705315' resize 32767m;
ALTER database datafile '+DATA_MSAF_2024/OMSFN/DATAFILE/msaf_data01.1336.1185705345' resize 32767m;


--------------------resize tbs temp -------------------------

set linesize 1000
set pagesize 1000
set trimspool on
col free format 999999990.00
col used format 999999990.00
col megas format 999999990.00
--col PCT_USED format 999.00
COL NAME FORMAT A27
col banco format a30
col TABLESPACE_NAME format a20

select t.tablespace_name                                 as tablespace_name
            ,ROUND(c.gb,2)                                              as total_gb
            ,ROUND(c.gb-nvl(a.sum_bytes_free,0)/1024/1024/1024,2)            as used_GB
            ,ROUND(nvl(a.sum_bytes_free/1024/1024/1024,0),2)                 as free_GB
            ,ROUND(nvl(a.max_bytes_free/1024/1024/1024,0),2)                 as max_free
            ,ROUND(nvl((a.sum_bytes_free/1024/1024/1024)/(c.gb)*100,0),2)    as perc_free
        --    ,a.qtd_frags                                       as qtd_frags
       --     ,c.increment_by*t.block_size/1024/1024             as inc_by
         --   ,decode(c.increment_by,0,'NO','YES')               as inc_by_sn
          --  ,c.maxblocks*t.block_size/1024/1024                as max_size
         --   ,c.gb/(c.maxblocks*t.block_size/1024/1024)*100     as perc_used
      from dba_tablespaces t,
      (
        select t1.tablespace_name,
               avg(d1.increment_by) as increment_by,
               sum(decode(d1.maxblocks,0,d1.bytes/t1.block_size,d1.maxblocks)) as maxblocks,
               sum(bytes)/1024/1024/1024 as gb
        from dba_temp_files  d1,
             dba_tablespaces t1
        where t1.tablespace_name = d1.tablespace_name
        group by t1.tablespace_name
      )                    c,
      (
        select t.tablespace_name, sum(s.free_blocks*t.block_size) sum_bytes_free, sum(s.free_blocks*t.block_size) max_bytes_free, 0 qtd_frags
        from gv$sort_segment s,
             dba_tablespaces t
        where t.tablespace_name = s.tablespace_name
        group by t.tablespace_name
      )                    a
      where t.tablespace_name      = c.tablespace_name
        and c.tablespace_name      = a.tablespace_name (+)
      group by t.tablespace_name                              ,
               c.gb                                           ,
               nvl(a.max_bytes_free/1024/1024/1024,0)              ,
               nvl(a.sum_bytes_free/1024/1024/1024,0)              ,
               nvl((a.sum_bytes_free/1024/1024/1024)/(c.gb)*100,0) ,
               c.gb-nvl(a.sum_bytes_free,0)/1024/1024/1024    ,     
               a.qtd_frags                                    ,
               c.increment_by*t.block_size/1024/1024          ,
               decode(c.increment_by,0,'NO','YES')            ,
               c.gb/((c.maxblocks)*t.block_size/1024/1024)*100,
               (c.maxblocks)*t.block_size/1024/1024
      --order by perc_used
/


set linesize 600
set pagesize 600
COL file_name FORMAT A50
select file_id, file_name, (bytes/1024)/1024 bytes_MB, autoextensible from dba_temp_files;



alter database tempfile '/u01/app/oracle/oradata/cm/dados01.dbf' resize 1024m;
alter tablespace TEMP add tempfile '+DG_DATA' size 32767M;





set linesize 200
set pagesize 200
column dummy          noprint
column pct_used       format 999.9       heading "%|Used"
column name           format a25         heading "Tablespace Name"
column Mbytes         format 999,999,999 heading "MBytes" 
column Used_Mbytes    format 999,999,999 heading "Used|MBytes"
column Free_Mbytes    format 999,999,999 heading "Free|MBytes"
column Largest_Mbytes format 999,999,999 heading "Largest|MBytes"
column Max_Size       format 999,999,999 heading "MaxPoss|MBytes"
column pct_max_used   format 999.9       heading "%|Max|Used"
break   on  report 
compute sum of Mbytes      on report 
compute sum of Free_Mbytes on report 
compute sum of Used_Mbytes on report 
select ( select decode(extent_management,'LOCAL','*',' ') || 
                decode(segment_space_management,'AUTO','a ','m ')
       from dba_tablespaces
       where tablespace_name = b.tablespace_name
     ) || nvl(b.tablespace_name,nvl(a.tablespace_name,'UNKOWN')) name
     , Mbytes_alloc Mbytes
     , Mbytes_alloc-nvl(Mbytes_free,0) Used_Mbytes
     , nvl(Mbytes_free,0) Free_Mbytes
     , ((Mbytes_alloc-nvl(Mbytes_free,0))/Mbytes_alloc)*100 pct_used
     , nvl(Mbytes_largest,0) Largest_Mbytes
     , nvl(Mbytes_max,Mbytes_alloc) Max_Size
     , decode(Mbytes_max,0,0,(Mbytes_alloc/Mbytes_max)*100) pct_max_used
from ( select sum(bytes)/1024/1024   Mbytes_free
        , max(bytes)/1024/1024 Mbytes_largest
        , tablespace_name
     from  sys.dba_free_space
     group by tablespace_name
   ) a,
     ( select sum(bytes)/1024/1024      Mbytes_alloc
        , sum(maxbytes)/1024/1024 Mbytes_max
        , tablespace_name
     from sys.dba_data_files
     group by tablespace_name
     union all
       select sum(bytes)/1024/1024      Mbytes_alloc
        , sum(maxbytes)/1024/1024 Mbytes_max
        , tablespace_name
     from sys.dba_temp_files
     group by tablespace_name
   ) b
where a.tablespace_name (+) = b.tablespace_name
order by 1
/