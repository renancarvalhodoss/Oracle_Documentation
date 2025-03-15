#!/usr/bin/env ksh

# Definir a query a ser executada
QUERY="SELECT name, open_mode FROM v\\\$database;"

# Verificar se o sistema operacional é AIX ou Linux
OS=$(uname)
echo "Sistema operacional detectado: $OS"

# Obter a lista de bancos de dados Oracle (excluindo ASM)
ORACLE_SIDS=$(ps -ef | grep pmon | grep -v grep | grep -v ASM | awk -F_ '{print $NF}' | sort -u)

if [ -z "$ORACLE_SIDS" ]; then
    echo "Nenhuma instância Oracle encontrada."
    exit 1
fi

echo "Instâncias encontradas: $ORACLE_SIDS"

# Iterar sobre cada banco de dados
for ORACLE_SID in $ORACLE_SIDS; do
    echo "Processando instância: $ORACLE_SID"
    
    # Encontrar o usuário owner do banco de dados
    OWNER=$(ps -ef | grep "pmon_${ORACLE_SID}" | grep -v grep | awk '{print $1}' | sort -u)
    
    if [ -z "$OWNER" ] || [ "$OWNER" = "root" ]; then
        echo "Não foi possível determinar o owner da instância $ORACLE_SID. Pulando..."
        continue
    fi
    
    echo "Usuário owner do banco: $OWNER"
    
    # Criar um script temporário para executar os comandos corretamente no ksh
    TMP_SCRIPT="/tmp/oracle_script_${ORACLE_SID}.sh"
    cat <<EOF > "$TMP_SCRIPT"
#!/usr/bin/env ksh
export ORACLE_SID=$ORACLE_SID
ORACLE_HOME=\$(grep "^$ORACLE_SID:" /etc/oratab | cut -d: -f2)
export ORACLE_HOME
export PATH=\$ORACLE_HOME/bin:\$PATH

if [ -z "\$ORACLE_HOME" ]; then
    echo "Não foi possível determinar ORACLE_HOME para $ORACLE_SID. Pulando..."
    exit 1
fi

echo "Conectando ao banco de dados $ORACLE_SID e executando query..."
sqlplus -S / as sysdba <<EOF_SQL
$QUERY
exit;
EOF_SQL
EOF
    
    # Dar permissão de execução e executar o script como o usuário do banco
    chmod +x "$TMP_SCRIPT"
    su - $OWNER -c "ksh $TMP_SCRIPT"
    rm -f "$TMP_SCRIPT"

done

echo "Processo concluído."
