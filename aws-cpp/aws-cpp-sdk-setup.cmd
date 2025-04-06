@ECHO OFF
cls
pushd
SET startTime=%date% %time%
set CloneDrive=c:
set CloneFolder=%CloneDrive%\shares\projects\amazon
set InstallDrive=c:
set InstallFolder=%InstallDrive%\shares\projects\amazon\aws-cpp-sdk-lib


type ..\ansi\j2i-256.ans
timeout 3

ECHO For more information on this procedure, see https://docs.aws.amazon.com/sdk-for-cpp/
pushd

%InstallDrive%
mkdir %InstallFolder%
%CloneDrive%
mkdir %CloneFolder%
cd %CloneFolder%


git clone --recurse-submodules https://github.com/aws/aws-sdk-cpp
echo [34;42mClone Complete[0m
cd aws-sdk-cpp
mkdir sdk_build
cd sdk_build
REM cmake ".." -DCMAKE_BUILD_TYPE=Debug  -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=%InstallFolder%

cmake ".." -DCMAKE_BUILD_TYPE=Debug  -G "Visual Studio 17 2022" -DBUILD_SHARED_LIBS="ON" -A x64 -DENABLE_TESTING="OFF" -DFORCE_SHARED_CRT="OFF" -DCMAKE_INSTALL_PREFIX=%InstallFolder%\DebugShared
echo [34;42mDebug Shared Project Build Complete[0m
cmake --build . --config=Debug
echo [34;42mDebug Shared Build Complete[0m
cmake --install . --config=Debug
echo  [34;42mInstall Debug Shared Complete[0m

cmake ".." -DCMAKE_BUILD_TYPE=Debug  -G "Visual Studio 17 2022" -DBUILD_SHARED_LIBS="OFF" -A x64 -DENABLE_TESTING="OFF" -DFORCE_SHARED_CRT="ON" -DCMAKE_INSTALL_PREFIX=%InstallFolder%\DebugStatic
echo [34;42mDebug static Project Build Complete[0m
cmake --build . --config=Debug
echo [34;42mDebug Static Build Complete[0m
cmake --install . --config=Debug
echo  [34;42mInstall Debug Static Complete[0m


cmake ".." -DCMAKE_BUILD_TYPE=Release  -G "Visual Studio 17 2022" -DBUILD_SHARED_LIBS="ON" -A x64 -DENABLE_TESTING="OFF" -DFORCE_SHARED_CRT="OFF" -DCMAKE_INSTALL_PREFIX=%InstallFolder%\ReleaseShared
echo [34;42mRelease Static Project Build Complete[0m
cmake --build . --config=Release
echo [34;42mRelease Shared Build Complete[0m
cmake --install . --config=Release
echo  [34;42mInstall Release Shared Complete[0m


cmake ".." -DCMAKE_BUILD_TYPE=Debug  -G "Visual Studio 17 2022" -DBUILD_SHARED_LIBS="OFF" -A x64 -DENABLE_TESTING="OFF" -DFORCE_SHARED_CRT="ON" -DCMAKE_INSTALL_PREFIX=%InstallFolder%\ReleaseStatic
echo [34;42mRelease Static Project Build Complete[0m
cmake --build . --config=Release
echo [34;42mRelease Static Build Complete[0m
cmake --install . --config=Release
echo  [34;42mInstall Release Static Complete[0m




SET endTime=%date% %time%

ECHO For more information on this procedure, see [36mhttps://docs.aws.amazon.com/sdk-for-cpp/[0m
ECHO Start Time : %startTime%
ECHO End Time:  %endTime%
