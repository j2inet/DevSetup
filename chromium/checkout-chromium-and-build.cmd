
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
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
pushd %googlePath%depot_tools

call gclient

popd
mkdir chromium && cd chromium
call fetch chromium
call gclient sync -D --force --reset

cd src

gn gen out\Default 
gn gen out\v8Release --args="is_component_build=false is_debug=false symbol_level=1 v8_enable_object_print=true v8_enable_disassembler=true target_cpu=\"x64\" v8_static_library = true v8_use_external_startup_data=false v8_monolithic=true"
gn gen out\v8Debug --args="is_component_build=false is_debug=true  symbol_level=1 v8_enable_object_print=true v8_enable_disassembler=true target_cpu=\"x64\" v8_static_library = true v8_use_external_startup_data=false v8_monolithic=true"
gn gen out\ChromeDebug --args="is_debug=true"
gn gen out\ChromeRelease --args="is_debug=false symbol_level=1"


autoninja -C out\Default base %JOBS_PARAMETER%
autoninja -C out\ChromeDebug chrome %JOBS_PARAMETER%
autoninja -C out\ChromeRelease chrome %JOBS_PARAMETER%
autoninja -C out\v8Debug v8_monolith %JOBS_PARAMETER%
autoninja -C out\v8Release v8_monolith %JOBS_PARAMETER%

popd
