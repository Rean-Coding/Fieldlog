package com.aeu.fieldlog.shared

import android.os.Build

actual class Platform actual constructor() {
    actual val name: String = "Android ${Build.VERSION.SDK_INT}"
}

actual fun deviceInfoString(): String = "${Build.MANUFACTURER} ${Build.MODEL}"

actual fun currentTimeMillis(): Long = System.currentTimeMillis()
