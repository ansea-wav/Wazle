# Automate Android SDK setup and compilation for Antrac APK
$ErrorActionPreference = "Stop"

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "   Antrac APK Compiler and SDK Auto-Setup Script" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# Force define Java path and JAVA_HOME
$env:JAVA_HOME = "C:\Program Files\Microsoft\jdk-17.0.18.8-hotspot"
$env:PATH = "C:\Program Files\Microsoft\jdk-17.0.18.8-hotspot\bin;$env:PATH"

# 1. Verify Java version explicitly
try {
    $javaPath = "C:\Program Files\Microsoft\jdk-17.0.18.8-hotspot\bin\java.exe"
    $javaVer = & "$javaPath" -version 2>&1
    Write-Host "✔ Java is verified: $javaVer" -ForegroundColor Green
} catch {
    Write-Error "Java JDK is required but could not be launched at $javaPath."
    exit
}

$sdkDir = "$PSScriptRoot\android-sdk"
$toolsDir = "$sdkDir\cmdline-tools"
$zipPath = "$sdkDir\commandlinetools.zip"

if (-not (Test-Path $sdkDir)) {
    New-Item -ItemType Directory -Force -Path $sdkDir | Out-Null
}

# 2. Download Android Command Line Tools (~100MB)
if (-not (Test-Path "$toolsDir\bin\sdkmanager.bat")) {
    Write-Host "Downloading Android Command Line Tools from Google..." -ForegroundColor Yellow
    $url = "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"
    Invoke-WebRequest -Uri $url -OutFile $zipPath
    
    Write-Host "Extracting Command Line Tools..." -ForegroundColor Yellow
    Expand-Archive -Path $zipPath -DestinationPath "$toolsDir\temp" -Force
    
    # Restructure folder to match Google's sdkmanager expected structure
    New-Item -ItemType Directory -Force -Path "$toolsDir\latest" | Out-Null
    Move-Item -Path "$toolsDir\temp\cmdline-tools\*" -Destination "$toolsDir\latest" -Force
    Remove-Item -Recurse -Force "$toolsDir\temp"
    Remove-Item -Force $zipPath
    Write-Host "Setup command line tools completed!" -ForegroundColor Green
}

# 3. Create Local Properties pointing to this SDK
Write-Host "Creating local.properties..." -ForegroundColor Yellow
$localPropsPath = "$PSScriptRoot\local.properties"
$sdkDirEscaped = $sdkDir.Replace('\', '\\')
"sdk.dir=$sdkDirEscaped" | Out-File -FilePath $localPropsPath -Encoding utf8 -Force

# 4. Accept Android SDK Licenses and Install Platform + Build Tools
Write-Host "Downloading Android Platform 33 and Build Tools..." -ForegroundColor Yellow
$sdkmanager = "$toolsDir\latest\bin\sdkmanager.bat"

# Accept licenses automatically
$env:ANDROID_HOME = $sdkDir
Write-Host "Accepting Android Licenses..." -ForegroundColor Yellow
# Run sdkmanager to accept licenses
$yes = "y`ny`ny`ny`ny`ny`ny`ny`ny`ny`n"
$yes | & "$sdkmanager" --sdk_root="$sdkDir" --licenses

Write-Host "Installing Platform 33 and Build Tools..." -ForegroundColor Yellow
& "$sdkmanager" --sdk_root="$sdkDir" "platforms;android-33" "build-tools;33.0.2"

Write-Host "Android SDK platform setup completed!" -ForegroundColor Green

# 5. Compile the APK
Write-Host "Compiling the Antrac APK..." -ForegroundColor Yellow
if ($IsWindows) {
    & .\gradlew.bat assembleDebug
} else {
    chmod +x gradlew
    & ./gradlew assembleDebug
}

$apkPath = "$PSScriptRoot\app\build\outputs\apk\debug\app-debug.apk"
if (Test-Path $apkPath) {
    $destApk = "$PSScriptRoot\Antrac-beta-v0.1.apk"
    Copy-Item -Path $apkPath -Destination $destApk -Force
    Write-Host "==================================================" -ForegroundColor Green
    Write-Host "SUCCESS! APK compiled successfully!" -ForegroundColor Green
    Write-Host "APK Location: $destApk" -ForegroundColor Green
    Write-Host "==================================================" -ForegroundColor Green
} else {
    Write-Error "Compilation failed. APK file not found."
}
