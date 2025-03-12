@ECHO OFF
setlocal Enabledelayedexpansion 
ECHO [34;47m
CLS
SET InstallRoot=%UserProfile%
SET InstallDrive=C:
SET MSBUILD_FULL_PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\amd64\MSBuild.exe

%InstallDrive%
CD %InstallRoot%

mkdir temp
REM =========================
SET CMAKE_SOURCE_URL=https://github.com/Kitware/CMake/releases/download/v4.0.0-rc3/cmake-4.0.0-rc3-windows-x86_64.msi
SET CMAKE_FILE_NAME=cmake-4.0.0-rc3-windows-x86_64.msi
powershell Invoke-WebRequest -Uri  "%CMAKE_SOURCE_URL%" -OutFile "temp\%CMAKE_FILE_NAME%"
start temp\%CMAKE_FILE_NAME%
CLS
ECHO Grabbing CMAKE version 4.0.0 rc3  for Windows
ECHO.
ECHO To manually install some other version, see https://cmake.org/download/
ECHO.
ECHO.
TIMEOUT 8
REM =========================
ECHO Updating Visual Studio
pushd "C:\Program Files (x86)\Microsoft Visual Studio\Installer\"
vs_installer.exe install --productid Microsoft.VisualStudio.Product.Community --ChannelId VisualStudio.17.Release --add Microsoft.VisualStudio.Component.VC.Llvm.Clang --add Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang	 --includeRecommended
popd
CLS
ECHO.
ECHO.
ECHO Updating Visual Studio 2022. When the update is complete, press enter.
ECHO.
ECHO.
PAUSE
REM =========================
ECHO Downloading Python3
powershell Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.13.2/python-3.13.2-amd64.exe" -OutFile "temp\python-3.13.2-amd64.exe"
"temp\python-3.13.2-amd64.exe"
PAUSE

ECHO
ECHO.
ECHO Installing CMake. Pausing script. Press enter here once the installation completes.
ECHO.
PAUSE
cd temp
git clone https://github.com/llvm/llvm-project.git
cd llvm-project
git config core.autocrlf false
mkdir build
pushd build
cmake -DLLVM_ENABLE_PROJECTS=clang -G "Visual Studio 17 2022" -A x64 -Thost=x64 ..\llvm
cd tools\clang\tools\driver
"%MSBUILD_FULL_PATH%" clang.vcxproj
ECHO.
ECHO.
ECHO Script Complete
ECHO .
ECHO .
ECHO Consider turning off automatic carriage returns. Clang is sensitive
ECHO to \r\n. You can do this in your projects  with the following command
ECHO
ECHO git config core.autocrlf false
TIMEOUT 10
ECHO [0m;
CLS
