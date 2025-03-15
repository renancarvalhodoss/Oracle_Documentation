
# 1-)Start banco de dados, executar scripts abaixo em cada servidor:



# Servidor TREINAWEB

a-)  /scripts/start_aplic_rhweb7

b-) /scripts/start_aplic_ssotr

c-) /scripts/start_aplic_ctbfolha39

e-) proutil -C dbipcs|grep Yes => Para verificar se todos os bancos estao ativos




# Servidor Qualiweb
a-) /scripts/start_aplic_qualiweb.noc



wtbman -i rhweb57bat -q
wtbman -i rhweb57bat -x
wtbman -i rhweb57bat -x
wtbman -i int57pro1 -e


# ---------start admin server-----------
proadsv -start
proadsv -query
