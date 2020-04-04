$MSBUILD_PATH="C:\SD\VS2019\MSBuild\Current\Bin\MSBuild.exe"; 
$BUILD_PATH=".\bin\Release\";
$DEPLOY_PATH="..\deploy\";
$BACKUP_PATH="..\archive\"

& $MSBUILD_PATH .\winFormsDeploy.sln /t:Build /p:Configuration=Release 

$arch_name=Get-Date -Format "yyyyMMdd_HHmmss_";
if ($DEPLOY_PATH+'.revisioninfo' | Test-Path){
	$arch_name+=Get-Content $DEPLOY_PATH'.revisioninfo' -First 1;
} else {
	$arch_name+="[unknown_revision]";
}

Compress-Archive -Path $BUILD_PATH* -DestinationPath $BACKUP_PATH$arch_name'.zip' -CompressionLevel Fastest;


xcopy /Y $BUILD_PATH* $DEPLOY_PATH
