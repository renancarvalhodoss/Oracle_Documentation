
-- colocar banco em archive log mode
shut immediate;
startup mount;
alter database archivelog;
alter database open;

======================= BACKUP ARCHIVE ================================

-- para gerar um novo archive
SQL>alter system switch logfile;

-- rodar variaveis de ambiente
rman target / 

-- armazenamento na fra

RMAN> sql 'ALTER SYSTEM ARCHIVE LOG CURRENT';
--bkp de todos archives
RMAN> BACKUP ARCHIVELOG All;
--bkp de archives que nao fizeram backups
RMAN> BACKUP ARCHIVELOG All NOT BACKED UP;
-- backup de e deleta os archives
RMAN> BACKUP ARCHIVELOG All DELETE ALL INPUT;

-- ou

-- backup em local especifico
RMAN> run {
      ALLOCATE CHANNEL C1 DEVICE TYPE DISK;
      BACKUP ARCHIVELOG ALL NOT BACKED UP FORMAT
      '/backup/cdb1/archive/ARC_%T_%d_%s_%p';
}


-- backup de archive com compressao no tamanho apagando 1 dia pra tras
run {  
	sql 'ALTER SYSTEM ARCHIVE LOG CURRENT';
	allocate channel c1 device type disk;
	backup as compressed backupset archivelog all not backed up format '/backup/orcl/archive/ARC_%T_%d_%s_%p';
	delete noprompt archivelog until time 'sysdate-1' backed up 1 times to device type disk;
	}
	


======================= BACKUP FULL ON ================================

-- rodar variaveis de ambiente
rman target / 

-- realiza bkp somente da base de dados
backup database 
-- realiza bkp da base de dados e de todos archives que nao foram bakpeados
backup database Plus archivelog

RMAN> run {
      ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
      BACKUP DATABASE FORMAT '/backup/cdb1/fisico/FULL__%T_%d_%s_%p';
}  

RMAN> run {
      ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
      BACKUP DATABASE PLUS ARCHIVELOG FORMAT 
      '/backup/cdb1/fisico/FULL__%T_%d_%s_%p';
}  

-- backup incremental N0
run {  
	allocate channel c1 device type disk;
	backup incremental level = 0 as compressed backupset format '/backup/orcl/fisico/INC0_%T_%d_%s_%p' (database  include current controlfile) ; 
	}
	
-- backup incremental N1 
run {  
	allocate channel c1 device type disk;
	backup incremental level = 1 as compressed backupset  format '/backup/orcl/fisico/INC1_%T_%d_%s_%p' (database  include current controlfile) ; 
	}

-- backup full com compressao no tamanho
run {  
	allocate channel c1 device type disk;
	backup as compressed backupset 	format '/backup/orcl/fisico/FULL_%T_%d_%s_%p' (database  include current controlfile) ; 
	}