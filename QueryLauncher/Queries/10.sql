-- 10 Index Usage Stats
 SELECT  
	DB_NAME() AS DatabaseName, Object_name(o.object_id) AS TableName,
	s.index_id as [IndexID],
	ps.partition_number as [Partition_Num],
	i.name as [Index Name],
	i.type_desc as [Index_Type],
	ps.row_count as [Row_Count] ,
	CAST(ps.reserved_page_count * 8 / 1024. AS NUMERIC(10,2)) as [Reserved_MB],
	s.user_seeks + s.user_scans + s.user_lookups as [Total_Reads], s.user_seeks, s.user_scans, s.user_lookups, 
	s.user_updates [Total_Writes],
	CASE WHEN s.user_updates < 1 THEN 100. ELSE ( s.user_seeks + s.user_scans + s.user_lookups ) / s.user_updates * 1.0 END AS [Reads_Per_Write] 
FROM    sys.dm_db_index_usage_stats s
JOIN sys.dm_db_partition_stats ps on s.object_id=ps.object_id and s.index_id=ps.index_id
JOIN sys.indexes i ON i.index_id = s.index_id
  AND s.object_id = i.object_id
JOIN sys.objects o ON s.object_id = o.object_id
JOIN sys.schemas c ON o.schema_id = c.schema_id
where ps.row_count > 1
  and s.database_id > 4
 order by [Total_Reads] , [Row_Count] desc, [Index Name];
 
