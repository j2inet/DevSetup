@echo off
call CLangDefineEnvironmentVariables.cmd
mkdir %InstallRoot%
cd %InstallRoot%
%InstallDrive%
git clone https://github.com/llvm/llvm-project.git
cd llvm-project
git config core.autocrlf false
mkdir build
pushd build
cmake -DLLVM_ENABLE_PROJECTS=clang -G "Visual Studio 17 2022" -A x64 -Thost=x64 ..\llvm
cd tools\clang\tools\driver
%MSBUILD_FULL_PATH%" clang.vcxproj /p:Configuration=Release
mkdir %InstallRoot%\bin
robocopy \build\Debug\bin %InstallRoot%\bin /MIR
"%MSBUILD_FULL_PATH%" clang.vcxproj
