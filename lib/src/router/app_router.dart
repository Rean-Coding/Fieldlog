import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/application/auth_providers.dart';
import '../features/auth/presentation/sign_in_screen.dart';
import '../features/logs/presentation/logs_list_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/profile/presentation/profile_screen.dart';

/// Week 11: the router gains a `redirect:` callback that enforces auth.
/// Routes marked private redirect to /sign-in when the user is not
/// signed in. The sign-in route redirects to /logs when the user is
/// already signed in.
GoRouter buildRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final signedIn = ref.read(authNotifierProvider);
      final isAuthPage = state.matchedLocation == '/sign-in';
      final isPrivate = state.matchedLocation.startsWith('/logs') ||
          state.matchedLocation.startsWith('/profile');
      if (!signedIn && isPrivate) return '/sign-in';
      if (signedIn && isAuthPage) return '/logs';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: '/sign-in', builder: (_, __) => const SignInScreen()),
      GoRoute(
        path: '/profile/:name',
        builder: (_, s) => ProfileScreen(name: s.pathParameters['name'] ?? 'friend'),
      ),
      GoRoute(path: '/logs', builder: (_, __) => const LogsListScreen()),
    ],
  );
}

/// The router reads auth state, so it is built inside a provider
/// rather than as a top-level final — otherwise it would capture a
/// Ref that does not exist yet.
final appRouterProvider = Provider<GoRouter>((ref) => buildRouter(ref));
