cd src

ECHO Starting configuration of chromium with Default options at %TIME% >> %googlePath%build_log.txt
call gn gen out\Default 
ECHO Finished configuration of chromium with Default options at %TIME% >> %googlePath%build_log.txt

ECHO Starting configuration of v8 with Release options at %TIME% >> %googlePath%build_log.txt
call gn gen out\v8Release --args="is_component_build=false is_debug=false symbol_level=1 v8_enable_object_print=true v8_enable_disassembler=true target_cpu=\"x64\" v8_static_library = true v8_use_external_startup_data=false v8_monolithic=true"
ECHO Finished configuration of v8 with Release options at %TIME% >> %googlePath%build_log.txt

ECHO Starting configuration of v8 with Debug options at %TIME% >> %googlePath%build_log.txt
call gn gen out\v8Debug --args="is_component_build=false is_debug=true  symbol_level=1 v8_enable_object_print=true v8_enable_disassembler=true target_cpu=\"x64\" v8_static_library = true v8_use_external_startup_data=false v8_monolithic=true"
ECHO Finished configuration of v8 with Debug options at %TIME% >> %googlePath%build_log.txt

ECHO Starting configuration of Chrome with Debug options at %TIME% >> %googlePath%build_log.txt
call gn gen out\ChromeDebug --args="is_debug=true"
ECHO Finished configuration of Chrome with Debug options at %TIME% >> %googlePath%build_log.txt

ECHO Starting configuration of Chrome with Release options at %TIME% >> %googlePath%build_log.txt
call gn gen out\ChromeRelease --args="is_debug=false symbol_level=1"
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
