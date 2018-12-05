--12  Index Operational/Page Usage Stats By User
 SELECT  '[' + DB_NAME(ddios.[database_id]) + '].[' + su.[name] + '].['
        + o.[name] + ']' AS [TableName] ,
        i.[name] AS 'index_name' ,
        ddios.[partition_number] ,
        ddios.[row_lock_count] ,
        ddios.[row_lock_wait_count] ,    
		CAST(CASE WHEN row_lock_wait_count = 0 THEN 0
		      ELSE 100.0000 * ddios.[row_lock_wait_count] / ddios.[row_lock_count]
		      END
			 AS DECIMAL(5, 2)) AS  [%_blocked] ,
        ddios.[row_lock_wait_in_ms] ,
        CAST(CASE WHEN row_lock_wait_count = 0 THEN 0
		     ELSE 1.0000 * ddios.[row_lock_wait_in_ms] / ddios.[row_lock_wait_count]
			 END
			 AS DECIMAL(15, 2))  AS [avg_row_lock_wait_in_ms],
  
		-- show page locks as well
		ddios.page_lock_wait_count,
        ddios.page_lock_wait_in_ms--, 

FROM    sys.dm_db_index_operational_stats(DB_ID(), NULL, NULL, NULL) ddios
        INNER JOIN sys.indexes i ON ddios.[object_id] = i.[object_id]
                                     AND i.[index_id] = ddios.[index_id]
        INNER JOIN sys.objects o ON ddios.[object_id] = o.[object_id]
        INNER JOIN sys.sysusers su ON o.[schema_id] = su.[UID]
WHERE   (ddios.row_lock_wait_count > 0 or ddios.page_lock_wait_count > 0)
        AND OBJECTPROPERTY(ddios.[object_id], 'IsUserTable') = 1
        AND i.[index_id] > 0
ORDER BY ddios.[row_lock_wait_count] DESC ,
        su.[name] ,
        o.[name], 
        i.[name];

