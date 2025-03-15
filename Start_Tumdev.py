# DBA
# ==== 
# Servidor  Linux TUMDEV01 => 10.202.228.133
# ======================

# Com usuario abaixo e executar os scripts/comando para subir os bancos e adminserver :

 

User: I99SVC-TUMDEV01 - 10.202.164.133 
Senha: N,fB8iu.oQ,204P

1-) proadsv -start => Subir o adminserver 

2-) /kyndba/scripts/start_all_databases.sh => Subir os bancos

3-) Verificar se os bancos estao ativos

proutil -C dbipcs|grep Yes => Todos os banco devem aparecer ativos

ps -ef|grep progress => Todos processo deve aparecer ativos do Progress

/kyndba/scripts/query_all_databases.sh 