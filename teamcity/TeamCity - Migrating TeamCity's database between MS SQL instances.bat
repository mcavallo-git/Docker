REM ------------------------------------------------------------
REM
REM TeamCity --> Migrating Database between SQL instances
REM 
REM C:\TeamCity\bin\maintainDB.cmd migrate -A "C:\ProgramData\JetBrains\TeamCity" -T "C:\ProgramData\JetBrains\TeamCity\config\database.migration-target.properties"
REM
REM ------------------------------------------------------------


connectionUrl=jdbc:sqlserver://SERVER_FQDN:1433;databaseName=DATABASE_NAME

connectionProperties.user=SQL_USERNAME
connectionProperties.password=SQL_PASSWORD

maxConnections=50
poolPreparedStatements=true


REM Start-Process "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vs_installer.exe" -ArgumentList 'modify --installPath "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools" --quiet --add Microsoft.VisualStudio.Component.NuGet.BuildTools --add Microsoft.Net.Component.4.5.TargetingPack --norestart --force' -Wait -PassThru

REM ------------------------------------------------------------
REM 
REM Citation(s)
REM 
REM   developercommunity.visualstudio.com  |  ""The "GetReferenceNearestTargetFrameworkTask" task was not found." when building app project with reference to library project if .NET Core cross-platform development workload not installed - Developer Community"  |  https://developercommunity.visualstudio.com/content/problem/137779/the-getreferencenearesttargetframeworktask-task-wa.html
REM 
REM   www.jetbrains.com  |  "Migrating to an External Database - Help | TeamCity"  |  https://www.jetbrains.com/help/teamcity/migrating-to-an-external-database.html
REM 
REM ------------------------------------------------------------