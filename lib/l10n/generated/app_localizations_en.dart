// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FieldLog';

  @override
  String get logsTitle => 'Logs';

  @override
  String get refresh => 'Refresh';

  @override
  String get addSample => 'Add sample';

  @override
  String get emptyTitle => 'No logs yet';

  @override
  String emptyBody(String action) {
    return 'Tap \"$action\" below to create your first log.';
  }

  @override
  String get errorTitle => 'Could not load logs';

  @override
  String get retry => 'Retry';

  @override
  String entryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entries',
      one: '1 entry',
      zero: 'No entries',
    );
    return '$_temp0';
  }

  @override
  String savedAt(DateTime when) {
    final intl.DateFormat whenDateFormat = intl.DateFormat.yMMMd(localeName);
    final String whenString = whenDateFormat.format(when);

    return 'Saved $whenString';
  }

  @override
  String get language => 'Language';

  @override
  String get quickNote => 'Quick note';

  @override
  String get demoCategory => 'demo';
}
