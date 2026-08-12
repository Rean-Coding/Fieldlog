import '../../logs/domain/result.dart';
import 'device_info.dart';

/// Abstract contract for platform-native features.
///
/// W14 architectural insight: the platform channel is the Adapter pattern.
/// Native code returns whatever it likes; the Adapter (concrete repository)
/// translates to our domain types. The Service never imports MethodChannel.
abstract class NativeFeaturesRepository {
  Future<Result<DeviceInfo>> getDeviceInfo();
  Future<Result<bool>> authenticateWithBiometrics({required String reason});
  Future<Result<String>> scanKhqrCode();
}
