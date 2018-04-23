@REM run all sql scripts
@ECHO OFF

if [%1]==[] GOTO :print_usage

SET SCRIPTS_PATH=%~dp0
set CONTAINER_ID=%1%
set SQL_SERVER="localhost\SIDEXIS_SQL,42916"

echo Provisioning container %CONTAINER_ID%

echo Copying scripts
docker cp %SCRIPTS_PATH% %CONTAINER_ID%:C:\scripts
docker exec -it %CONTAINER_ID% sqlcmd -S %SQL_SERVER% -d master -i C:\scripts\CreateSidexisDatabase.sql 
docker exec -it %CONTAINER_ID% sqlcmd -S %SQL_SERVER% -d SIDEXIS -i C:\scripts\Upgrade_0_5.7.sql 
docker exec -it %CONTAINER_ID% sqlcmd -S %SQL_SERVER% -d SIDEXIS -i C:\scripts\UpdateMediaWorkspace.sql 
docker exec -it %CONTAINER_ID% sqlcmd -S %SQL_SERVER% -d SIDEXIS -i C:\scripts\FinishProvisioning.sql 

echo done.
exit /b 0

:print_usage
ECHO Usage: runall container sql_server
exit /b -1