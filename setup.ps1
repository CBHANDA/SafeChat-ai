# Windows setup: builds the full Flutter project in .\safechat_app
# Run with:  powershell -ExecutionPolicy Bypass -File setup.ps1
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  Write-Host "Flutter not found. See README.md step 1."; exit 1
}
if (Test-Path safechat_app) {
  Write-Host "safechat_app already exists. Delete it first to re-run."; exit 1
}

flutter create --project-name safechat_ai --org ug.ucc.hackathon --platforms android safechat_app

Remove-Item safechat_app\test\widget_test.dart -Force -ErrorAction SilentlyContinue
Remove-Item safechat_app\lib -Recurse -Force
Copy-Item src\lib safechat_app\lib -Recurse
Copy-Item src\test\* safechat_app\test\ -Recurse
Copy-Item src\pubspec.yaml safechat_app\pubspec.yaml -Force

# Let url_launcher open the SMS app on Android 11+
$m = "safechat_app\android\app\src\main\AndroidManifest.xml"
$q = '<queries><intent><action android:name="android.intent.action.VIEW"/><data android:scheme="sms"/></intent></queries>'
(Get-Content $m -Raw) -replace '<application', ($q + "`n    <application") | Set-Content $m

Set-Location safechat_app
flutter pub get
flutter test
Write-Host ""
Write-Host "Setup done. Next: cd safechat_app; flutter run"
