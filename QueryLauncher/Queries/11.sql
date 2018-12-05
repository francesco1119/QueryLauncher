-- 11 Missing Index stats
 SELECT  cast(dbmigs.avg_total_user_cost * dbmigs.avg_user_impact * ( dbmigs.user_seeks + dbmigs.user_scans )as bigint) AS [Total_Impact] ,
        dbmigs.avg_user_impact,
        dbmid.[statement] AS [Database.Schema.Table] ,
        CAST(dbmigs.avg_total_user_cost as DECIMAL(10,2)) as 'avg_total_user_cost',
  dbmigs.user_seeks,
  dbmigs.user_scans,
        dbmigs.last_user_seek,
        dbmigs.unique_compiles ,
        dbmid.equality_columns ,
        dbmid.inequality_columns ,
        dbmid.included_columns
        
FROM    sys.dm_db_missing_index_group_stats AS dbmigs WITH ( NOLOCK )
        INNER JOIN sys.dm_db_missing_index_groups AS dbmig WITH ( NOLOCK )
                    ON dbmigs.group_handle = dbmig.index_group_handle
        INNER JOIN sys.dm_db_missing_index_details AS dbmid WITH ( NOLOCK )
                    ON dbmig.index_handle = dbmid.index_handle
WHERE   dbmid.[database_id] = DB_ID()
ORDER BY [Total_Impact] DESC ;  

