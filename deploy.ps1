$MSBUILD_PATH="C:\SD\VS2019\MSBuild\Current\Bin\MSBuild.exe"; 
$BUILD_PATH=".\bin\Release";
$DEPLOY_PATH="..\deploy";
$BACKUP_PATH="..\archive"

& $MSBUILD_PATH .\winFormsDeploy.sln /t:Build /p:Configuration=Release 

xcopy /Y $BUILD_PATH $DEPLOY_PATH
