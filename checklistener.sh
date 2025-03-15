#!/usr/bin/env ksh



# Verificar se o sistema operacional é AIX ou Linux
OS=$(uname)
echo "Sistema operacional detectado: $OS"


# Obter a lista de listener
ORACLE_LISTENER=$(ps -ef | grep inh | grep -v grep | sed -n 's/.*tnslsnr \([^ ]*\).*/\1/p' | sort -u)

echo "listeners em execucao: $ORACLE_LISTENER"


# Iterar sobre cada LISTENER
for ORACLE_LISTENER in $ORACLE_LISTENER; do
    echo "Processando LISTENER: $ORACLE_LISTENER"

        # Encontrar o usuário owner do banco de dados
    OWNER_LISTENER=$(ps -ef | grep $ORACLE_LISTENER | grep -v grep | awk '{print $1}' | sort -u)
    echo $OWNER_LISTENER
    
    if [ -z "$OWNER_LISTENER" ] || [ "$OWNER_LISTENER" = "root" ]; then
        echo "Não foi possível determinar o owner do listener $ORACLE_LISTENER. Pulando..."
        continue
    fi

      echo "Usuário owner do Listener: $OWNER_LISTENER"
      
  # Criar um script temporário para configurar o ambiente e executar o lsnrctl
    TMP_LISTENER_SCRIPT="/tmp/listener_script_${ORACLE_LISTENER}.sh"
    cat <<EOF > "$TMP_LISTENER_SCRIPT"
#!/usr/bin/env ksh
 
export ORACLE_HOME=$(ps -ef | grep "tnslsnr" | grep "listener_pis" | awk '{print $9}' | sed 's/\/bin\/tnslsnr//')
export PATH=\$ORACLE_HOME/bin:\$PATH

echo "ORACLE_HOME: \$ORACLE_HOME"
echo "PATH: \$PATH"

# Executar o comando lsnrctl status
lsnrctl status $ORACLE_LISTENER
EOF
    
    # Dar permissão de execução e executar o script como o usuário do Listener
    chmod 755 "$TMP_LISTENER_SCRIPT"
    su - $OWNER_LISTENER -c "ksh $TMP_LISTENER_SCRIPT"
    rm -f "$TMP_LISTENER_SCRIPT"

done

echo "Processo concluído."


ps -ef | grep "tnslsnr DBPSPROD_DG" | grep -v grep | awk '{print $9}'