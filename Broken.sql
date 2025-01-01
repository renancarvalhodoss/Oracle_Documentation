set lines 200
 set pagesize 1000
 col WHAT for a50;
select job, BROKEN, WHAT from dba_jobs where job=121990; //Insere o job do IN e faz a validação
exec sys.dbms_ijob.broken(121990,FALSE); //substitui pelo numero do job no IN
select JOB,SCHEMA_USER,BROKEN,WHAT from dba_jobs where BROKEN='Y' and job=121990; // ai roda esse pra ver se retorna algo