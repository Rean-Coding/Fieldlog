import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/onboarding/presentation/onboarding_screen.dart';
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

  static String profilePathFor(String name) => '/profile/$name';

  static final GoRouter router = GoRouter(
    initialLocation: onboardingPath,
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
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri}'),
      ),
    ),
  );
}
