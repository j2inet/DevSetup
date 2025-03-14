@ECHO OFF
setlocal Enabledelayedexpansion 
ECHO Defining environment variables
SET InstallPython=true
SET InstallCmake=true
SET InstallNinja=true
SET InstallDrive=j:
SET InstallRoot=%InstallDrive%\shares\clang
SET NINJA_ROOT=%InstallDrive%\shares\Ninja
SET TempFolder=%InstallRoot%\temp
SET VS_ROOT_FOLDER=C:\Program Files\Microsoft Visual Studio\2022\Community
SET MSBUILD_FULL_PATH=%VS_ROOT_FOLDER%\MSBuild\Current\Bin\amd64\MSBuild.exe
SET VS_BUILD_FOLDER=%VS_ROOT_FOLDER%\VC\Auxiliary\Build
SET CMAKE_SOURCE_URL=https://github.com/Kitware/CMake/releases/download/v4.0.0-rc3/cmake-4.0.0-rc3-windows-x86_64.msi
SET CMAKE_FILE_NAME=cmake-4.0.0-rc3-windows-x86_64.msi
SET PYTHON_URL=https://www.python.org/ftp/python/3.13.2/python-3.13.2-amd64.exe
SET NINJA_URL=https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-win.zip
SET NINJA_FILE=ninja-winarm64.zip

pushd "%VS_ROOT_FOLDER%\VC\Tools\MSVC\"
for /F  %%a in ('dir 14* /b ') do SET VS_LINKER_FOLDER=%VS_ROOT_FOLDER%\VC\Tools\MSVC\%%a\bin\Hostx64\x64
popd
ECHO REM [34;1;4;5mSet path for current session[0m  > linkpath.txt
ECHO SET PATH=%VS_LINKER_FOLDER%;%PATH% >> linkpath.txt
ECHO. >> linkpath.txt
ECHO REM [34;1;4mSet path permanently[0m  >> linkpath.txt
ECHO SETX PATH %VS_LINKER_FOLDER%;%PATH% >> linkpath.txt
ECHO. >> linkpath.txt
ECHO. >> linkpath.txt
ECHO It may be easier to modify the Path element directly in the registry >> linkpath.txt
ECHO at the following location. >> linkpath.txt
ECHO [33;1m>> linkpath.txt
ECHO HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment >> linkpath.txt
ECHO [0m >> linkpath.txt

ECHO.
ECHO.
ECHO InstallDrive      : %InstallDrive%
ECHO InstallRoot       : %InstallRoot%
ECHO TempFolder        : %TempFolder%
ECHO MSBUILD_FULL_PATH : %MSBUILD_FULL_PATH%
ECHO CMAKE_SOURCE_URL  : %CMAKE_SOURCE_URL%
ECHO CMAKE_FILE_NAME   : %CMAKE_FILE_NAME%
ECHO NINJA_ROOT        : %NINJA_ROOT%
ECHO VS_ROOT_FOLDER    : %VS_ROOT_FOLDER%
ECHO VS_LINKER_FOLDER  : %VS_LINKER_FOLDER%
ECHO.
ECHO.
ECHO.
