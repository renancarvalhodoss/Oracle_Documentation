------------------ encontrar diretorio do dump -------------------------- 

SET LINESIZE 150
COLUMN owner FORMAT A20
COLUMN directory_name FORMAT A25
COLUMN directory_path FORMAT A80
SELECT *
FROM dba_directories
ORDER BY owner, directory_name;

----------------- criar diretorio do dump -------------------------------

create directory dump_full as 'D:\SR13347370';
create or replace directory first_dump as '/home/oracle/dumps/first_dump';
grant read, write on directory dump_full to public;



----------------- criar parfile para execucao de varias tabelas (nivel so) -----------
expdp_SR12660493.par


userid='/as sysdba'
directory=first_dump
dumpfile=teste_exp.dmp
logfile=teste_exp.log
cluster=n
compression=all
flashback_time=systimestamp
tables=PRODUCTS




------------------------- dump in line -------------------------------------

promotion2.pr_omnia_control
promotion2.pr_omnia_xml
promotion2.pr_omnia_log
promotion2.pr_omnia_return

nohup expdp \'/ as sysdba\' tables=PRODUCTS, CLIENTS, EMPLOYEE directory=first_dump dumpfile=teste_exp.dmp logfile=teste_exp.log COMPRESSION=ALL flashback_time=systimestamp &
nohup expdp \'/ as sysdba\' tables=promotion2.pr_omnia_xml directory=first_dump dumpfile=teste_exp.dmp logfile=promotion2.bkp_pr_omnia_xml.log COMPRESSION=ALL &
nohup expdp \'/ as sysdba\' tables=promotion2.pr_omnia_log directory=DUMP_TABLES dumpfile=promotion2.bkp_pr_omnia_log.dmp logfile=promotion2.bkp_pr_omnia_log.log COMPRESSION=ALL &
nohup expdp \'/ as sysdba\' tables=promotion2.pr_omnia_return directory=DUMP_TABLES dumpfile=promotion2.bkp_pr_omnia_return.dmp logfile=promotion2.bkp_pr_omnia_return.log COMPRESSION=ALL &

 
expdp \'/ as sysdba\' FULL=Y DIRECTORY=dump_full DUMPFILE=full_export.dmp LOGFILE=full_export.log 
expdp userid=\"/ as sysdba\" FULL=Y DIRECTORY=dump_full DUMPFILE=full_export.dmp LOGFILE=full_export.log


expdp userid=\"/ as sysdba\"  logfile=estimate_SCRAPSCALE_exp.log DIRECTORY=dump SCHEMAS=SCRAPSCALE LOGTIME=all estimate_only=TRUE


------------------------- verificar owner da tabela --------------------------

select count(*) segments,
round(sum(bytes)/1024/1024/1024,2) size_GB from dba_segments where owner in ('SAPSR3','SCRAPSCALE');


