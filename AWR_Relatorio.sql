
-- O Automatic Workload Repository (AWR) do Oracle é uma ferramenta poderosa para monitorar e diagnosticar o desempenho do banco de dados. A execução de um relatório AWR pode ser feita utilizando o SQL*Plus ou outras ferramentas de interface com o banco. Veja os passos principais:


-- 2. Identificar os Snapshots
-- Os relatórios AWR comparam dois snapshots (pontos de coleta de dados). Primeiro, identifique os snapshots disponíveis:

set pagesize 2000
set linesize 2000
col END_INTERVAL_TIME for a30
SELECT SNAP_ID, BEGIN_INTERVAL_TIME, END_INTERVAL_TIME 
FROM DBA_HIST_SNAPSHOT
ORDER BY SNAP_ID;
-- Anote os IDs dos snapshots que você deseja comparar.
132815    133652
133653    133750
87602    87604
133535  133583
-- 3. Executar o Relatório AWR
-- Para gerar o relatório, execute o script localizado no diretório $ORACLE_HOME/rdbms/admin. O script mais usado é o awrrpt.sql. Siga este processo:


@$ORACLE_HOME/rdbms/admin/awrrpt.sql
-- O Oracle solicitará algumas informações:

-- Tipo de relatório: Geralmente, escolha html para gerar um relatório no formato HTML ou text para texto.
-- Instância: Normalmente, deixe em branco para usar o padrão.
-- Snapshots: Insira os IDs dos snapshots de início e fim.
-- Nome do arquivo: Especifique o nome do arquivo ou pressione Enter para usar o nome padrão.
-- 4. Acessar o Relatório
-- Após a execução, o relatório será salvo no local especificado. Se você escolheu o formato HTML, poderá abri-lo em um navegador para melhor visualização.

-- 5. Gerar Relatórios Específicos (Opcional)
-- Além do relatório padrão, o AWR oferece relatórios específicos:

awrsqrpt.sql: Para consultar o desempenho de SQL específicos.
awrrpti.sql: Para instâncias em um ambiente RAC.
awrddrpt.sql: Para comparar o desempenho entre dois períodos de tempo distintos.
Exemplo Completo

sqlplus / as sysdba
@$ORACLE_HOME/rdbms/admin/awrrpt.sql
-- Escolha HTML como tipo de relatório.
-- Digite o ID dos snapshots (ex.: 100 e 110).
-- Salve como "meu_relatorio_awr.html".
Automação com DBMS_WORKLOAD_REPOSITORY (Opcional)
Você também pode usar o pacote DBMS_WORKLOAD_REPOSITORY para programar ou automatizar a geração de relatórios AWR. Por exemplo:


BEGIN
  DBMS_WORKLOAD_REPOSITORY.AWR_REPORT_TEXT(
    l_dbid       => 123456789, -- Substitua pelo DBID do banco
    l_inst_num   => 1,          -- Número da instância
    l_bid        => 100,        -- Snapshot inicial
    l_eid        => 110,        -- Snapshot final
    l_options    => 0           -- Opções padrão
  );
END;
/



chown -R soadm1.staff awr_01-02_12_24.html
mv gerdau_hc_full /home/oracle
cd /home/oracle/gerdau_hc_full
mv gerdau_hc_full /tmp
chown -R root.root /tmp/executor_sql.sh
chmod -R 777 /tmp/executor_sql.sh
