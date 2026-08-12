// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get appTitle => 'FieldLog';

  @override
  String get logsTitle => 'កំណត់ត្រា';

  @override
  String get refresh => 'ផ្ទុកឡើងវិញ';

  @override
  String get addSample => 'បន្ថែមគំរូ';

  @override
  String get emptyTitle => 'មិនទាន់មានកំណត់ត្រា';

  @override
  String emptyBody(String action) {
    return 'ចុច «$action» ខាងក្រោម ដើម្បីបង្កើតកំណត់ត្រាដំបូង។';
  }

  @override
  String get errorTitle => 'មិនអាចផ្ទុកកំណត់ត្រាបានទេ';

  @override
  String get retry => 'ព្យាយាមម្ដងទៀត';

  @override
  String entryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'កំណត់ត្រា $count',
      zero: 'គ្មានកំណត់ត្រា',
    );
    return '$_temp0';
  }

  @override
  String savedAt(DateTime when) {
    final intl.DateFormat whenDateFormat = intl.DateFormat.yMMMd(localeName);
    final String whenString = whenDateFormat.format(when);

    return 'រក្សាទុក $whenString';
  }

  @override
  String get language => 'ភាសា';

  @override
  String get quickNote => 'កំណត់ត្រារហ័ស';

  @override
  String get demoCategory => 'គំរូ';
}
