-- Oracle database: Criando DBlink (Oracle to Oracle)

-- - Ambiente
-- S.O: Oracle Linux 8
-- SGBD: Oracle 19c 
-- Banco: 
-- 	ORIGEM: Single Instance sem Multitenant (NonCDB)
-- 	DESTINO: Single Instance com Multitenant (CDB, PDB)
-- Versões que se aplica: 11g e superior


--> O que é um db_link?

	Um database link é um objeto criado em um esquema de um banco de dados que possibilita o acesso a objetos de outro banco de dados, seja ele Oracle ou não. Esse tipo de sistema é conhecido como Sistema de Banco de Bados Distribuídos e pode ser Homogêneo – quando acessa outros bancos de dados Oracle - e Heterogêneo – quando acessam outros tipos de bancos de dados.
	

--> Definições

	ORIGEM - banco de dados onde o dblink sera criado
	DESTINO - banco de dados que sera acessado pelo dblink criado na ORIGEM
	
	
--> Tipos de dblinks 

	- Publico: Todos os usuários do banco de dados terão acesso ao dblink.
	- Privado: Só podem ser acessados pelo usuário que criou o dblink.
	
	Criterios de segurança: 
		- Usar sempre o dblink privado
		- Criar usuário especifico para o dblink no DESTINO.
		- Atribuir somente os privilegios necessários para o usuario criado no DESTINO.


--> Criando usuario que sera usado pelo dblink (DESTINO)

	CREATE USER user_destino identified by senhas123;
	GRANT connect, create session to user_destino;
	GRANT select on aplicacao.empregados to user_destino;
	
	connect user_destino/senhas123@PDB01;
	SELECT * FROM aplicacao.empregados;


--> Ver dblinks existentes (ORIGEM)

SET linesize 300 
SET pagesize 1000 
col owner FOR a20 
col db_link FOR a20 
col username FOR a20 
col host FOR a20 
SELECT owner, 
       db_link, 
       username, 
       host, 
       To_char(created, 'MM/DD/YYYY HH24:MI:SS') Criacao 
FROM   dba_db_links 
--WHERE db_link = 'DBLINK_NAME'
--WHERE username = 'USERNAME'
ORDER  BY owner, db_link; 


--> Ajustando tnsnames, adicionando descritor (ORIGEM)

Obs: o descritor que sera adiconado tem que apontar para o host e banco de dados do DESTINO

cd $ORACLE_HOME/network/admin
vi tnsnames.ora

Obs: se esse arquivo não existir ele sera criado 

BD_DESTINO =
 (DESCRIPTION =
	(ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.1.51)(PORT = 1522))
	(CONNECT_DATA =
	  (SERVER = DEDICATED)
	  (SERVICE_NAME = pdb01)
	)
 )
	 
tnsping BD_DESTINO
sqlplus user_destino/senhas123@BD_DESTINO


--> Validando parametro GLOBAL_NAMES (ORIGEM)

Obs: O valor da variável GLOBAL_NAMES na instância onde o database link será criado, se configurada no arquivo de inicialização ou na sessão corrente (ALTER SESSION SET) do banco de dados como TRUE o nome global do banco de dados remoto deve ser utilizado (composto pelo nome_do_banco.domínio, ou seja, os parâmetros db_name.db_domain do arquivo de inicialização: initSID.ora).

Para contornar desabilitar a nivel de sessão antes da criação do dblink: 

	select GLOBAL_NAME from GLOBAL_NAME;
	show parameter global_names;
	ALTER SESSION SET GLOBAL_NAMES=FALSE;


--> Criando dblinks (ORIGEM)
	
	-- Privilegio de sistema necessário: CREATE DATABASE LINK 
	GRANT CREATE DATABASE LINK TO hr;
	
	-- - Publico (precisa apenas ter o privilegio)
	
		CREATE PUBLIC DATABASE LINK dblink_pub01 CONNECT TO user_destino IDENTIFIED BY senhas123 USING 'BD_DESTINO';
		
		-- ou 
		
		CREATE PUBLIC DATABASE LINK dblink_pub02 CONNECT TO user_destino IDENTIFIED BY senhas123 USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=192.168.1.51)(PORT=1522))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=pdb01)';
	
	-- - Privado (logar com o usuário dono do dblink)
	
		connect hr/hr;
	
		CREATE DATABASE LINK dblink_priv01 CONNECT TO user_destino IDENTIFIED BY senhas123 USING 'BD_DESTINO';
		
		-- ou 
		
		CREATE DATABASE LINK dblink_priv02 CONNECT TO user_destino IDENTIFIED BY senhas123 USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=192.168.1.51)(PORT=1522))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=pdb01)';


--> Testando os dblinks (ORIGEM)

	SELECT * FROM dual@dblink_priv01;
	SELECT * FROM aplicacao.empregados@dblink_priv01;
	SELECT * FROM aplicacao.dependentes@dblink_priv01;
	SELECT * FROM aplicacao.endereco@dblink_priv01;

--> Dropando dblinks (ORIGEM)

	DROP DATABASE LINK dblink;
	DROP PUBLIC DATABASE LINK dblink;