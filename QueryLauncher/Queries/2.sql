IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES T WHERE T.TABLE_NAME = 'tblProcessDefinition')
BEGIN
	-- 02 Vista Tasks that have been run
	SELECT [Process_strId], [Process_strEnabled], [Process_strName], [Process_strDescription]
		,[Process_strType] ,[Process_strURI],[Process_strProgID]
		,[Process_strTriggerTime],[Process_strTriggerEvent1],[Process_strTriggerEvent2],[Process_strRepeat]
		,[Process_dtmEnableFrom],[Process_dtmEnableTo]
		,[Process_intMinExecInterval],[Process_strDailyEnabledTime],[Process_strDailyDisabledTime]
		,[Process_dtmLastRun],[Process_strLastRunOK],[Process_strMachineLastExec],[Process_dtmNextExec]
		,[Process_strParamList],[Process_strRunNext]
		,[Process_intMaxHistoryNumber],[Process_strInstance]
		,[Process_strURI_Assembly],[Process_strURI_ClassConfig],[Process_strURI_ClassCustomRun],[Process_strClassTaskParams],[Process_strControl]
	  FROM [tblProcessDefinition] WITH (NOLOCK)
	  where Process_dtmLastRun is not null;


END