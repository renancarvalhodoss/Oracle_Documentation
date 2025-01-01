CARREFOUR    BRSVPUX01    10.105.160.54    oraadm1    Senha    W+c5B0+9zx-ON7x
ps -ef|grep smon

oracle --> dwprod
sudo su - dwprod

dwprod
menu -> .

sqlplus / as sysdba

set pages 100
select username, sid, serial#, logon_time from V$session where sid ='1525' ;

SID SERIAL
alter system disconnect session '5046,30289' immediate;
alter system disconnect session '5063,32325' immediate;


set pages 100
select username, sid, serial#, logon_time, status from V$session
where sid in (5049,5064,5072,5077,5086,5094,5117,5132,5139,5144,5160,5183,5187,5189,5209,5221,5227,5230,5232,5233,5270,5273,5295,5297,5307,5357,5382,5385,5387,5401,5406,5411,5426,5435)
order by sid;

alter system kill session '1525,31077' immediate;

alter system disconnect session 'SID,SERIAL#' immediate;

alter system disconnect session '5440,11695' immediate;


DEPOIS DE GRAVAR AS LOGS COM AS EVIDENCIAS ENVIAR PARA A FILA C-CAR-BR-STEFANINI_N1_24X7
alter system disconnect session '5051,57912' immediate;
alter system disconnect session '5052,18867' immediate;
alter system disconnect session '1525,31077' immediate;







MESCAMP1 ORADBCAMP101
MESCHRP1 ORADBCHRP101
MESCVLP1 ORADBCVLP101
MESMANP1 ORADBMANP101
MESMIDP1 ORADBMIDP101
MESPTBP1 ORADBPTBP101
MESWHIP1 ORADBWHIP101
MESWILP1 ORADBWILP101
MESWTNP1 ORADBWTNP101

ORADBCAMP101, ORADBCHRP101, ORADBCVLP101, ORADBMANP101, ORADBMIDP101, ORADBPTBP101, ORADBWHIP101, ORADBWILP101, ORADBWTNP101