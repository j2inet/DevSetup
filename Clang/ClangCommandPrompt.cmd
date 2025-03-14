@ECHO OFF
pushd
copy CLangDefineEnvironmentVariables.cmd Combined.bat
ECHO. >> Combined.bat
ECHO PATH=%%VS_LINKER_FOLDER%%;%path% >> Combined.bat
ECHO. >> Combined.bat
popd
REM del Combined.bat
