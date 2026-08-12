import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khmer_text/khmer_text.dart';

import '../l10n/generated/app_localizations.dart';
import 'l10n/locale_controller.dart';
import 'router/app_router.dart';

class FieldLogApp extends ConsumerWidget {
  const FieldLogApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeControllerProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,

      // Null means "follow the device". Flutter then picks the best match from
      // supportedLocales, falling back to the first entry.
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        // These three translate the widgets Flutter itself owns — the date
        // picker, the text-selection menu, the "Cancel" in a dialog. Without
        // them a Khmer app still shows English there. Flutter ships Khmer for
        // all three.
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: _theme(Brightness.light, locale),
      darkTheme: _theme(Brightness.dark, locale),
      routerConfig: AppRouter.router,
    );
  }

  ThemeData _theme(Brightness brightness, Locale? locale) {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0F766E),
        brightness: brightness,
      ),
    );

    // Khmer stacks marks above and below the base letter, so a line height
    // tuned for Latin clips them. Raising it here means no screen has to
    // remember — and applying it per-locale means English is not given
    // needlessly airy text.
    final isKhmer = locale?.languageCode == 'km';
    return isKhmer
        ? base.copyWith(textTheme: base.textTheme.khmerSafe())
        : base;
  }
}
