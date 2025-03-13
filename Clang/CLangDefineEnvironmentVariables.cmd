@ECHO OFF
setlocal Enabledelayedexpansion 
ECHO Defining environment variables
SET InstallPython=true
SET InstallCmake=false
SET InstallDrive=j:
SET InstallRoot=%InstallDrive%\shares\clang
SET TempFolder=%InstallRoot%\temp
SET MSBUILD_FULL_PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\amd64\MSBuild.exe
SET CMAKE_SOURCE_URL=https://github.com/Kitware/CMake/releases/download/v4.0.0-rc3/cmake-4.0.0-rc3-windows-x86_64.msi
SET CMAKE_FILE_NAME=cmake-4.0.0-rc3-windows-x86_64.msi
SET PYTHON_URL=https://www.python.org/ftp/python/3.13.2/python-3.13.2-amd64.exe

cls
ECHO.
ECHO.
ECHO InstallDrive      : %InstallDrive%
ECHO InstallRoot       : %InstallRoot%
ECHO TempFolder        : %TempFolder%
ECHO MSBUILD_FULL_PATH : %MSBUILD_FULL_PATH%
ECHO CMAKE_SOURCE_URL  : %CMAKE_SOURCE_URL%
ECHO CMAKE_FILE_NAME   : %CMAKE_FILE_NAME%
ECHO.
ECHO.
ECHO.