CREATE USER MONITORA IDENTIFIED BY oracle;
GRANT connect to MONITORA;
GRANT CREATE SESSION to MONITORA;
GRANT ALTER SESSION to MONITORA;

GRANT Select any TABLE to MONITORA;

GRANT CREATE any TABLE to MONITORA;
GRANT CREATE any view to MONITORA;
GRANT CREATE any PROCEDURE to MONITORA;
GRANT EXECUTE any PROCEDURE to MONITORA;
GRANT CREATE any trigger to MONITORA;


CREATE role level_one;
GRANT connect to level_one;
GRANT CREATE SESSION to level_one;
GRANT ALTER SESSION to level_one;
GRANT Select any TABLE to level_one;

GRANT level_one to MONITORA;
alter user MONITORA default role level_one;




SELECT owner, table_name, select_priv, insert_priv, delete_priv, update_priv, references_priv, alter_priv, index_priv 
  FROM table_privileges
 WHERE user = MONITORA;