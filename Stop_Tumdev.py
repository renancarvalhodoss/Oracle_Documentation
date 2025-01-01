DBA

==== 

Servidor  Linux TUMDEV01 => 10.202.228.133

======================

Com usuario abaixo da aplicacao executar os scripts/comando para parar os bancos e adminserver :

User: I99SVC-TUMDEV01 - 10.202.164.133 

Senha: N,fB8iu.oQ,204P

1-) Parar os bancos e adminserver

    ================================

/kyndba/scripts/stop_all_databases.sh 

proadsv -stop => parar o adminserver

2-) Verificar se os bancos estao fora. 

proutil -C dbipcs|grep Yes => Nenhum banco deve aparecer 

3-) ps -ef|grep progress => Nenhum processo do Progress deve aparecer

4-) Truncar BI dos bancos:

proutil /u/usr/desenv/Lidercpd -C truncate bi -G 0

proutil /u/usr/deposito/Tume0108 -C truncate bi -G 0

proutil /u/usr/tume9989/Tume9989 -C truncate bi -G 0

proutil /u/usr/tume9999/Tume9999 -C truncate bi -G 0

proutil /u2/tumesap/Tumesap -C truncate bi -G 0

proutil /usr/oemgmt/db/fathom -C truncate bi -G 0



5-)  Delete e restore dos bancos Fathom.db em cada servidor.  ( realizado 1x por mês) 

cd /usr/oemgmt/db 

prodel fathom 

prorest fathom fathom.bak 



6-) Limpeza dos logs do App Server  (realizado 1x por mês) 

Fazer a cópia do log atual para o arquivo .old 

Limpar o log atual 

cd /u/usr/wtume9999 

cp asTume9999.broker.log asTume9999.broker.log.old 

> asTume9999.broker.log 



cp asTume9999.server.log asTume9999.serve.log.old 

> asTume9999.server.log 