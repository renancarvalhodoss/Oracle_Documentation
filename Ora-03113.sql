Corrigindo erro “ORA-03113: end-of-file on communication channel” no Oracle
Publicado em 29 de janeiro de 2016 por edgroliv_admin
Pode ser causado por interrupção de um “shutdown immediate” antes do término.
O mesmo ira aparecer ao efetuar um startup do banco sem um database open;
Percebi que outros erros como limite de espaço excedido para logs de arquivos venham posteriormente ajudar neste erro. veja ERRO ORA-00257.

[oracle@host ~]$ sqlplus / as sysdba
…
…
Copyright (c) 1982, 2014, Oracle. All rights reserved.
Connected to an idle instance.

SQL> startup
ORACLE instance started.

Total System Global Area 2147483648 bytes
Fixed Size 2926472 bytes
Variable Size 1224738936 bytes
Database Buffers 905969664 bytes
Redo Buffers 13848576 bytes
Database mounted.
ORA-03113: end-of-file on communication channel
Process ID: 4903
Session ID: 237 Serial number: 26032

Apos algumas tentativas: 🙁

SQL> exit
Disconnected from Oracle Database 12c
Enterprise Edition Release 12.1.0.2.0 – 64bit Production

[oracle@zeus ~]$ sqlplus / as sysdba
…
…
Connected to an idle instance.

SQL> startup nomount
ORACLE instance started.

Total System Global Area 2147483648 bytes
Fixed Size 2926472 bytes
Variable Size 1224738936 bytes
Database Buffers 905969664 bytes
Redo Buffers 13848576 bytes
SQL> alter database mount;

Database altered.

SQL> alter database clear unarchived logfile group 1;
Database altered.

SQL> alter database clear unarchived logfile group 2;
Database altered.

SQL> alter database clear unarchived logfile group 3;
Database altered.

SQL> shutdown immediate
ORA-01109: database not open

Database dismounted.
ORACLE instance shut down.

SQL> startup

ORACLE instance started.

Total System Global Area 2147483648 bytes
Fixed Size 2926472 bytes
Variable Size 1224738936 bytes
Database Buffers 905969664 bytes
Redo Buffers 13848576 bytes
Database mounted.
Database opened.
SQL>