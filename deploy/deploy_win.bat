set qtdir=C:\Qt\6.2.3\mingw_64\bin
set exePath=..\build\build-bon-ui-Desktop_Qt_6_2_3_MinGW_64_bit-Release\demo\release
set exeName=demo.exe
set qmlPath=..\src\imports\
set outputPath=out

rmdir %outputPath% /s
mkdir %outputPath%
%qtdir%\windeployqt --qmldir %qmlPath% %exePath%\%exeName% --dir ./%outputPath%/ --no-translations --release --no-system-d3d-compiler --no-virtualkeyboard --no-compiler-runtime --no-opengl-sw --no-bluetooth --no-concurrent --no-designer --no-designercomponents --no-gamepad --no-qthelp --no-multimedia --no-multimediawidgets --no-multimediaquick --no-nfc --no-openglwidgets --no-positioning --no-printsupport --no-qmltooling --no-quickparticles --no-script --no-scripttools --no-sensors --no-serialport --no-sql --no-svg --no-svgwidgets --no-test --no-websockets --no-widgets --no-winextras --no-xml --no-webenginecore --no-webengine --no-webenginewidgets --no-3dcore --no-3drenderer --no-3dquick --no-3dquickrenderer --no-3dinput --no-3danimation --no-3dextras --no-geoservices --no-webchannel --no-texttospeech --no-serialbus --no-webview --no-quickwidgets
copy %exePath%\%exeName% %outputPath%\%exeName%
copy "%qtdir%\libgcc_s_seh-1.dll" "%outputPath%\libgcc_s_seh-1.dll"
copy "%qtdir%\libstdc++-6.dll" "%outputPath%\libstdc++-6.dll"
copy "%qtdir%\libwinpthread-1.dll" "%outputPath%\libwinpthread-1.dll"
del %outputPath%\Qt6QuickDialogs2QuickImpl.dll
del %outputPath%\Qt6QuickDialogs2.dll
del %outputPath%\Qt6QuickDialogs2Utils.dll
del %outputPath%\Qt6QmlXmlListModel.dll
del %outputPath%\Qt6QuickControls2.dll
del %outputPath%\Qt6QuickControls2Impl.dll
del %outputPath%\Qt6QmlLocalStorage.dll
rmdir %outputPath%\imageformats /s /q
rmdir %outputPath%\QtQml\XmlListModel /s /q
rmdir %outputPath%\QtQml\Models /s /q
rmdir %outputPath%\QtQuick\Controls /s /q
rmdir %outputPath%\QtQuick\NativeStyle /s /q
rmdir %outputPath%\QtQuick\Particles /s /q
rmdir %outputPath%\QtQuick\tooling /s /q
rmdir %outputPath%\QtQuick\Dialogs /s /q
rmdir %outputPath%\QtQuick\LocalStorage /s /q
%outputPath%\%exeName%
pause
