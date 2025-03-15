
-- SQL Server Services information (SQL Server

SELECT servicename, process_id, startup_type_desc, status_desc,

last_startup_time, service_account, is_clustered, cluster_nodename, [filename]

FROM sys.dm_server_services WITH (NOLOCK) OPTION (RECOMPILE);



-- Status Databases

SELECT @@servername as instance,     

    CASE

        WHEN EXISTS(SELECT name FROM sys.databases

                    WHERE state_desc <> 'Online') THEN 'Database Offline/Recovering/Restoring '

        ELSE 'All Online'

     

    END AS StatusDatabases,

GETDATE() as Date



-- ErroLog



EXEC xp_readerrorlog 0, 1, N'Severity: 22';

EXEC xp_readerrorlog 0, 1, N'Severity: 23';

EXEC xp_readerrorlog 0, 1, N'Severity: 24';







--Demo: Usu·rios e aplicativos conectados

SELECT  getdate() DataHora, DB_NAME(es.database_id) As DatabaseSQL, es.[program_name], es.[host_name],esc.client_net_address, es.login_name,

COUNT(esc.session_id) AS [connection count]

FROM sys.dm_exec_sessions AS es WITH (NOLOCK)

INNER JOIN sys.dm_exec_connections AS esc WITH (NOLOCK)

ON es.session_id = esc.session_id

GROUP BY esc.client_net_address, es.[program_name], es.[host_name], es.login_name ,DB_NAME(es.database_id)

ORDER BY [connection count] DESC OPTION (RECOMPILE);

--ORDER BY ec.client_net_address, es.[program_name] OPTION (RECOMPILE);