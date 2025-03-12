@ECHO OFF
Copy CLangDefineEnvironmentVariables.cmd + 0-InstallDependencies.cmd Combined.bat
call Combined.bat
del Combined.bat
