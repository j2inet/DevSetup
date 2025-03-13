REM @echo off
call CLangDefineEnvironmentVariables.cmd
%InstallDrive%
CD %InstallRoot%
mkdir %TempFolder%
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO Grabbing CMAKE version 4.0.0 rc3  for Windows
ECHO.
ECHO To manually install some other version, see https://cmake.org/download/
ECHO.
ECHO.
TIMEOUT 8
if defined InstallCmake (
    if not exist "%TempFolder%\%CMAKE_FILE_NAME%" (
        powershell Invoke-WebRequest -Uri  "%CMAKE_SOURCE_URL%" -OutFile "%TempFolder%\%CMAKE_FILE_NAME%"
        ECHO Installing CMAKE
        start "%TempFolder%\%CMAKE_FILE_NAME%"
        ECHO.
        ECHO Once installation completes, return to this window and continue.
        PAUSE
    )
)

REM =========================
ECHO Updating Visual Studio
pushd "C:\Program Files (x86)\Microsoft Visual Studio\Installer\"
ECHO.
ECHO.
ECHO Once the Visual Studio installation completes, return to this window and press any
ECHO key to continue.
start vs_installer.exe install --productid Microsoft.VisualStudio.Product.Community --ChannelId VisualStudio.17.Release --add Microsoft.VisualStudio.Component.VC.Llvm.Clang --add Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang	 --includeRecommended
popd
PAUSE
CLS

REM =========================
if defined InstallPython (
    if not exist "%TempFolder%\python-3.13.2-amd64.exe" (
        ECHO Downloading Python3
        powershell Invoke-WebRequest -Uri "%PYTHON_URL%" -OutFile "%TempFolder%\python-3.13.2-amd64.exe"
        ECHO.
        ECHO.
        ECHO.
        ECHO.
        ECHO.
        ECHO Install Python3. Once the installation completes, return to this window and press any key.
        ECHO.
        ECHO.
        "%TempFolder%\python-3.13.2-amd64.exe"
        PAUSE
    )
)
REM =========================
CLS
ECHO.
ECHO.
ECHO To clone and build Cmake, open a new terminal window and run Part2.cmd