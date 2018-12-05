-- 09 Index Sizes
-- Note: THIS IS SLOW as it reads index blocks. SAMPLED is not that high, but watch for prod I/O impact if using 'DETAILED'
SELECT DB_NAME() AS DatabaseName,
 Object_name(i.object_id) AS TableName
   ,i.index_id, name AS IndexName
   ,i.type_desc
   ,ips.page_count, ips.compressed_page_count
   ,CAST(ips.avg_fragmentation_in_percent as DECIMAL(5,1)) [fragmentation_pct]
   ,CAST(ips.avg_page_space_used_in_percent as DECIMAL(5,1)) [page_space_used_pct]
   ,ips.index_depth ,ips.forwarded_record_count, ips.record_count
  FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, 'SAMPLED') AS ips -- or SAMPLED
    INNER JOIN sys.indexes AS i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
where ips.page_count > 1
ORDER BY ips.record_count desc;

