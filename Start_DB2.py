PROCEDIMENTO DE START E STOP BANCO
1 - Pegar user e senha na UAT do(s) servidor(es) - (72h se possível)
#STOP
> Logar no servidor;
> ps -ef |grep -i db2sysc (ver as instâncias do banco)

> sudo su - (entrar na root)

> su - _instância_ (entrar na instância)

> db2 list db directory (listar bancos)

> db2 list application (listar se tem conexão no banco)

Caso apareça aplicações ativas, avisar ao sme da app para parar a app ou se nós podemos derrubar as conexões; 
> db2 force application all (derruba as conexões)

Mesmo após usar o comando acima aparecer app ativa dar:
> db2stop force 

Senão tiver aplicações ativas só dar o stop.
> db2stop (para parar o banco)

*Caso tenha mais instâncias, repetir o procedimento em todas;

-------------------------------------

DqNh6kGo)@)5p6JO
#START 
> Logar no servidor;
> ps -ef |grep -i db2sysc (ver as instâncias do banco)
> sudo su - (entrar na root)
> su - _instância_
> db2start
> db2 list db directory
> db2 activate db NOMEBANCO
*Caso tenha mais instâncias, repetir o procedimento em todas;








=======================================



TASK - STOP (tirado do servidor)
login as: soadm2
soadm2@10.1.10.33's password: 
Last login: Fri May 20 10:11:05 2022 from 158.98.177.25
soadm2@hoitmt001ger ~]$ ps -ef |grep -i db2sysc
soadm2    10289   9716  0 10:35 pts/3    00:00:00 grep --color=auto -i[01;31m[Kdb2sysc[m[K
db2teps   32269  32267  1 Feb18 ?        1-06:52:59 [01;31m[Kdb2sysc[m[K 0
db2tdw    33459  33457 99  2021 ?        1406-13:46:04 [01;31m[Kdb2sysc[m[K 0
[soadm2@hoitmt001ger ~]$ sudo su -
Last login: Fri May 20 10:24:03 -03 2022 on pts/1
[root@hoitmt001ger ~]# su - db2teps
Last login: Fri May 20 09:12:12 -03 2022
[db2teps@hoitmt001ger ~]$ db2 list application
SQL1611W  No data was returned by Database System Monitor.
[db2teps@hoitmt001ger ~]$ db2stop
05/20/2022 10:35:53     0   0   SQL1064N  DB2STOP processing was successful.
SQL1064N  DB2STOP processing was successful.
[db2teps@hoitmt001ger ~]$ exit
logout
[root@hoitmt001ger ~]# su - db2tdw
Last login: Fri May 20 09:11:33 -03 2022
[db2tdw@hoitmt001ger ~]$ db2 list application
Auth Id  Application    Appl.      Application Id                                                 DB       # of
         Name           Handle                                                                    Name    Agents
-------- -------------- ---------- -------------------------------------------------------------- -------- -----
ITMUSER  db2jcc_applica 7024       10.1.10.33.42486.220423180658                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 6241       10.1.10.33.42482.220423180656                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 40208      10.1.10.34.35888.220626205850                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 12234      10.1.10.34.47944.220624230647                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 45898      10.1.10.34.60742.220626203953                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 38990      10.1.10.34.39442.220607190330                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 63029      10.1.10.34.46388.220625133522                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 62871      10.1.10.34.39142.220626141908                                  WAREHOUS 1    
ITMUSER  db2bp          19759      *LOCAL.db2tdw.220227112050                                     WAREHOUS 1    
ITMUSER  db2jcc_applica 54402      10.1.10.33.42484.220423180657                                  WAREHOUS 1    
[db2tdw@hoitmt001ger ~]$ db2 list application
Auth Id  Application    Appl.      Application Id                                                 DB       # of
         Name           Handle                                                                    Name    Agents
-------- -------------- ---------- -------------------------------------------------------------- -------- -----
ITMUSER  db2jcc_applica 49307      10.1.10.34.37138.220626211557                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 7024       10.1.10.33.42486.220423180658                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 6241       10.1.10.33.42482.220423180656                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 40208      10.1.10.34.35888.220626205850                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 12234      10.1.10.34.47944.220624230647                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 45898      10.1.10.34.60742.220626203953                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 38990      10.1.10.34.39442.220607190330                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 63029      10.1.10.34.46388.220625133522                                  WAREHOUS 1    
ITMUSER  db2bp          19759      *LOCAL.db2tdw.220227112050                                     WAREHOUS 1    
ITMUSER  db2jcc_applica 54402      10.1.10.33.42484.220423180657                                  WAREHOUS 1    
[db2tdw@hoitmt001ger ~]$ db2 force application all
DB20000I  The FORCE APPLICATION command completed successfully.
DB21024I  This command is asynchronous and may not be effective immediately.
[db2tdw@hoitmt001ger ~]$ db2 force application all
Auth Id  Application    Appl.      Application Id                                                 DB       # of
         Name           Handle                                                                    Name    Agents
-------- -------------- ---------- -------------------------------------------------------------- -------- -----
ITMUSER  db2jcc_applica 49184      10.1.10.34.37742.220626211655                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 45855      10.1.10.34.37736.220626211651                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 46056      10.1.10.34.37738.220626211652                                  WAREHOUS 1    
ITMUSER  db2jcc_applica 47608      10.1.10.34.37740.220626211653                                  WAREHOUS 1    
[db2tdw@hoitmt001ger ~]$ db2stop force
05/20/2022 10:42:38     0   0   SQL1064N  DB2STOP processing was successful.
SQL1064N  DB2STOP processing was successful.
[db2tdw@hoitmt001ger ~]$ 



TASK - START (tirado do servidor)
login as: soadm2
soadm2@10.1.10.33's password:
Last login: Fri May 20 10:33:37 2022 from 158.98.177.25
IBM's internal systems must only be used for conducting IBM's business or for purposes authorized by IBM management
Use is subject to audit at any time by IBM management
[soadm2@hoitmt001ger ~]$ ps -ef |grep -i db2sysc
soadm2    28617  28576  0 11:23 pts/1    00:00:00 grep --color=auto -i db2sysc
[soadm2@hoitmt001ger ~]$ sudo su -
Last login: Fri May 20 11:13:54 -03 2022 on pts/0
[root@hoitmt001ger ~]# su - db2teps
Last login: Fri May 20 10:35:21 -03 2022 on pts/3
[db2teps@hoitmt001ger ~]$ db2start
05/20/2022 11:24:42     0   0   SQL1063N  DB2START processing was successful.
SQL1063N  DB2START processing was successful.
[db2teps@hoitmt001ger ~]$ exit
logout
[root@hoitmt001ger ~]# su -  db2tdw
Last login: Fri May 20 10:36:14 -03 2022 on pts/3
[db2tdw@hoitmt001ger ~]$ db2start
05/20/2022 11:25:16     0   0   SQL1063N  DB2START processing was successful.
SQL1063N  DB2START processing was successful.
[db2tdw@hoitmt001ger ~]$