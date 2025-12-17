SET drive=c:
set googlePath=%drive%\shares\projects\google\
SET VS_EDITION=Community
SET NINJA_SUMMARIZE_BUILD=1

git config --global core.longpaths true


%drive%
mkdir %googlePath%
cd %googlePath%
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
pushd %googlePath%depot_tools
set PATH=%googlePath%depot_tools;%PATH%
SET DEPOT_TOOLS_WIN_TOOLCHAIN=0
SET vs2022_install=%drive%\Program Files\Microsoft Visual Studio\18\%VS_EDITION%

call gclient

popd
mkdir chromium && cd chromium
call fetch chromium
REM gclient sync -D --force --reset

gn gen out\Default 
gn gen out\ChromeDebug --args="is_debug=true"
gn gen out\ChromeRelease --args="is_debug=false symbol_level=1"
gn gen out\v8Debug --args="is_component_build=false is_debug=true"
gn gen out\v8Release --args="is_component_build=false is_debug=false symbol_level=1"


autoninja -C out\Default base
autoninja -C out\ChromeDebug chrome
autoninja -C out\ChromeRelease chrome
autoninja -C out\v8Debug v8_monolith
autoninja -C out\v8Release v8_monolith

popd
