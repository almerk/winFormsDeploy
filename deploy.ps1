$MSBUILD_PATH="C:\SD\VS2019\MSBuild\Current\Bin\MSBuild.exe" 
$BUILD_PATH=".\bin\Release"

& $MSBUILD_PATH .\winFormsDeploy.sln /t:Build /p:Configuration=Release 

