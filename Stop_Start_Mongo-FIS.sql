Stop Start Mongo DB 

 

Procedimento válido para todos os servidores MongoDB do baseline FIS: 

10.111.134.92  LNXMGDSP100 
10.111.134.93  LNXMGDSP101 
10.111.150.71  LNXMGDSPD01 
10.111.150.72  LNXMGDSPH01 

 

Validação pré e pós, patch de SO MongoDB: 

 

hostname 

Como root: 

mongo -u <seuLCnumber> passwordPrompt --authenticationDatabase admin 

<digitar sua senha> 

>use admin 

>show dbs 

exit 

ps -ef | grep mongo 

 

df -kh 

 

ps -ef 

 

uptime 

 

Obs: Comparar os resultados dos comando acima, com os resultados antes de iniciar a manutenção e após a finalização da manutenção. Garantir que todos os serviços que estavam up antes de iniciar a mudança etejam up após finalizar a mudança. 
Anexar as evidências à task da change no SNOW ao fechá-la. 

Comandos para parar o Mongo DB: 
 

Executar como root: 

mongo -u LC5697094 passwordPrompt --authenticationDatabase admin 

<digitar sua senha> 

 

use admin 

db.shutdownServer() 

 
 

Outra opção para baixar o Mongo pelo Sistema operacional: 

mongod -f /etc/mongod.conf --shutdown 

 

 

 

Comando para Subir o Mongo DB: 

Executar como root no SO 

 
mongod -f /etc/mongod.conf 

 

Exemplo de execução com sucesso: 

-sh-4.2# mongod -f /etc/mongod.conf 

about to fork child process, waiting until server is ready for connections. 

forked process: 47583 

child process started successfully, parent exiting 

 

 

Executar validações novamente conforme início desse documento. 