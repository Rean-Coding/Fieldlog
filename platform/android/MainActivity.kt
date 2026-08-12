package com.aeu.fieldlog

import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // ─── DEVICE CHANNEL ────────────────────────────────────
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.aeu.fieldlog/device")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getDeviceInfo" -> result.success(getDeviceInfo())
                    else -> result.notImplemented()
                }
            }

        // ─── BIOMETRICS CHANNEL ────────────────────────────────
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.aeu.fieldlog/biometrics")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "authenticate" -> {
                        val reason = call.argument<String>("reason") ?: "Confirm your identity"
                        authenticate(reason, result)
                    }
                    else -> result.notImplemented()
                }
            }

        // ─── KHQR CHANNEL ──────────────────────────────────────
        // In production, this would integrate with the official Bakong KHQR SDK
        // or use a generic QR scanner constrained to KHQR format.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.aeu.fieldlog/khqr")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "scan" -> {
                        // Stub: in production, launch a scanner Activity for result.
                        result.success("00020101021229370016A000000677010111011300011234567890520411115303116540510.005802KH5908FIELDLOG6304ABCD")
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun getDeviceInfo(): Map<String, Any> {
        val bm = getSystemService(BATTERY_SERVICE) as BatteryManager
        val level = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        return mapOf(
            "batteryLevel" to level,
            "isCharging" to bm.isCharging,
            "deviceModel" to "${Build.MANUFACTURER} ${Build.MODEL}",
            "osVersion" to "Android ${Build.VERSION.RELEASE}"
        )
    }

    private fun authenticate(reason: String, result: MethodChannel.Result) {
        val prompt = BiometricPrompt(
            this,
            ContextCompat.getMainExecutor(this),
            object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationSucceeded(r: BiometricPrompt.AuthenticationResult) =
                    result.success(true)
                override fun onAuthenticationFailed() =
                    result.success(false)
                override fun onAuthenticationError(code: Int, msg: CharSequence) {
                    val errCode = when (code) {
                        BiometricPrompt.ERROR_USER_CANCELED,
                        BiometricPrompt.ERROR_NEGATIVE_BUTTON -> "USER_CANCELLED"
                        BiometricPrompt.ERROR_HW_NOT_PRESENT,
                        BiometricPrompt.ERROR_NO_BIOMETRICS -> "NOT_AVAILABLE"
                        else -> "ERROR_$code"
                    }
                    result.error(errCode, msg.toString(), null)
                }
            }
        )
        val info = BiometricPrompt.PromptInfo.Builder()
            .setTitle("FieldLog")
            .setSubtitle(reason)
            .setNegativeButtonText("Cancel")
            .build()
        prompt.authenticate(info)
    }
}
