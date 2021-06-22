<p align="center">
<img alt="Fantail" src="https://github.com/francesco1119/QueryLauncher/blob/master/index.png" />
<p align="center">
<a href="https://github.com/francesco1119/QueryLauncher/issues"><img alt="issues" src="https://img.shields.io/github/issues/francesco1119/QueryLauncher.svg"></a>
<a href="https://github.com/francesco1119/QueryLauncher/network"><img alt="network" src="https://img.shields.io/github/forks/francesco1119/QueryLauncher.svg"></a>
<a href="https://github.com/francesco1119/QueryLauncher/stargazers"><img alt="stargazers" src="https://img.shields.io/github/stars/francesco1119/QueryLauncher.svg"></a>
<a href="https://github.com/francesco1119/QueryLauncher/blob/master/LICENSE"><img alt="LICENSE" src="https://img.shields.io/github/license/francesco1119/QueryLauncher.svg"></a>
<a href="https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Ffrancesco1119%2FQueryLauncher"><img alt="TWITTER" src="https://img.shields.io/twitter/url/https/github.com/francesco1119/QueryLauncher.svg?style=social"></a>
</p>
</p>

# QueryLauncher
A PowerShell query launcher for SQL Server Data Warehouse


How to Install
------

I finally had the time to re-write this tool and it now takes only 20 lines of code, this thanks to:

`Install-Module -Name dbatools`

`Install-Module -Name ImportExcel`

Once you installed both you are good to go

How to use it 
------

1) Paste a list of servers into the very first variable of the script: 

```
# Put your list of SQL Server estate here
$SqlInstances = 'ServerName1','ServerName2','ServerName3'
```

2) Paste your SQL queries into the `Queries` folder. In the `Queries` folder you will find 10 queries which are the [Glenn Berry's](https://sqlserverperformance.wordpress.com/2012/07/08/sql-server-2012-diagnostic-information-queries-july-2012/) [Diagnostic Information Queries 2012](https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/SQL%20Server%202012%20Diagnostic%20Information%20Queries.sql); you can replace them with your preferred queries
3) Run QueryLauncer.ps1
4) QueryLauncher will run all queries one by one and will save the results in a file with server name and date. Each query output will be stored on a different Excel tab

[![IMAGE ALT TEXT HERE](https://github.com/francesco1119/QueryLauncher/blob/master/YoutubeVideo.png?raw=true)](https://youtu.be/DzdFx4tpox8)

Troubleshooting
------

If you have a query with the same column mentioned twice you will receive this error:
```
invoke-sqlcmd : Duplicate column names are not permitted in SQL PowerShell. To repeat a column, use a column alias for the duplicate column in the format Column_Name AS New_Name.
At C:\Users\FrancescoM\Desktop\CSV\QueryLauncher.ps1:30 char:15
+ ... $oresults = invoke-sqlcmd -ServerInstance $Server -Database $Database ...
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SyntaxError: (:) [Invoke-Sqlcmd], SqlPowerShellSqlExecutionException
    + FullyQualifiedErrorId : DuplicateColumnNameErrorMessage,Microsoft.SqlServer.Management.PowerShell.GetScriptCommand
```
...so remove the duplicate columns

Future developent
------

On spare time my TODO list is:

* Error catch

**Please if you have requests drop me a line**
