create table clients (nome varchar2(20), cpf varchar2(11)) tablespace DATA;
create table employee (nome varchar2(20), matricula number) tablespace DATA;


insert into employee values ( 'MAria', 456454);
insert into employee values ( 'Joana', 5455464);
insert into employee values ( 'Sebastina', 456456);
insert into employee values ( 'Nazare', 64546556);
insert into employee values ( 'Sara', 45645);


SELECT tablespace_name, table_name, owner FROM dba_tables;

set linesize 1000
set pagesize 1000
COL owner FORMAT A10
COL table_name FORMAT A10
SELECT  table_name, owner FROM dba_tables where tablespace_name = 'DATA' ;