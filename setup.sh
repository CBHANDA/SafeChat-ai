#!/usr/bin/env bash
# Linux / macOS setup: builds the full Flutter project in ./safechat_app
set -e
cd "$(dirname "$0")"

command -v flutter >/dev/null || { echo "Flutter not found. See README.md step 1."; exit 1; }
[ -d safechat_app ] && { echo "safechat_app already exists. Delete it first to re-run."; exit 1; }

flutter create --project-name safechat_ai --org ug.ucc.hackathon --platforms android safechat_app

rm -f safechat_app/test/widget_test.dart
rm -rf safechat_app/lib
cp -r src/lib safechat_app/lib
cp -r src/test/* safechat_app/test/
cp src/pubspec.yaml safechat_app/pubspec.yaml

# Let url_launcher open the SMS app on Android 11+
MANIFEST=safechat_app/android/app/src/main/AndroidManifest.xml
sed -i 's|<application|<queries><intent><action android:name="android.intent.action.VIEW"/><data android:scheme="sms"/></intent></queries>\n    <application|' "$MANIFEST"

cd safechat_app
flutter pub get
flutter test
echo ""
echo "Setup done. Next: cd safechat_app && flutter run"
