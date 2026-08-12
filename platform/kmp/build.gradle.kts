// Versions are declared once here and applied without a version in each module.
// Kotlin, the Android plugin and the Compose compiler have to agree; since
// Kotlin 2.0 the Compose compiler ships as a Kotlin plugin and must carry the
// same version as Kotlin itself.
plugins {
    id("com.android.application") version "8.7.3" apply false
    id("com.android.library") version "8.7.3" apply false
    kotlin("multiplatform") version "2.1.0" apply false
    kotlin("android") version "2.1.0" apply false
    kotlin("plugin.serialization") version "2.1.0" apply false
    id("org.jetbrains.kotlin.plugin.compose") version "2.1.0" apply false
}
