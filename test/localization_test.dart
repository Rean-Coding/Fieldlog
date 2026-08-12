import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fieldlog_i18n/l10n/generated/app_localizations.dart';
import 'package:fieldlog_i18n/src/l10n/locale_controller.dart';

/// No test can tell you a translation is *good*. These check the things that
/// can be checked — that a locale resolves at all, and that a string was
/// actually translated rather than copied.
void main() {
  Future<AppLocalizations> localizationsFor(
    WidgetTester tester,
    Locale locale,
  ) async {
    late AppLocalizations l10n;
    await tester.pumpWidget(
      MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            l10n = AppLocalizations.of(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    return l10n;
  }

  testWidgets('every supported locale resolves', (tester) async {
    for (final locale in supportedLocales) {
      final l10n = await localizationsFor(tester, locale);
      expect(l10n.logsTitle, isNotEmpty, reason: '$locale');
      expect(l10n.emptyTitle, isNotEmpty, reason: '$locale');
      expect(l10n.retry, isNotEmpty, reason: '$locale');
    }
  });

  testWidgets('supportedLocales matches what gen_l10n produced', (tester) async {
    // These two lists are written in different files and drift apart the day
    // someone adds a locale to only one of them.
    expect(
      supportedLocales.map((l) => l.languageCode).toSet(),
      AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet(),
    );
  });

  testWidgets('Khmer strings are translated, not copied', (tester) async {
    final en = await localizationsFor(tester, const Locale('en'));
    final km = await localizationsFor(tester, const Locale('km'));

    // A key left out of app_km.arb silently falls back to English. That is a
    // reasonable runtime behaviour and a terrible thing to ship unnoticed.
    expect(km.logsTitle, isNot(en.logsTitle));
    expect(km.emptyTitle, isNot(en.emptyTitle));
    expect(km.retry, isNot(en.retry));

    // appTitle is a product name and is deliberately identical in both.
    expect(km.appTitle, en.appTitle);
  });

  testWidgets('an unsupported locale falls back rather than crashing',
      (tester) async {
    final l10n = await localizationsFor(tester, const Locale('fr'));
    expect(l10n.logsTitle, isNotEmpty);
  });
}
