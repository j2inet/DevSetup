
ECHO ON
timeout /t 8 /nobreak 

SET drive=c:
set googlePath=%drive%\shares\projects\google\
SET VS_EDITION=Community
SET NINJA_SUMMARIZE_BUILD=1
SET PARALLEL_JOBS=8
IF(%PARALLEL_JOBS% EQU 0) (
    SET JOBS_PARAMETER=-j%PARALLEL_JOBS%    
) else (
    SET JOBS_PARAMETER=
)
DATE /T >> %googlePath%build_log.txt
ECHO Starting build at %TIME% >> %googlePath%build_log.txt

set PATH=%googlePath%depot_tools;%PATH%
SET DEPOT_TOOLS_WIN_TOOLCHAIN=0
SET vs2022_install=%drive%\Program Files\Microsoft Visual Studio\18\%VS_EDITION%

git config --global core.longpaths true
git config --global core.autocrlf false
git config --global core.filemode false
git config --global core.fscache true
git config --global core.preloadindex true


%drive%
mkdir %googlePath%
cd %googlePath%
ECHO Starting clone of depot_tools at %TIME% >> %googlePath%build_log.txt
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
pushd %googlePath%depot_tools
ECHO Finished clone of depot_tools at %TIME% >> %googlePath%build_log.txt
call gclient

popd
mkdir chromium && cd chromium
ECHO Starting checkout of chromium at %TIME% >> %googlePath%build_log.txt
call fetch chromium
call gclient sync -D --force --reset
ECHO Finished checkout of chromium at %TIME% >> %googlePath%build_log.txt

