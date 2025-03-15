Procurar pelo servidor:  HTLXSTIFPR001 (UAT)
Solicitar 2 usuários no server HTLXSTIFPR001
kyndryl01 até kyndryl10 
ibmfso1 até ibmfso10 
Irá conectar com ibmfso1 e depois realizar:
sudo su - 
su - kyndryl01  
Realizar ssh para os servidores exemplo: 
htlxnddbpr007a
ssh 10.141.62.104 ou ssh htlxnddbpr007a
Ira pedir senha para chave, colocar a senha do user kyndryl
Uma vez conectado podera fazer sudo para:
root
oracle
grid
sudo su - oracle
show pdbs;
alter session set container=SGPDV;
Summary: The percentage free to allocated of IFW_DT_TBS that has 5384.06 MB is 12.37% on RZ:HOM1291-EXACC-pda-htlxnd:RDB, InstanceName: CDBHOM021. Threshold Formula: Used_Size_MB<250000.00 AND Percentage_Free_To_Allocated>7.00 AND Percentage_Free_To_Allocated<14.0
ResourceId: htlxnddbpr010a

show parameter utl_file_dir;