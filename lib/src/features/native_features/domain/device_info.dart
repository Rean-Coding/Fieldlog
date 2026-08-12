/// Domain entity for device metadata returned by native code.
///
/// The Dart side never sees Android's `BatteryManager` or `Build` classes
/// directly. The platform channel returns a plain Map; we map it to this
/// domain entity at the boundary — same Data Mapper pattern as W10.
class DeviceInfo {
  const DeviceInfo({
    required this.batteryLevel,
    required this.isCharging,
    required this.deviceModel,
    required this.osVersion,
  });

  final int batteryLevel;
  final bool isCharging;
  final String deviceModel;
  final String osVersion;
}
