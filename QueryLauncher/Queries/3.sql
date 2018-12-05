IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES T WHERE T.TABLE_NAME = 'tblProcessDefinition')
BEGIN


	-- 03 Last 2000 Vista Task History
	SELECT top 2000 
		  [Process_strId]
		  ,[Process_strName]
		  ,[Process_strType]
		  ,[ProcessHistory_dtmStart], [ProcessHistory_dtmEnd], [ProcessHistory_strSuccess]
		  ,DATEDIFF(SECOND,[ProcessHistory_dtmStart],[ProcessHistory_dtmEnd]) as [Duration_secs]
		  ,[ProcessHistory_strDetails]
	  FROM [tblProcessHistory] WITH (NOLOCK)
	  ORDER BY [tblProcessHistory].ProcessHistory_intID DESC;
END