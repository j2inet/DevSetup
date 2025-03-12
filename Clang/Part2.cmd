@ECHO OFF
Copy CLangDefineEnvironmentVariables.cmd + 1-BuildClang.cmd Combined.bat
call Combined.bat
del Combined.bat
