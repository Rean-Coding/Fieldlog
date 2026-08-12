# FieldLog KMP — Week 15 Sample (E15.1)

The capstone supplementary project for **Cross-Platform Mobile Application Development**
Master's in IT Engineering · Asia Euro University
Lecturer: **Mr. Sok Pongsametrey** · metreysk@gmail.com · https://pongsametrey.com

## What this is

A **separate** Kotlin Multiplatform project that mirrors FieldLog's domain
and application layers. The Flutter FieldLog project is unchanged this week
— this KMP project sits alongside it to demonstrate the patterns.

```
fieldlog_kmp/
├── shared/                              ← the shared Kotlin module
│   ├── src/
│   │   ├── commonMain/                  ← runs on every platform
│   │   │   └── kotlin/com/aeu/fieldlog/shared/
│   │   │       ├── LogEntry.kt          ← @Serializable data class
│   │   │       ├── Result.kt            ← Sealed Result + Failure
│   │   │       ├── LogsService.kt       ← Same Six Rules
│   │   │       └── Platform.kt          ← expect declarations
│   │   ├── androidMain/                 ← actual: Build.VERSION.SDK_INT
│   │   │   └── kotlin/.../Platform.android.kt
│   │   └── iosMain/                     ← actual: UIDevice.currentDevice
│   │       └── kotlin/.../Platform.ios.kt
│   └── build.gradle.kts                 ← targets: androidTarget + 3 iOS variants
└── androidApp/
    └── src/main/kotlin/MainActivity.kt  ← Compose UI consuming the shared module
```

## The big idea

In Flutter we share the entire app — UI and logic — across Android and iOS.

In KMP we share only the **logic** (domain + application + data layers), and
each platform keeps its native UI. Android uses Compose; iOS uses SwiftUI;
the web uses Compose for Web. The shared Kotlin code lives in `shared/`.

This makes KMP the right choice when:
- You already have substantial native UI code on one platform
- You want maximum UI parity with platform conventions
- Your domain logic is complex but your UI is simple

Flutter is the right choice when:
- You're building from scratch
- Brand-consistent UI across platforms matters more than platform-native feel
- A single team owns the whole product

## expect / actual

The Kotlin equivalent of Flutter's platform channels. Declared in `commonMain`,
implemented per-platform.

```kotlin
// commonMain/Platform.kt
expect class Platform() {
    val name: String
}

// androidMain/Platform.android.kt
actual class Platform actual constructor() {
    actual val name: String = "Android ${Build.VERSION.SDK_INT}"
}

// iosMain/Platform.ios.kt
actual class Platform actual constructor() {
    actual val name: String = "${UIDevice.currentDevice.systemName()} ..."
}
```

Compare to Flutter's MethodChannel from W14: KMP makes the platform split
a compile-time concept, not a runtime IPC.

## Compose Multiplatform — beyond Android

`androidApp/` uses Jetpack Compose. The same Compose code (with minor
adjustments) can target iOS, desktop, and the web via Compose Multiplatform.

The 2025 announcement that Compose Multiplatform reached 1.0 stable on iOS
makes this story finally credible for production.

## Running it

You need:
- Android Studio Hedgehog or newer with the KMP plugin
- For iOS: Xcode (not available in our lab — taught conceptually)

```bash
./gradlew :shared:assembleDebug         # build the shared library
./gradlew :androidApp:installDebug      # install the Android consumer
```

## Compared to the Flutter sample

| **Concept** | **Flutter (Dart)** | **KMP (Kotlin)** |
| --- | --- | --- |
| Sealed union | `sealed class Failure` | `sealed class Failure` |
| Data class | hand-rolled with `==`/`hashCode` | `data class` (auto-generated) |
| Async fn | `async`/`await` + `Future<T>` | `suspend` + coroutines |
| Stream | `Stream<T>` | `Flow<T>` |
| Null safety | `?` operator | `?` operator |
| Platform code | `MethodChannel` runtime IPC | `expect`/`actual` compile-time |

## AI Notes

Claude generated the initial `build.gradle.kts` skeleton. The hierarchical
source set (intermediate `iosMain`) was Claude's correction after the
straightforward "three independent iOS targets" version failed to share code.
