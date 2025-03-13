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
"%MSBUILD_FULL_PATH%" ALL_BUILD.vcxproj /p:Configuration=Release
mkdir %InstallRoot%\bin
mkdir %InstallRoot%\lib
robocopy Release\bin %InstallRoot%\bin /MIR
robocopy Release\lib %InstallRoot%\lib /MIR
