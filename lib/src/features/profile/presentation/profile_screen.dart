import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../application/profile_providers.dart';

/// Profile screen — Week 4 refactor.
///
/// Was a StatefulWidget that manually constructed a Service. Now it is a
/// ConsumerStatefulWidget that reads the [profileNotifierProvider] for state
/// and calls the notifier for actions. The Service and Repository are
/// invisible to this file — that's the whole point of Riverpod DI.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key, required this.name});

  final String name;

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _saving = false;

  Future<void> _enrol() async {
    setState(() => _saving = true);
    await ref.read(profileNotifierProvider.notifier).enrol(
          id: widget.name.toLowerCase(),
          name: widget.name,
        );
    if (!mounted) return;
    setState(() => _saving = false);
    final profile = ref.read(profileNotifierProvider);
    if (profile != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enrolled ${profile.name} as ${profile.role}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ref.watch — subscribe; rebuild when state changes.
    final profile = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(
                  widget.name.isNotEmpty ? widget.name[0].toUpperCase() : '?',
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('Hello, ${widget.name}!', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              if (profile != null)
                Text(
                  'Enrolled as ${profile.role}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _saving ? null : _enrol,
                child: Text(_saving ? 'Saving…' : 'Enrol me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
