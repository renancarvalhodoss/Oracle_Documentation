-- **ACHAR O OWNER DA PROCEDURE

select OWNER, OBJECT_TYPE, OBJECT_NAME from dba_objects where OBJECT_NAME = 'SP_DSP_BUSCA_DADOS_ARQ_P1';



-- **VER A PROCEDURE


Set lines 210
Set pages 0
Set long 99999999
Col ddl format a210
Select dbms_metadata.get_ddl('PROCEDURE','SP_DSP_BUSCA_DADOS_ARQ_P1','DBCSI_DSP') ddl from dual;
                                         *nome da procedure****       *owner***   


spool nomequevcquiser.log



spool off