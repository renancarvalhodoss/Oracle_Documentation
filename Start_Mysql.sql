ps -ef|grep mysql
su - mysql
realizar no root
systemctl stop mysql
systemctl status mysql
systemctl start mysql

D:\app\MySQL\MySQL80\bin\mysql -uroot -p

/var/db/mysql/bin/mysql -uroot -p

-- PRA CONECTAR NO MYSQL

mysql -uroot -p
-- *VIA PEDIR A SENHA, COLOCA A SENHA QUE ESTA NA BASELINA, EXEMPLO CLIENTE SSAINT GOBAIN

		HOSTNAME	IP	DB USER	DB PASS	OBS
Saint-Gobain	MYSQL	I99SV407AG1D	10.202.167.131	root	ibm@01sg	
Logar102030@DEV
Logar102030@DEV
Ibm@01sg.2023
Linux	MYSQL	I99SV407AG1D	10.202.167.131	root	Kynd2406@sg-		
Linux	MYSQL	I99SV407AG1P	10.202.167.21	root	ibm@01sg	Kynd2407@sg-Prd	
Linux	MYSQL	I99SV427AP1D	10.202.227.130	root	Logar102030@DEV		BOMDEFARO DEV & HML
Linux	MYSQL	I99SV427DB2P	10.202.227.3	root	Logar102030@PRD		BOMDEFARO PRD
Windows	MYSQL	CBRSV99APP43003	10.202.171.115	root	sgar2017prod		
Windows	MYSQL	CBRSV99APD43003	10.202.170.130	root	sgar2017dev		
Linux	MYSQL	I99SV403WW0P	10.202.231.19	root	Logar202208@PRD		
Windows	MYSQL	CBRSV99APP42218	10.202.164.19	root	Kynd2305-Prd@		


-- no banco rodar a query

SELECT table_schema AS "Database",
ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS "Size (MB)"
FROM information_schema.TABLES
GROUP BY table_schema;



-- Verificar informações de expiração
SELECT user, host, password_last_changed, password_expired, account_locked
FROM mysql.user
WHERE user = 'iweb-soporte';

-- Verificar permissões do usuário
SHOW GRANTS FOR 'usuario_exemplo'@'localhost';


-- alterando senha do usuario
ALTER USER 'nome_do_usuario'@'host' IDENTIFIED BY 'nova_senha';
ALTER USER 'iweb-soporte'@'localhost' IDENTIFIED BY '@YxF39n3tNi94fF';

mysql>
