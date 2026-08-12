# FieldLog

The sample application for **Flutter in the AI Era** by Sok Pongsametrey — full title
*Cross-Platform Mobile App Development with Flutter in the AI Era: Project-Based
Learning from Concept to a Proper Working App*.

FieldLog records notes in the field — a farm, a construction site, an inspection
route — where the network is unreliable and the phone is the only computer
present. That constraint is what forces every interesting problem in mobile
development to the surface.

## Run it

This repository holds Dart source and configuration only. The platform folders
are generated, because `android/` is large, machine-specific and regenerable:

```bash
git clone https://github.com/Rean-Coding/Fieldlog.git fieldlog_flutter
cd fieldlog_flutter
flutter create . --project-name fieldlog_flutter
flutter pub get
flutter run
```

You need the Flutter SDK (stable) and an Android emulator or a phone with USB
debugging enabled. Chapter 0 of the book walks through the whole setup,
including how to read `flutter doctor` and what to do when it complains.

## One tag per chapter

Check out the code exactly as any chapter leaves it:

```bash
git checkout ch07     # the app at the end of Chapter 7
git checkout main     # the finished app
```

| Tag | Chapter | What it adds |
|---|---|---|
| `ch01` | 1 | initialise FieldLog — project structure and first screen |
| `ch02` | 2 | add go_router, Material 3 theming and the profile route |
| `ch03` | 3 | split the profile feature into four layers |
| `ch04` | 4 | replace manual wiring with Riverpod providers |
| `ch05` | 5 | AsyncNotifier and the four async states |
| `ch05b` | 5b | Khmer localisation and khmer_text |
| `ch06` | 6 | sealed failures and Result instead of throwing |
| `ch07` | 7 | swap the fake repository for Drift |
| `ch08` | 8 | mid-term checkpoint |
| `ch09` | 9 | offline-first writes with a sync queue |
| `ch10` | 10 | networking with Dio and retrofit |
| `ch11` | 11 | auth, token refresh and route guards |
| `ch12` | 12 | the testing pyramid |
| `ch13` | 13 | CI workflow and release configuration |
| `ch14` | 14 | platform channels into Android |
| `ch15` | 15 | Kotlin Multiplatform comparison |
| `ch16` | 16 | the finished app |

Use these to check your own work, or to rejoin after falling behind — you never
have to abandon the project because one week went badly.

**`ch05b` is a variant, not a step.** Chapter 5b localises the week-5 app into
Khmer and English; the weeks after it continue from week 5's English codebase,
so checking out `ch06` will not show the localisation. That is deliberate — the
chapter teaches internationalisation on a small app rather than threading it
through every later week. `packages/khmer_text` does carry forward, and is also
published on its own.

## Generated code is committed

`*.g.dart` files from `build_runner` are committed on purpose, so that every tag
runs with `flutter pub get && flutter run` and nothing else. After you change an
annotated file, regenerate them:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## AI Notes

Every exercise in the course is submitted with an AI Notes section, in this
format. It is graded for thoughtfulness, not length.

```markdown
## AI Notes

**Prompted**: "Flutter 3.35 with go_router ^14.6 — write a router with two
routes, '/' and '/profile/:name', including an errorBuilder."

**Given**: A working router, but using the pre-v6 pageBuilder signature and no
errorBuilder.

**Changed**: Replaced pageBuilder with builder after checking the go_router
changelog on pub.dev; added the errorBuilder; extracted the path into
AppRouter.profilePathFor so no call site writes the literal.
```

The rule behind it: **disclose, verify, stay current.** If you cannot explain a
line you committed, it is not yours yet.

## Licence

MIT — see [LICENSE](LICENSE). Use it freely, including in commercial work.
