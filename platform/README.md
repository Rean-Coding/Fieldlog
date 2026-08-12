# platform/

Native sources that `flutter create .` does not generate, kept out of
`android/` so that regenerating the platform folders cannot overwrite them.

## android/MainActivity.kt — Chapter 14

The `MethodChannel` handler. After `flutter create .`, copy it over the
generated activity:

```bash
cp platform/android/MainActivity.kt \
   android/app/src/main/kotlin/com/aeu/fieldlog/MainActivity.kt
```

Check that the `package` line matches the applicationId in
`android/app/build.gradle`, then fully restart the app — hot reload does not
reload Kotlin.

## kmp/ — Chapter 15

The Kotlin Multiplatform comparison: `expect`/`actual`, and FieldLog's `Result`
and `LogEntry` written in Kotlin.

It is a complete Gradle project, not a snippet. From `platform/kmp`:

```bash
./gradlew :androidApp:installDebug
```

The iOS targets need Xcode and so only build on macOS; the Kotlin plugin skips
them elsewhere, which is why the Android app still assembles on Windows and
Linux. `:shared:build` compiles the common and Android source sets alone if you
only want to run the shared tests.
