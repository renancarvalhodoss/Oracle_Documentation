select * from dbA_users where ACCOUNT_STATUS ='OPEN';
select username,EXPIRY_DATE, account_status  from dbA_users where ACCOUNT_STATUS LIKE '%EXPIRED%';
select username, account_status from dbA_users;

--Verificar usuarios que expiraram este ano
col USERNAME for a10
col PROFILE for a10
col EXPIRY_DATE for a20
col ACCOUNT_STATUS for a20
select username,PROFILE,EXPIRY_DATE, account_status,LOCK_DATE  from dbA_users 
where ACCOUNT_STATUS  LIKE '%EXPIRED%' and EXPIRY_DATE LIKE '%&year_expired';

--Verificar usuarios por ordem de expirar
set lines 200
col USERNAME for a10
col EXPIRY_DATE for a25
col ACCOUNT_STATUS for a20
col PROFILE for a30
select USERNAME, EXPIRY_DATE, ACCOUNT_STATUS, PROFILE from dba_users
order by EXPIRY_DATE asc;

-- view password
set lines 200
col name for a10
col password for a18
col SPARE4 for a50
select name,PASSWORD, SPARE4  from user$ where name='KORAMON';

col name for a10
col password for a20
select name,PASSWORD,EXPTIME, ASTATUS  from user$ where name='FAB4W';


--verifica usuario com status locked
col USERNAME for a10
col PROFILE for a11
col EXPIRY_DATE for a20
col ACCOUNT_STATUS for a20
select username,PROFILE,EXPIRY_DATE, account_status,LOCK_DATE  from dbA_users 
where ACCOUNT_STATUS  LIKE '%FAB4W%' 
order by LOCK_DATE asc; 

col USERNAME for a10
col PROFILE for a40
col EXPIRY_DATE for a20
col ACCOUNT_STATUS for a20
select username,PROFILE,EXPIRY_DATE, account_status,LOCK_DATE  from dbA_users 
where username  = 'SPB01634'
order by LOCK_DATE asc; 

--verifica usuario especifico
col USERNAME for a20
col PROFILE for a10
col EXPIRY_DATE for a25
select username,LOCK_DATE,EXPIRY_DATE from dbA_users where USERNAME LIKE'%SAP_LAS_EPM%';
g00d2talk4MYSEL#2

  S:8213751ADADB565CEF500CCF6A843097106D7573394C9BD1B15384963FCE;T:184F75F66A4FEBD700B96C4D0146E516747465B28E7603A96B82E76E901E4E43B60CBC7A4E6900651B6681A2AB794B5A3BF1C07992B525A2814009FF90BB74A631218DB40CE1E37B9D037FAB05DE885B
-- desbloquear usuario
ALTER USER CT_PRDBLOC ACCOUNT UNLOCK;

--  Trocar senha
ALTER USER KORAMON IDENTIFIED BY values 'BB1A013A4B8B68C7' account unlock;
ALTER USER CT_PRDBLOC IDENTIFIED BY K38tVrZHm5,*y3- account unlock;

ALTER USER R3253368 IDENTIFIED BY pEbjxrRaLrYm3E4 account unlock;
ALTER USER SAP_PRD_EPM IDENTIFIED BY bgAKu3cxMY3Xbpr account unlock;
ALTER USER SAP_BBP_EPM IDENTIFIED BY oXSXCknEadyrc15 account unlock;




ALTER USER KORAMON IDENTIFIED BY values 'S:8213751ADADB565CEF500CCF6A843097106D7573394C9BD1B15384963FCE;T:184F75F66A4FEBD700B96C4D0146E516747465B28E7603A96B82E76E901E4E43B60CBC7A4E6900651B6681A2AB794B5A3BF1C07992B525A2814009FF90BB74A631218DB40CE1E37B9D037FAB05DE885B' account unlock;



-- visualizar usuario e profile
set lines 200
col USERNAME for a15
col EXPIRY_DATE for a25
col ACCOUNT_STATUS for a20
col PROFILE for a30
select username,EXPIRY_DATE, account_status, LOCK_DATE, profile from dbA_users where USERNAME ='R3253368';

-- visualiza usuario expirado em um ano especifico
col name for a10
col password for a16
select name,PASSWORD, EXPTIME from user$ where EXPTIME LIKE '%&ano';

SELECT TABLE_NAME
FROM ALL_TABLES
WHERE OWNER = 'SAPSR3'
and TABLE_NAME LIKE 'QCM%';

DROP TABLE "SAPSR3"."QCMNWAT_GIN_ERS";
DROP TABLE "SAPSR3"."QCM/RDSXESCN/TB";
DROP TABLE "SAPSR3"."QCM/RDSXESCN/TA";
---conceder permissao de usuario sys para o usuario renan
grant sys to renan;

-- visualizar usuario de um perfil espepcifico
select username,EXPIRY_DATE, account_status,LOCK_DATE, PROFILE 
from dbA_users 
where PROFILE ='SAPUPROF';

--alterar perfil
ALTER PROFILE  IBM_PROFILE_MONITORA 
limit PASSWORD_REUSE_TIME 90 
PASSWORD_REUSE_MAX UNLIMITED;

ALTER PROFILE IBM_PROFILE_MONITORA LIMIT password_life_time UNLIMITED;


set lines 200
col GRANTEE for a10
col OWNER for a25
col TABLE_NAME for a20
col GRANTOR for a20
col PRIVILEGE for a20
SELECT *
FROM dba_tab_privs dtp
WHERE dtp.privilege = 'SELECT'
AND dtp.GRANTEE   = 'ALUNO';

GRANT SELECT ON SYSTEM.CURSOS TO ALUNO;



Efetue logon como usuário oracle em uma das máquinas que hospedam o ASM. Lembrando que caso existam mais  máquinas em RAC, todos os hosts que pertencerem ao ASM terão suas senhas alteradas.
Defina a variável de ambiente ORACLE_HOME para o caminho do oraclegrid. Exemplo:
$ export ORACLE_HOME=/opt/oraclegrid
Inclua no PATH o caminho para o diretório bin que fica dentro da instalação do oraclegrid. Exemlpo:
$ export PATH=$PATH:/opt/oraclegrid/bin
Acesse o asmcmd:
$ asmcmd
Liste os usuários cadastrados utilizando os comandos lsusr ou lspwusr. Uma saida provável para o comando lspwusr é apresentada a seguir:

ASMCMD> lspwusr

Username        sysdba sysoper sysasm
SYS                 TRUE    TRUE   TRUE
ASMSNMP   TRUE   FALSE  FALSE

Supondo que se deseje alterar a senha do usuário asmsnmp, essa ação pode ser completada com o seguinte comando:
ASMCMD>passwd IBMTMOR

tivoli4U#Monitor4#

Será questionado a senha atual, que é opcional, e depois a nova senha. Feito isso, o usuário asmsnmp já possui uma nova senha.

tivoli4U#Monitor


  

    