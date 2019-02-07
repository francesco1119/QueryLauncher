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

As if life wasn't complicated enough there are [2 versions](https://stackoverflow.com/questions/51622424/powershell-invoke-sqlcmd-with-get-credential-doesnt-work) of `Invoke-Sqlcmd`:
- [The Database Engine](https://docs.microsoft.com/en-us/sql/database-engine/invoke-sqlcmd-cmdlet?view=sql-server-2014):  where `-Credentials` parameter is **not available.**
- [The SqlServer module](https://docs.microsoft.com/en-us/powershell/module/sqlserver/invoke-sqlcmd?view=sqlserver-ps): where `-Credentials` parameter is **available.**

We are going to use the second one so you just need to run `Install-Module -Name SqlServer -AllowClobber`

Make sure to include the `-AllowClobber` switch. It's a dumb-installer, and if you leave off the switch it will download the ~24MB package and then fail because it's overwriting the database engine version.

How to use it 
------

1) Paste a list of servers into `Servers.txt`, one per line and avoid blank lines
2) Paste your SQL queries into the `Queries` folder using the file extension `.sql`. In the `Queries` folder you will find 14 queries which are the [Glenn Berry's](https://sqlserverperformance.wordpress.com/2012/07/08/sql-server-2012-diagnostic-information-queries-july-2012/) [Diagnostic Information Queries 2012](https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/SQL%20Server%202012%20Diagnostic%20Information%20Queries.sql); you can replace them with your preferred queries
3) Run QueryLauncer.ps1
4) QueryLauncher will create a CSV for every query and merge them into a single Excel file

<p align="center">
<img alt="Fantail" src="https://github.com/francesco1119/QueryLauncher/blob/master/QueryLauncher.gif" />
<p align="center">
<div align="center">
  <a href="https://www.youtube.com/watch?v=DzdFx4tpox8&ab_channel=FrancescoMantovani"><img src="https://www.youtube.com/watch?v=DzdFx4tpox8/0.jpg" alt="QueryLauncher"></a>
</div>

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

* Eventually make a video

**Please if you have requests drop me a line**
