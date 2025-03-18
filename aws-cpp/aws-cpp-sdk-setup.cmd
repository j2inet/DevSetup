@ECHO OFF

set CloneDrive=c:
set CloneFolder=%CloneDrive%\shares\projects\amazon
set InstallDrive=c:
set InstallFolder=%InstallDrive%\%InstallFolder%

ECHO For more information on this procedure, see https://docs.aws.amazon.com/sdk-for-cpp/
pushd
%CloneDrive%
mkdir %InstallFolder%
mkdir %CloneDrive%

cd %InstallFolder%
%InstallDrive%

git clone --recurse-submodules https://github.com/aws/aws-sdk-cpp
cd aws-sdk-cpp
mkdir sdk_build
cd sdk_build
cmake ".." -DCMAKE_BUILD_TYPE=Debug  -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=%InstallFolder%