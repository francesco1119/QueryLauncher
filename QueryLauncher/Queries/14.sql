-- 14 Vista Top Queries and Plans (NOTE: Save this to a text file VIA "COPY ALL WITH HEADERS", not pasted into excel)
-- the qs.query plan field is large and why results can't be pasted into Excel; remove this is it is a problem or not needed
-- This has SQL version specific fields
-- use: dbcc freeproccache() to clear query stats if needed to get a more focused time period.

-- Issues: This reports every individual query so there may be multiple queries for each plans.
-- an alternative is to rpeort on query plan hash only, and ignore the specific query information.
 
SELECT  TOP 100
 serverproperty('MachineName') as "Machine_Name", 
 -- db_name() as 'DB_Name', -- DBname is irrelevant, since this is server-wide information
 getdate() as "Sample_DateTime",
 qs.execution_count,
 -- totals used to get Avgerage
 qs.total_elapsed_time/1000 total_elapsed_time_ms,  -- main thing we're interested in is elapsed time
 qs.total_logical_reads,  
 qs.total_worker_time/1000 total_worker_time_ms,  -- worker time is CPU - important
 qs.total_physical_reads, 
 qs.total_logical_writes, 
 
 -- max for abnormal cases
 qs.max_elapsed_time/1000 max_elapsed_time_ms,
 qs.max_worker_time/1000  max_worker_time_ms,
 qs.max_logical_reads, -- logical reads: main indication of work needed
 qs.max_physical_reads,
 qs.max_logical_writes, 
 
 -- last sometimes useful for "what's happening now"
 qs.last_elapsed_time/1000  last_elapsed_time_ms,
 qs.last_worker_time/1000  last_worker_time_ms,
 qs.last_logical_reads,
 qs.last_physical_reads, 
 qs.last_logical_writes, 
 -- Rows are 2012+
 qs.total_rows,  qs.max_rows, qs.last_rows, qs.min_rows, 
 -- DOP is 2016+
 -- qs.total_dop, qs.max_dop, -- only SQL 2016
 qs.creation_time, qs.last_execution_time, -- useful to identify when and what triggered the query
 DATEDIFF(Second, qs.creation_time, GETDATE()) as [plan_age_secs],
 -- elapsed time is 1 second out. Stops datediff returning zero for THIS query being run for the first time.
 ISNULL(qs.execution_count*1./ (DATEDIFF(Second, qs.creation_time, GETDATE())+1), 0)*60 AS [Calls/Minute],
 db_name(qp.dbid) as db_name,
 qs.query_hash,
 -- depending on version, this may have embedded cr/lf/tab and need replacing
 REPLACE(
    REPLACE(
      REPLACE(
   SUBSTRING(qt.TEXT, (qs.statement_start_offset/2)+1,
    ((CASE qs.statement_end_offset
    WHEN -1 THEN DATALENGTH(qt.TEXT) 
    ELSE qs.statement_end_offset
    END 
    - qs.statement_start_offset)/2)+1)
      , char(9),' ')
    , char(10), ' ')
  , char(13), ' ')  as sql_text
  ,qs.query_plan_hash
  -- query plan is large, and means results can't be pasted into Excel; remove this is it is a problem or not needed
  , qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
WHERE
   SUBSTRING(qt.TEXT, (qs.statement_start_offset/2)+1,4) <> 'WAIT'
   and qs.total_elapsed_time > 10000 -- only 10msecs filter the junk
  ORDER BY
   total_elapsed_time_ms DESC; -- or whatever other field, depending on your issue

