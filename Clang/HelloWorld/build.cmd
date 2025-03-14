mkdir build > nul
pushd build
cls && cmake -GNinja  -DMAKE_TOOLCHAIN_FILE=..\cmake_toolchain_clang.cmake ..
ninja
popd