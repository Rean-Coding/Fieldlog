import 'package:flutter/material.dart';

import 'features/onboarding/presentation/onboarding_screen.dart';

/// The root widget of FieldLog.
///
/// Holds app-wide configuration ONLY: title, theme, and the first route.
/// No business logic lives here — that belongs in feature folders under
/// `lib/src/features/<feature>/`.
///
/// In Week 2 the `home:` below is replaced by a `go_router` configuration.
class FieldLogApp extends StatelessWidget {
  const FieldLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FieldLog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E), // AEU teal seed
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}
