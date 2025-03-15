select force_logging from v$database;
-- Se o resultado for NO, o Force Logging está desativado.
-- Execute o comando abaixo para ativar o Force Logging:
ALTER DATABASE FORCE LOGGING;

select instance_name from v$instance;

!date