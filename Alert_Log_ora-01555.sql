---Isso ocorre devido a consultas de longa duração quando o sistema possui um loadsql DML muito grande




Conforme verificado, este é um erro interno da oracle e não há impacto nas operações do dia a dia da oracle. Os tablespaces TEMP e UNDO estão comespaço suficiente para operações de rollback, rollforward.
segue evidencias abaixo
 
SQL> archive log list;
Database log mode              Archive Mode
Automatic archival             Enabled
Archive destination            USE_DB_RECOVERY_FILE_DEST
Oldest online log sequence     165039
Next log sequence to archive   165050
Current log sequence           165050
 
------------------------------------------------------------------------------------ 
 

ANCO                          NAME                                MEGAS          USED          FREE PCT_USED
------------------------------ --------------------------- ------------- ------------- ------------- --------
ggadb042-GE4                   PSAPTIVOLIORTS                     150.00          0.13        149.88      .08
ggadb042-GE4                   PSAPSR3USR                      645120.00     148735.69     496384.31    23.05
ggadb042-GE4                   PSAPHDBR3                        63508.00      17611.44      45896.56    27.73
ggadb042-GE4                   PSAPUNDO                       2552055.00     800436.75    1751618.25    31.36
ggadb042-GE4                   PSAPSR3740                      224000.00     118826.69     105173.31    53.04
ggadb042-GE4                   SYSAUX                          309954.00     169655.69     140298.31    54.73
ggadb042-GE4                   SYSTEM                            3909.00       3120.44        788.56    79.82
ggadb042-GE4                   PSAPSR3                       27304921.99   26156406.49    1148515.50    95.79
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 
 SQL>  select sid,SERIAL#,status,username,INST_ID,machine,sql_id from gv$session where sql_id='g9yfd0ktp22bc';

no rows selected