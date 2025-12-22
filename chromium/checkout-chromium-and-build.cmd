
ECHO ON
timeout /t 80 /nobreak 

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

cd src

ECHO Starting configuration of chromium with Default options at %TIME% >> %googlePath%build_log.txt
gn gen out\Default 
ECHO Finished configuration of chromium with Default options at %TIME% >> %googlePath%build_log.txt

ECHO Starting configuration of v8 with Release options at %TIME% >> %googlePath%build_log.txt
gn gen out\v8Release --args="is_component_build=false is_debug=false symbol_level=1 v8_enable_object_print=true v8_enable_disassembler=true target_cpu=\"x64\" v8_static_library = true v8_use_external_startup_data=false v8_monolithic=true"
ECHO Finished configuration of v8 with Release options at %TIME% >> %googlePath%build_log.txt

ECHO Starting configuration of v8 with Debug options at %TIME% >> %googlePath%build_log.txt
gn gen out\v8Debug --args="is_component_build=false is_debug=true  symbol_level=1 v8_enable_object_print=true v8_enable_disassembler=true target_cpu=\"x64\" v8_static_library = true v8_use_external_startup_data=false v8_monolithic=true"
ECHO Finished configuration of v8 with Debug options at %TIME% >> %googlePath%build_log.txt

ECHO Starting configuration of Chrome with Debug options at %TIME% >> %googlePath%build_log.txt
gn gen out\ChromeDebug --args="is_debug=true"
ECHO Finished configuration of Chrome with Debug options at %TIME% >> %googlePath%build_log.txt

ECHO Starting configuration of Chrome with Release options at %TIME% >> %googlePath%build_log.txt
gn gen out\ChromeRelease --args="is_debug=false symbol_level=1"
ECHO Finished configuration of Chrome with Release options at %TIME% >> %googlePath%build_log.txt


ECHO Starting build of chromium with Default options at %TIME% >> %googlePath%build_log.txt
autoninja -C out\Default base %JOBS_PARAMETER%
ECHO Finished build of chromium with Default options at %TIME% >> %googlePath%build_log.txt

ECHO Starting build of Chrome with Debug options at %TIME% >> %googlePath%build_log.txt
autoninja -C out\ChromeDebug chrome %JOBS_PARAMETER%
ECHO Finished build of Chrome with Debug options at %TIME% >> %googlePath%build_log.txt

ECHO Starting build of Chrome with Release options at %TIME% >> %googlePath%build_log.txt
autoninja -C out\ChromeRelease chrome %JOBS_PARAMETER%
ECHO Finished build of Chrome with Release options at %TIME% >> %googlePath%build_log.txt

ECHO Starting build of v8 with Debug options at %TIME% >> %googlePath%build_log.txt
autoninja -C out\v8Debug v8_monolith %JOBS_PARAMETER%
ECHO Finished build of v8 with Debug options at %TIME% >> %googlePath%build_log.txt

ECHO Starting build of v8 with Release options at %TIME% >> %googlePath%build_log.txt
autoninja -C out\v8Release v8_monolith %JOBS_PARAMETER%
ECHO Finished build of v8 with Release options at %TIME% >> %googlePath%build_log.txt

popd
