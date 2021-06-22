# Put your list of SQL Server estate here
$SqlInstances = 'localhost'
# Eventually choose a database or write USE on each query
$destinationDatabase = 'master'
# Queries will be picked up from here
$folderPath = '.\Queries'
# Choose how to format each date ("yyyy-MM-dd") or ("yyyy-MM-dd HH:mm:ss")
$DateTime = (Get-Date).ToString("yyyy-MM-dd")
# From the list of Instances query each instance one by one
ForEach($SqlInstance in $SqlInstances) {
	# Create a connection to the server that we will reuse - can use SqlCredential for alternative creds
	$sqlInst = Connect-DbaInstance -SqlInstance $SqlInstance
  # Sort numbers and letters alphabetically
(Get-ChildItem $folderPath | sort-object {if (($i = $_.BaseName -as [int])) {$i} else {$_}} ).Foreach{
	# Invoke
    Invoke-DbaQuery -SqlInstance $sqlInst -Database $destinationDatabase -File $psitem.FullName | Export-Excel -Path ".\Results\$SqlInstance`_$DateTime`.xlsx" -AutoSize   -WorksheetName $psitem
	# Write something to the host, don't make him/her feel alone
	write-host "Executing $psitem on $SqlInstance"
	}
}
