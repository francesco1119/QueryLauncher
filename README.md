<p align="center">
<img alt="Fantail" src="https://github.com/francesco1119/QueryLauncher/blob/master/index.png" />
<p align="center">
<a href="https://github.com/francesco1119/QueryLauncher/issues"><img alt="issues" src="https://img.shields.io/github/issues/francesco1119/QueryLauncher.svg"></a>
<a href="https://github.com/francesco1119/QueryLauncher/network"><img alt="network" src="https://img.shields.io/github/forks/francesco1119/QueryLauncher.svg"></a>
<a href="https://github.com/francesco1119/QueryLauncher/stargazers"><img alt="stargazers" src="https://img.shields.io/github/stars/francesco1119/QueryLauncher.svg"></a>
<a href="https://github.com/francesco1119/QueryLauncher/blob/master/LICENSE"><img alt="LICENSE" src="https://img.shields.io/github/license/francesco1119/QueryLauncher.svg"></a>
<a href="https://github.com/francesco1119/QueryLauncher"><img alt="LICENSE" src="https://img.shields.io/pypi/pyversions/QueryLauncher.svg"></a>
</p>
</p>

# QueryLauncher
A PowerShell query launcher for SQL Server Data Warehouse


How to Install
======

As if life wasn't complicated enough there are [2 versions](https://stackoverflow.com/questions/51622424/powershell-invoke-sqlcmd-with-get-credential-doesnt-work) of `Invoke-Sqlcmd`:
1) [The Database Engine](https://docs.microsoft.com/en-us/sql/database-engine/invoke-sqlcmd-cmdlet?view=sql-server-2014):  where `-Credentials` parameter is **not available.**
2) [The SqlServer module](https://docs.microsoft.com/en-us/powershell/module/sqlserver/invoke-sqlcmd?view=sqlserver-ps): where `-Credentials` parameter is **available.**

We are going to use the second one so you just need to run `Install-Module -Name SqlServer -AllowClobber`

Make sure to include the `-AllowClobber` switch. It's a dumb-installer, and if you leave off the switch it will download the ~24MB package and then fail because it's overwriting the database engine version.
