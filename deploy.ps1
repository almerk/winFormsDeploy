﻿$MSBUILD_PATH="C:\SD\VS2019\MSBuild\Current\Bin\MSBuild.exe"; 
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

#echo "Backup name: $arch_name.zip" 


Compress-Archive -Path $DEPLOY_PATH* -DestinationPath $BACKUP_PATH$arch_name'.zip' -CompressionLevel Fastest;
Remove-Variable arch_name;


#echo "Stopping running process..."
$process=Get-Process winFormsDeploy -ErrorAction SilentlyContinue
if($process){
	$process.CloseMainWindow();
	Sleep 5;
	if(!$process.HasExited){
		$process | Stop-Process -Force
	}
}
Remove-Variable process;


xcopy /Y $BUILD_PATH* $DEPLOY_PATH

#echo "Starting process..."
& $DEPLOY_PATH"winFormsDeploy.exe" -start 
Sleep 10;
Get-Process winFormsDeploy;
