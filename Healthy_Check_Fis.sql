
------------------------------------------------------------------------------
-- Microsoft SQL Server Health Check 
-- Author: Graciano Frigo (gfrigo@br.ibm.com) - IBM SQL DBA
-- Purpose: Retrieve a quick health check of the basic aspects of a SQL Server Instance. Works SQL 2005 above.
------------------------------------------------------------------------------
SET NOCOUNT ON
------------------------------------------------------------------------------
-- Support variables to query Instance basic data.
------------------------------------------------------------------------------
DECLARE @server_data VARCHAR(50)
,@data_uptime VARCHAR(50),@computer_name VARCHAR(50)
,@clustercheck VARCHAR(1),@clustermsg VARCHAR(200),@lscount INT
,@prodver VARCHAR(10),@spack varchar(3),@blocks NVARCHAR(3),@dbon VARCHAR(50)
,@dat VARCHAR(19),@edi VARCHAR(30),@buildesc VARCHAR(7),@dboff VARCHAR(50)
,@nodes VARCHAR(1),@clustercheck2 VARCHAR(10),@server_data2 VARCHAR(50)
,@instname VARCHAR(20),@activejobcnt INT,@lastoutcomecnt INT,@jobcheck VARCHAR(150)
,@jobname VARCHAR(200),@svrmem NVARCHAR(20),@sqlmem NVARCHAR(20),@errlog NVARCHAR(500)
SET @data_uptime = (SELECT create_date FROM sys.databases WHERE name = 'tempdb')
SET @server_data = (SELECT CONVERT(NVARCHAR,SERVERPROPERTY('InstanceName')))
SET @computer_name = (SELECT  CONVERT(NVARCHAR,SERVERPROPERTY('ComputerNamePhysicalNetBIOS')))
SET @clustercheck = (SELECT CONVERT (NVARCHAR,SERVERPROPERTY('IsClustered')))
SET @prodver = (SELECT CONVERT(NVARCHAR, SERVERPROPERTY('productversion')))
SET @spack = (SELECT CONVERT (NVARCHAR,SERVERPROPERTY ('productlevel')))
SET @dat = (SELECT CONVERT (datetime,GETDATE()))
SET @edi = (SELECT CONVERT (NVARCHAR,SERVERPROPERTY ('Edition')))
SET @errlog = (SELECT CONVERT(NVARCHAR(200),SERVERPROPERTY('ErrorLogFileName')))
------------------------------------------------------------------------------
-- Get Instance name for Default or Named Instance.
------------------------------------------------------------------------------
IF @server_data IS NULL
        BEGIN
        EXEC xp_regread @rootkey = 'HKEY_LOCAL_MACHINE',@key='SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability'
        ,@value_name = 'LastComputerName'
        ,@value = @instname OUTPUT
        END
        ELSE SET @instname = @server_data
------------------------------------------------------------------------------
-- Validating Clustered x Standalone Instance.
------------------------------------------------------------------------------
IF @clustercheck = 1
    BEGIN
    SET @clustercheck2 = 'Clustered'
        END
            ELSE 
                SET @clustercheck2 = 'Standalone'
------------------------------------------------------------------------------
-- Get Memory Data
------------------------------------------------------------------------------
CREATE TABLE #osmemory
( Idx INT
  ,name VARCHAR(15)
  ,value INT
  ,charvalue NVARCHAR(50)
  )
INSERT INTO #osmemory
EXEC xp_msver @name ='PhysicalMemory'
SET @svrmem = (SELECT value FROM #osmemory)
DROP TABLE #osmemory
-- Max memory
SET @sqlmem = (SELECT cntr_value/1024 FROM sys.dm_os_performance_counters
WHERE   counter_name = 'Target Server Memory (KB)')
------------------------------------------------------------------------------
-- Get Blocking Information
------------------------------------------------------------------------------
SET @blocks = (SELECT COUNT(spid) FROM sys.sysprocesses WHERE blocked > 0)
------------------------------------------------------------------------------
-- Calculating Build Level
------------------------------------------------------------------------------
IF @prodver LIKE '%10.0%'
    BEGIN
    SET @buildesc = '2008';
    END;
    ELSE IF @prodver LIKE '10.50.%'
    BEGIN
    SET @buildesc = '2008 R2'
    END;
    ELSE IF @prodver LIKE '11.%'
    BEGIN
    SET @buildesc = '2012'
    END;
    ELSE IF @prodver LIKE '9.%'
    BEGIN
    SET @buildesc = '2005'
    END;
    PRINT '-----------------------------------------------------------------------------'
    PRINT 'Start of SQL Server Status Check: DATABASE ENGINE' + ' ' + @dat
    PRINT ''
                PRINT 'Instance name: ' + @instname
                PRINT 'Last restart: ' + @data_uptime + ' (Server Timezone) '
                PRINT 'Instance Type: ' + @clustercheck2
                PRINT 'Build: ' + @prodver + '('+ @buildesc +')'
                PRINT 'Service Pack level:'+' '+@spack
                PRINT 'Edition:' + ' ' +@edi
                PRINT 'Errorlog Location: ' + @errlog
                PRINT 'Windows Server / Cluster Active Node Name:'+' '+ @computer_name
                PRINT 'Windows Physical Memory(MB): ' + @svrmem
                PRINT 'Instance Max Memory(MB): ' + @sqlmem
                PRINT 'Current amount of Blocked Processes: ' + @blocks
------------------------------------------------------------------------------
-- Logspace Check
------------------------------------------------------------------------------
                IF EXISTS (SELECT name FROM sys.objects WHERE name = 'logspace')
                DROP TABLE Logspace;
                CREATE TABLE logspace (dbname NVARCHAR(50),logsize nvarchar(50),logspace decimal,logstatus NVARCHAR(5))
                INSERT INTO logspace 
                EXEC ('DBCC sqlperf(logspace);')
                SET @lscount = (select COUNT(*) FROM logspace where logspace > 90 AND dbname NOT IN ('master','model','msdb'))
                IF @lscount > 0 
                PRINT 'Logspace Check: Warning - One or more User databases with over 90% of Logspace usage. Take action'
                    ELSE
                        PRINT 'Logspace Check: No user databases with over 90% of Logspace usage.'
------------------------------------------------------------------------------
-- User Databases Check
------------------------------------------------------------------------------
DECLARE @dbstate varchar(5)
SET @dbstate = (SELECT SUM(state) FROM sys.databases)
IF @dbstate = 0
        BEGIN
                PRINT 'Databases Status (System and User): All ONLINE'
                PRINT 'List of Online User DBs'
                DECLARE dbon CURSOR FOR
                SELECT name FROM sys.databases WHERE state_desc IN ('ONLINE')
                OPEN dbon
                FETCH dbon INTO @dbon
                WHILE @@FETCH_STATUS = 0
                BEGIN
                PRINT @dbon
                FETCH dbon INTO @dbon
                END
        CLOSE dbon
        DEALLOCATE dbon
        END
------------------------------------------------------------------------------
--- Printing User databases NOT ONLINE
------------------------------------------------------------------------------
                ELSE 
                BEGIN
                    PRINT 'Databases Status (System and User): Warning: One or more not ONLINE.'
                    PRINT 'List of DBs NOT ONLINE'
                DECLARE dboff CURSOR FOR
            SELECT name FROM sys.databases WHERE state_desc NOT IN ('ONLINE')
            OPEN dboff
            FETCH dboff INTO @dboff
            WHILE @@FETCH_STATUS = 0
            BEGIN
                PRINT @dboff
                FETCH dboff INTO @dboff
            END
CLOSE dboff
DEALLOCATE dboff
END
DECLARE @userdbcount varchar(3)
SET @userdbcount = (SELECT COUNT(database_id) FROM sys.databases WHERE database_id > 4)
PRINT 'Total User DB Count:'+' '+ @userdbcount
PRINT '                                                                                                                              '
PRINT 'End of SQL Server Status Check: DATABASE ENGINE' + ' ' + @dat
PRINT '-----------------------------------------------------------------------------'
PRINT ''
PRINT '-----------------------------------------------------------------------------'
PRINT 'Start of SQL Server Status Check: SQL AGENT' + ' ' + @dat
------------------------------------------------------------------------------
-- SQL Server Agent Status and Job last run report (Enabled Jobs only)
------------------------------------------------------------------------------
CREATE TABLE #agentstatus ( status varchar(15))
DECLARE @agentstatus varchar(15)
INSERT INTO #agentstatus (status)
EXEC xp_servicecontrol 'querystate','sqlserveragent'
SET @agentstatus = (SELECT status as 'SQL Agent Status' FROM #agentstatus)
PRINT 'SQL Agent status:' + ' ' + @agentstatus
DROP TABLE #agentstatus
SET @activejobcnt = (SELECT COUNT(name) FROM msdb.dbo.sysjobs WHERE enabled = 1)
SET @lastoutcomecnt = (SELECT SUM(last_run_outcome) FROM msdb.dbo.sysjobservers a
JOIN msdb.dbo.sysjobs b
ON a.job_id = b.job_id
WHERE b.enabled = 1)
IF @lastoutcomecnt = @activejobcnt
BEGIN
    SET @jobcheck = 'SQL Server Agent Jobs Analysis: All enabled Jobs succeeded on last run. No action required.'
    END
        ELSE
            SET @jobcheck = 'SQL Server Agent Jobs Analysis: ACTION REQUIRED - One or more Jobs not did not complete on last run.' 
            PRINT @jobcheck
            PRINT 'List of Enabled Jobs Failed on Last Run'
            DECLARE cur1 CURSOR FOR
                SELECT a.name FROM msdb.dbo.sysjobs a 
                JOIN msdb.dbo.sysjobservers b
                ON a.job_id = b.job_id
                WHERE a.enabled = 1 AND b.last_run_outcome = 0
            OPEN cur1
            FETCH cur1 INTO @jobname
            WHILE @@FETCH_STATUS = 0
            BEGIN
                PRINT @jobname
                FETCH cur1 INTO @jobname
            END
CLOSE cur1
DEALLOCATE cur1
PRINT ' '
PRINT 'End of SQL Server Status Check: SQL AGENT' + ' ' + @dat
PRINT '-----------------------------------------------------------------------------' 