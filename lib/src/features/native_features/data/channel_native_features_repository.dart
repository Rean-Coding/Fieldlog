import 'package:flutter/services.dart';

import '../../logs/domain/failure.dart';
import '../../logs/domain/result.dart';
import '../domain/device_info.dart';
import '../domain/native_features_repository.dart';

/// MethodChannel-backed implementation of NativeFeaturesRepository.
///
/// Channel name convention: `com.aeu.fieldlog/<feature>`. All platform-side
/// errors are translated to domain `Failure` variants here — the Service
/// never sees a `PlatformException`.
class ChannelNativeFeaturesRepository implements NativeFeaturesRepository {
  static const _deviceChannel = MethodChannel('com.aeu.fieldlog/device');
  static const _bioChannel = MethodChannel('com.aeu.fieldlog/biometrics');
  static const _khqrChannel = MethodChannel('com.aeu.fieldlog/khqr');

  @override
  Future<Result<DeviceInfo>> getDeviceInfo() async {
    try {
      final raw = await _deviceChannel.invokeMethod<Map<dynamic, dynamic>>('getDeviceInfo');
      if (raw == null) return const Failed(UnknownFailure(message: 'No device info'));
      return Success(DeviceInfo(
        batteryLevel: raw['batteryLevel'] as int,
        isCharging: raw['isCharging'] as bool,
        deviceModel: raw['deviceModel'] as String,
        osVersion: raw['osVersion'] as String,
      ));
    } on PlatformException catch (e) {
      return Failed(_mapPlatformException(e));
    }
  }

  @override
  Future<Result<bool>> authenticateWithBiometrics({required String reason}) async {
    try {
      final ok = await _bioChannel.invokeMethod<bool>('authenticate', {'reason': reason});
      return Success(ok ?? false);
    } on PlatformException catch (e) {
      if (e.code == 'NOT_AVAILABLE') {
        return const Failed(UnknownFailure(message: 'Biometrics not available on this device'));
      }
      if (e.code == 'USER_CANCELLED') {
        return const Failed(UnknownFailure(message: 'Authentication cancelled'));
      }
      return Failed(_mapPlatformException(e));
    }
  }

  @override
  Future<Result<String>> scanKhqrCode() async {
    try {
      final payload = await _khqrChannel.invokeMethod<String>('scan');
      if (payload == null || payload.isEmpty) {
        return const Failed(UnknownFailure(message: 'No QR code detected'));
      }
      return Success(payload);
    } on PlatformException catch (e) {
      return Failed(_mapPlatformException(e));
    }
  }

  Failure _mapPlatformException(PlatformException e) {
    return UnknownFailure(message: e.message ?? 'Platform error: ${e.code}');
  }
}
