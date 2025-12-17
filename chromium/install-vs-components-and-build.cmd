 
pushd C:\Program Files (x86)\Microsoft Visual Studio\Installer\
start /wait vs_installer.exe install --passive --productid Microsoft.VisualStudio.Product.Community --ChannelId VisualStudio.18.Release --add Microsoft.VisualStudio.Workload.NativeDesktop  --add Microsoft.VisualStudio.Component.VC.ATLMFC  --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 --add Microsoft.VisualStudio.Component.VC.MFC.ARM64  --add Microsoft.VisualStudio.Component.VC.Llvm.Clang --add Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang  --includeRecommended
popd

call checkout-chromium-and-build.cmd
