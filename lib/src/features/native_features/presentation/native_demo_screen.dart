import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/native_features_providers.dart';
import '../domain/device_info.dart';

class NativeDemoScreen extends ConsumerStatefulWidget {
  const NativeDemoScreen({super.key});
  @override
  ConsumerState<NativeDemoScreen> createState() => _NativeDemoScreenState();
}

class _NativeDemoScreenState extends ConsumerState<NativeDemoScreen> {
  DeviceInfo? _info;
  String? _khqr;
  bool? _bioOk;
  String? _error;

  Future<void> _loadDevice() async {
    final r = await ref.read(nativeFeaturesRepositoryProvider).getDeviceInfo();
    setState(() {
      r.map((value) {
        _info = value;
        _error = null;
        return null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Native demos')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton(onPressed: _loadDevice, child: const Text('Read device info')),
          if (_info != null) ...[
            const SizedBox(height: 12),
            Card(child: ListTile(
              title: Text(_info!.deviceModel),
              subtitle: Text('${_info!.osVersion} · ${_info!.batteryLevel}%'),
              trailing: Icon(_info!.isCharging ? Icons.battery_charging_full : Icons.battery_full),
            )),
          ],
          const SizedBox(height: 24),
          FilledButton(onPressed: () async {
            final r = await ref.read(nativeFeaturesRepositoryProvider)
                .authenticateWithBiometrics(reason: 'Unlock FieldLog');
            setState(() => r.map((v) { _bioOk = v; return null; }));
          }, child: const Text('Biometric unlock')),
          if (_bioOk != null) Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(_bioOk! ? '✓ Authenticated' : '✗ Failed'),
          ),
          const SizedBox(height: 24),
          FilledButton(onPressed: () async {
            final r = await ref.read(nativeFeaturesRepositoryProvider).scanKhqrCode();
            setState(() => r.map((v) { _khqr = v; return null; }));
          }, child: const Text('Scan KHQR')),
          if (_khqr != null) Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SelectableText(_khqr!),
          ),
        ],
      ),
    );
  }
}
