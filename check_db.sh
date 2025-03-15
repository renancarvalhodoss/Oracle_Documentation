#!/usr/bin/ksh

# Arquivo oratab
ORATAB_FILE="/etc/oratab"

# Verifica se o arquivo oratab existe
if [ ! -f "$ORATAB_FILE" ]; then
    echo "Arquivo oratab não encontrado: $ORATAB_FILE"
    exit 1
fi

# Comando SQL que será executado em cada banco de dados
SQL_COMMAND="set lines 200
col instance_name for a15
col host_name for a35
col dt for a20
select instance_name, host_name, to_char(STARTUP_TIME, 'dd/mm/yy hh24:mi:ss') dt, status, logins from gv\\\$instance;"

# Loop através de cada banco de dados no oratab
grep -vE '^(#|\s*$|\+ASM)' "$ORATAB_FILE" | while IFS=: read -r ORACLE_SID ORACLE_HOME AUTO_START; do
    echo "Conectando ao banco de dados: $ORACLE_SID"

    # Verifica se o ORACLE_HOME é válido
    if [ ! -d "$ORACLE_HOME" ]; then
        echo "ORACLE_HOME inválido para o banco de dados $ORACLE_SID: $ORACLE_HOME"
        continue
    fi

    # Identifica o usuário owner do ORACLE_HOME usando ls -ld
    ORACLE_OWNER=$(ls -ld "$ORACLE_HOME" | awk '{print $3}')
    if [ -z "$ORACLE_OWNER" ]; then
        echo "Não foi possível identificar o usuário owner do ORACLE_HOME: $ORACLE_HOME"
        continue
    fi

    echo "Usuário owner do banco de dados $ORACLE_SID: $ORACLE_OWNER"

    # Executa o comando SQL como o usuário owner
    su - "$ORACLE_OWNER" <<EOF
        # Configura as variáveis de ambiente para o shell atual (assumindo bash/ksh)
        export ORACLE_SID=$ORACLE_SID
        export ORACLE_HOME=$ORACLE_HOME
        export PATH=\$ORACLE_HOME/bin:\$PATH
        export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\${LD_LIBRARY_PATH:-}

        echo "Configurações do ambiente:"
        echo "ORACLE_SID: \$ORACLE_SID"
        echo "ORACLE_HOME: \$ORACLE_HOME"
        echo "PATH: \$PATH"
        echo "LD_LIBRARY_PATH: \$LD_LIBRARY_PATH"

        # Executa o sqlplus com as variáveis de ambiente
        sqlplus -s / as sysdba <<SQL_EOF
            $SQL_COMMAND
            exit;
SQL_EOF

        # Verifica o status de saída do sqlplus
        if [ \$? -eq 0 ]; then
            echo "Comando SQL executado com sucesso no banco de dados: $ORACLE_SID"
        else
            echo "Erro ao executar o comando SQL no banco de dados: $ORACLE_SID"
        fi
EOF

    echo ""
done

echo "Script concluído."













#!/bin/sh

# Função para listar todos os bancos de dados Oracle no servidor, exceto ASM
listar_bancos() {
    # Lista os bancos de dados registrados no oratab
    grep -v '^#' /etc/oratab | grep -v '^$' | grep -vi 'asm' | cut -d: -f1
}

# Função para obter o usuário proprietário de um banco de dados
obter_usuario_proprietario() {
  db_name=$(ls -ld "$ORACLE_HOME" | awk '{print $3}')
    if [ -z "$db_name" ]; then
        echo "Não foi possível identificar o usuário owner do ORACLE_HOME: $ORACLE_HOME"
        continue
    fi
}

   


# Função para configurar as variáveis de ambiente do Oracle
configurar_ambiente() {
    local db_name=$1
    export ORACLE_SID=$db_name
    export ORACLE_HOME=$(grep "^$db_name:" /etc/oratab | cut -d: -f2)
    export PATH=$ORACLE_HOME/bin:$PATH
    export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH

    # No AIX, use LIBPATH em vez de LD_LIBRARY_PATH
    if [ "$(uname -s)" = "AIX" ]; then
        export LIBPATH=$ORACLE_HOME/lib:$LIBPATH
    fi

    echo "Variáveis de ambiente configuradas para o banco de dados $db_name."
    echo "ORACLE_HOME: $ORACLE_HOME"
    echo "ORACLE_SID: $ORACLE_SID"
}

# Função para executar a query no banco de dados
executar_query() {
    local db_name=$1
    local query="SELECT * FROM sua_tabela;"  # Substitua pela sua query

    echo "Conectando ao banco de dados $db_name..."
    sqlplus -s /nolog <<EOF
    CONNECT / as sysdba
    $query
    EXIT
EOF
}

# Main
for db in $(listar_bancos); do
    echo "Processando banco de dados: $db"

    # Obtém o usuário proprietário do banco de dados
    usuario=$(obter_usuario_proprietario $db)
    if [ -z "$usuario" ]; then
        echo "Não foi possível determinar o usuário proprietário do banco de dados $db."
        continue
    fi

    # Altera para o usuário proprietário e executa o processo
    su - $usuario <<EOF
    # Configura o ambiente para o banco de dados atual
    $(typeset -f configurar_ambiente)
    configurar_ambiente $db

    # Executa a query no banco de dados
    $(typeset -f executar_query)
    executar_query $db
EOF

    echo "Processamento do banco de dados $db concluído."
done

echo "Script concluído."