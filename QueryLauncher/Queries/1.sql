-- these queries are for getting system-wide perofrmance data from a production database that looks to be 
--  experiencing SQL level perofrmance issues, either overloading, slow queries, or similar.
-- Note that This is not a first step.  Basic system-level and application checks shoudl be done first
-- eg app configs, system-level metrics checks, ensuring SQL index/stats maintenance plans are set up running.
-- all results except for the last query stats can be pasted into Excel worksheets
-- the Query stats can't because it includes the detailed Query Plans, which are too long for SQL. 
-- Instead, paste it into a text document using notepad++ or osmething similar that can handle larger files.

-- It includes 2 queries that report on Vista Task Scheduler.  If Task SCheduler is not installed, these will fail and can be ignored

-- 01 Machine Data
-- This has version specific fields
SELECT 
    SERVERPROPERTY('MachineName') AS [MachineName], 
	SERVERPROPERTY('ServerName') AS [ServerName],  
	SERVERPROPERTY('InstanceName') AS [Instance],  
	SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS [ComputerNamePhysicalNetBIOS], 
	SERVERPROPERTY('ProductVersion') AS [ProductVersion],
	DB_NAME() as [CurrentDB],
	 cpu_count AS [Logical CPU Count], 
	 cpu_count/hyperthread_ratio AS [Physical CPUs], 
	 physical_memory_kb/1024 AS [Physical MB], 
	 committed_kb/1024 AS [Committed MB],
	 committed_target_kb/1024 AS [Committed Target MB],
	 getdate() AS [Sample Time],
	 sqlserver_start_time AS [SQL Server Start Time],
	 CAST(datediff(HOUR,sqlserver_start_time, getdate()) / 24.0 as DECIMAL(9,2)) as UpTime_days,
	 (SELECT TOP 1 creation_time FROM sys.dm_exec_query_stats WITH (NOLOCK) ORDER BY creation_time) as [QueryStats Reset Time],
     (SELECT CONVERT(VARCHAR(20), DATEADD(second, -wait_time_ms/1000, GETDATE()), 120) AS [DMVRestart] FROM sys.dm_os_wait_stats WHERE wait_type = 'SQLTRACE_INCREMENTAL_FLUSH_SLEEP') as [WaitStats Reset Time]

	-- not available in 2012
	--, virtual_machine_type_desc AS [Virtual Machine Type]
FROM sys.dm_os_sys_info; 
