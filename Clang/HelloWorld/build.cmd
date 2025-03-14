mkdir build > nul
pushd build
cls && cmake -GNinja   ..
ninja
popd