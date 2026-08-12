import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The locale the user chose, or null to follow the device.
///
/// Null is the right default and not the same as "English". A phone set to
/// Khmer should open in Khmer without the user asking, and only an explicit
/// choice should override the system — the same "unknown is a third state"
/// discipline the auth chapter applies to sign-in.
///
/// In a shipping app this is persisted, so the choice survives a restart.
final localeControllerProvider =
    NotifierProvider<LocaleController, Locale?>(LocaleController.new);

class LocaleController extends Notifier<Locale?> {
  @override
  Locale? build() => null;

  void use(Locale? locale) => state = locale;

  void toggle() {
    final current = state ?? _deviceLocale;
    state = current.languageCode == 'km'
        ? const Locale('en')
        : const Locale('km');
  }

  Locale get _deviceLocale {
    final device = WidgetsBinding.instance.platformDispatcher.locale;
    return supportedLocales.any((l) => l.languageCode == device.languageCode)
        ? device
        : supportedLocales.first;
  }
}

/// Declared once and used by both `MaterialApp` and the controller, so the two
/// cannot disagree about what the app supports.
const supportedLocales = <Locale>[
  Locale('en'),
  Locale('km'),
];
