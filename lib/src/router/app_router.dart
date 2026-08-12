import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/logs/presentation/logs_list_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/typography/presentation/khmer_fonts_screen.dart';
import '../features/typography/presentation/khmer_typography_screen.dart';
import '../features/profile/presentation/profile_screen.dart';

/// The global router for FieldLog.
///
/// Week 2: declarative routing with [go_router]. We never use
/// `Navigator.push` directly in this course — it scales poorly and bypasses
/// our central place to express navigation intent. All routes are declared
/// here.
///
/// In Week 11, this router gains a `redirect:` callback that enforces auth.
class AppRouter {
  AppRouter._();

  static const onboardingPath = '/';
  static const profilePath = '/profile/:name';
  static const logsPath = '/logs';
  static const typographyPath = '/typography';
  static const fontsPath = '/fonts';

  static String profilePathFor(String name) => '/profile/$name';

  /// Where the app opens. Overridable at build time so a screenshot script can
  /// land straight on the screen it wants:
  ///
  ///     flutter build apk --dart-define=INITIAL_ROUTE=/logs
  ///
  /// Never read at runtime from anything a user controls — this is a compile
  /// time constant, and it defaults to the real entry point.
  static const initialRoute = String.fromEnvironment(
    'INITIAL_ROUTE',
    defaultValue: onboardingPath,
  );

  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: onboardingPath,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: profilePath,
        name: 'profile',
        builder: (context, state) {
          final name = state.pathParameters['name'] ?? 'friend';
          return ProfileScreen(name: name);
        },
      ),
      GoRoute(
        path: logsPath,
        name: 'logs',
        builder: (context, state) => const LogsListScreen(),
      ),
      GoRoute(
        path: typographyPath,
        name: 'typography',
        builder: (context, state) => const KhmerTypographyScreen(),
      ),
      GoRoute(
        path: fontsPath,
        name: 'fonts',
        builder: (context, state) => const KhmerFontsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri}'),
      ),
    ),
  );
}
