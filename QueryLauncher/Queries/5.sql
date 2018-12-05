-- 05 all Procedure Stats (assuming it isn't too many)
SELECT 
 serverproperty('MachineName') as "Machine_Name", db_name() as 'DB_Name',
 getdate() as "Sample_DateTime",
 p.name AS [SP Name], 
 qs.execution_count,
 qs.total_elapsed_time / 1000 as [total_elapsed_time_ms], 
 qs.total_worker_time / 1000  as [total_worker_time_ms],  
 qs.total_logical_reads,
 qs.total_physical_reads,
 qs.total_logical_writes,

 qs.total_elapsed_time / 1000 / qs.execution_count AS [avg_elapsed_time_ms],
 qs.total_worker_time / 1000 /  qs.execution_count AS [avg_worker_time_ms],
 qs.total_logical_reads / qs.execution_count       AS [avg_logical_reads],
 
 qs.max_elapsed_time / 1000 as [max_elapsed_time_ms], 
 qs.max_worker_time / 1000  as [max_worker_time_ms],  
 qs.max_logical_reads,
 qs.max_physical_reads,
 qs.max_logical_writes,

 qs.cached_time,
 qs.last_execution_time,
 DATEDIFF(Second, qs.cached_time, GETDATE()) as [cached_age_secs],
 ISNULL(qs.execution_count*1./DATEDIFF(Second, qs.cached_time, GETDATE()), 0)*60 AS [Calls/Minute]
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK)
ON p.[object_id] = qs.[object_id]
WHERE qs.execution_count > 0
-- ORDER BY qs.execution_count desc;
ORDER BY qs.total_elapsed_time desc; 

