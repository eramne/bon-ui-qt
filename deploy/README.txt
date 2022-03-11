**DEPLOYING ON WINDOWS**

1) Make sure you have built the demo in release mode, e.g. with QtCreator, and
   find the resulting .exe and its containing path, e.g. "demo.exe" in 
   "(...)/bon-ui-qt/build/build-bon-ui-Desktop_Qt_...-Release/demo/release/".
2) Inside deploy_win.bat, modify the qtdir variable to point to wherever you
   have QT installed where all the executable tools like windeployqt should be,
   such as "C:\Qt\6.2.3\mingw_64\bin".
3) Modify the "exePath" variable to point to where the built executable is 
   created by QtCreator, such as 
   "..\build\build-bon-ui-Desktop_Qt_6_2_3_MinGW_64_bit-Release\demo\release",
   and change the "exeName" variable to the name of the exe, such as 
   "demo.exe".
4) If needed, change the "qmlPath" variable to bon's qml "imports/" folder,
   such as "..\src\imports\", and set "outputPath" to the name of the folder to
   create the deployment in, such as "out". 
5) After making these changes, save and start the "deploy_win.bat" file. All 
   the required dlls, libraries, executables, resources, etc. should be copied 
   to the output folder, and the application should start automatically.
