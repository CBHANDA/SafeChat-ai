# 2-minute demo script

Setup: release APK installed, phone charged, app opened once, trusted number
already saved, notifications silenced, screen brightness up. Keep a screen
recording of the whole flow as a backup.

| Time | You do | You say |
|------|--------|---------|
| 0:00 | Show Home | "SafeChat helps a child check a chat they're unsure about. It runs on this phone. Nothing is sent anywhere." |
| 0:15 | Check a chat > Grooming example > Check this chat | "A stranger asks how old she is, moves her to WhatsApp, asks for a photo, and tells her to keep it secret." |
| 0:35 | Point at the red result and highlights | "High risk. These highlighted phrases are exactly why. It gives the child calm advice. She is not in trouble." |
| 0:55 | Tell a trusted adult > show the preview | "The parent gets a summary of the patterns, not the child's messages. The child stays in control and sends it herself." |
| 1:15 | Back > Bullying example | "It also catches cyberbullying. Medium risk, with advice." |
| 1:30 | Back > Safe example | "A normal chat stays green. We don't want to cry wolf." |
| 1:45 | Show airplane mode on | "Airplane mode has been on the whole time. Everything you saw ran on the phone." |
| 2:00 | Close | "Private child safety, built for Uganda, ready to grow into Luganda and Swahili." |

## Likely judge questions

**How do we know it is really on-device?** Airplane mode, and the release app
has no internet permission. The detector is plain code in `grooming_detector.dart`.

**False positives?** Yes, it can happen. It only sees the pasted chat, so a classmate
saying "let's meet" may be flagged. The child sees the highlighted reason and decides.
Next step is adding conversation context and a trained model.

**Where is the AI?** The current version is a rules engine that scores the whole
conversation, with a hook for a small on-device ML model. Say this plainly; don't
call the rules a trained model.

**Which languages?** English now, with a starter set of Swahili and Luganda
phrases awaiting native-speaker review.

**Is this parental spyware?** No. The child chooses to check a chat and chooses to
send the alert. The parent sees only a pattern summary.

**Accuracy?** We have not yet measured it on labelled data. That is the next milestone.
