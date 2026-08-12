import 'package:flutter/material.dart';

/// The first screen a user sees.
///
/// Week 1 (E01.1): a stateless welcome screen with a single call-to-action.
/// It is a [StatelessWidget] on purpose — there is no state to manage yet.
/// In Week 2 this screen gains a real route to a profile page via go_router.
///
/// Notice what this file does NOT do: it does not talk to a database, call an
/// API, or hold business logic. Those responsibilities arrive in later weeks
/// and live in the data/domain/application layers — never in presentation.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'FieldLog',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'A simple log you can take anywhere.',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () => _onGetStarted(context),
                child: const Text('Get started'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onGetStarted(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Welcome to FieldLog!')),
    );
  }
}
