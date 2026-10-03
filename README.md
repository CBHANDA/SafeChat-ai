# SafeChat AI

A private, on-device warning tool for children. Paste a chat, get a risk level
(Low / Medium / High), see the exact phrases that triggered it, and send a
privacy-safe summary (no chat text) to a trusted adult by SMS.
Built for the UCC Hackathon: "Innovating safe cyber spaces for children through AI".

```
safechat-ai/
  README.md        <- you are here
  DEMO_SCRIPT.md   <- 2-minute presentation flow + judge Q&A
  setup.sh         <- Linux/macOS: builds the Flutter project
  setup.ps1        <- Windows: builds the Flutter project
  src/             <- the app source (lib/, test/, pubspec.yaml)
```

## 1. Install what you need (one time)

1. Install the Flutter SDK: https://docs.flutter.dev/get-started/install
   (choose your OS, target Android). Install Android Studio when it asks,
   because it provides the Android SDK.
2. Run `flutter doctor`. Fix anything marked with a red X. If it complains
   about licenses, run `flutter doctor --android-licenses` and accept all.
3. On your Android phone: Settings > About phone > tap "Build number" 7 times,
   then Settings > Developer options > turn on **USB debugging**.

## 2. Build the project

Unzip this folder, open a terminal inside it, then run ONE of these:

Linux / macOS:
```
chmod +x setup.sh
./setup.sh
```

Windows (PowerShell):
```
powershell -ExecutionPolicy Bypass -File setup.ps1
```

This creates a `safechat_app/` folder (the real Flutter project), copies the
source in, patches the Android manifest, installs packages and runs the tests.

## 3. Test it

```
cd safechat_app
flutter test
```

You should see `All tests passed!`. The 5 tests check that:
- the grooming demo chat is High risk
- the bullying demo is Medium
- the safe demo is Low
- a Swahili example is flagged
- the parent summary never contains chat text

## 4. Run it on your phone

Plug the phone in by USB, accept the "Allow USB debugging" prompt, then:

```
flutter devices        # your phone should be listed
flutter run
```

No phone? Use an emulator from Android Studio (Device Manager). Note that
emulators often have no SMS app, so the "Open messages" step may do nothing there.

## 5. Try it by hand

1. Tap **Check a chat**, then the **Grooming example** chip, then **Check this chat**.
   Expect: "Warning signs" (red), highlighted phrases, "Tell a trusted adult" button.
2. Tap **Tell a trusted adult**, enter a phone number, and check the preview.
   It must contain no chat text. Tap **Open messages** to see the prefilled SMS.
3. Go back and try **Bullying example** (expect "Be careful", amber) and
   **Safe example** (expect "Looks okay", green, no highlights).
4. Paste your own text, one message per line.

## 6. Build the demo APK (for the presentation)

```
flutter build apk --release
```
The file is `build/app/outputs/flutter-apk/app-release.apk`. Install it with
`adb install -r build/app/outputs/flutter-apk/app-release.apk`, or copy it to
the phone and open it.

Use the release build for the privacy proof. Debug builds add an internet
permission automatically (for hot reload); the release build has none.
Then switch on airplane mode and run the demo.

## 7. Troubleshooting

- `flutter: command not found`: add Flutter's `bin` folder to your PATH, reopen the terminal.
- Phone not listed in `flutter devices`: re-plug, re-accept the USB prompt, try another cable.
- "Open messages" does nothing: the device has no SMS app (common on emulators). Test on a real phone.
- Test fails after you edit rules: the demo chats in `src/lib/data/demo_chats.dart`
  and the expectations in `src/test/grooming_detector_test.dart` must still agree.
- Anything else: copy the full error text and send it to Claude.

## 8. Where to improve it

- `src/lib/services/grooming_detector.dart`: all rules, weights and thresholds.
  Add or tune phrases here. Have a native speaker review the Luganda/Swahili lines.
- A small TFLite classifier can plug into the `mlScore` hook later.

## Known limits (be upfront about these)

- It is rule-based and only sees the pasted chat. "Can we meet at school?" from
  a classmate looks like a meeting request.
- Not measured on a labelled dataset, so quote no accuracy numbers.
- The child must paste the chat. There is no automatic message monitoring.
