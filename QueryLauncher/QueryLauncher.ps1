############################################# 
#											#
#           Vista Query Launcher V1.0  	  	# 
#              					            # 
#############################################

# Needs this to install https://stackoverflow.com/questions/51622424/powershell-invoke-sqlcmd-with-get-credential-doesnt-work 

$Servers = get-content -Path "Servers.txt"																	
$DatabaseName ="master" 																															
$credential = Get-Credential #Prompt for user credentials 
#$secpasswd = ConvertTo-SecureString "Network1" -AsPlainText -Force
#$credential = New-Object System.Management.Automation.PSCredential ("sa", $secpasswd)	
# get the folder this script is running from
$ScriptFolder = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path $MyInvocation.MyCommand.Path }
Write-Host $ScriptFolder
# the following paths are relative to the path this script is in
$QueriesFolder = Join-Path -Path $ScriptFolder -ChildPath 'Queries'
$ResultFolder  = Join-Path -Path $ScriptFolder -ChildPath 'Results'
# make sure the 'Results' folder exists; create if not
if (!(Test-Path -Path $ResultFolder -PathType Container)) {
    New-Item -Path $ResultFolder -ItemType Directory | Out-Null
}																												

ForEach($Server in $Servers) 																														
	{
	$DateTime = (Get-Date).tostring("yyyy-MM-dd") 																									
	ForEach ($filename in get-childitem -path $QueriesFolder -filter "*.sql" | sort-object {if (($i = $_.BaseName -as [int])) {$i} else {$_}} ) 	
		{
		$oresults = invoke-sqlcmd -ServerInstance $Server -Database $DatabaseName -Credential $credential -InputFile $filename.fullname 			
		write-host "Executing $filename on $Server" 																								
		$BaseNameOnly = Get-Item $filename.fullname | Select-Object -ExpandProperty BaseName
		$there = Join-Path -Path $ResultFolder -ChildPath "$BaseNameOnly.csv"
		$oresults | export-csv $there -NoTypeInformation -Force
		} 
		
	$All_CSVs = get-childitem -path $ResultFolder -filter "*.csv" | sort-object {if (($i = $_.BaseName -as [int])) {$i} else {$_}} 
	$Count_CSVs = $All_CSVs.Count
	Write-Host "Detected the following CSV files: ($Count_CSVs)"
	Write-Host " "$All_CSVs.Name"`n"
	$ExcelApp = New-Object -ComObject Excel.Application
	$ExcelApp.SheetsInNewWorkbook = $All_CSVs.Count
	#$output = "C:\Users\FrancescoM\Desktop\CSV\Results\" + $Server + " $DateTime.xlsx"
	$output = Join-Path -Path $ResultFolder -ChildPath "$Server $DateTime.xlsx"
	if (Test-Path $output) 
		{
		Remove-Item $output
		Write-Host Removing: $output because it exists already
		}
	$xlsx = $ExcelApp.Workbooks.Add()
	for($i=1;$i -le $Count_CSVs;$i++) 
		{
		$worksheet = $xlsx.Worksheets.Item($i)
		$worksheet.Name = $All_CSVs[$i-1].Name
		$file = (Import-Csv $All_CSVs[$i-1].FullName)
		$file | ConvertTo-Csv -Delimiter "`t" -NoTypeInformation | Clip
		$worksheet.Cells.Item(1).PasteSpecial()|out-null
		}
	
	$xlsx.SaveAs($output)
	Write-Host Creating: $output 
	$ExcelApp.Quit() 
	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($xlsx) | Out-Null; 
	Write-Host "Closing all worksheet"
	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($ExcelApp) | Out-Null; 
	Write-Host "Closing Excel"
	[System.GC]::Collect(); 
	[System.GC]::WaitForPendingFinalizers()
	Remove-Item "$ResultFolder\*" -Include *.csv
	Write-Host "Cleaning all *.csv"
	Start-Sleep -Seconds 3
	}