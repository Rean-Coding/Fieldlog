import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../application/profile_service.dart';
import '../data/fake_profile_repository.dart';

/// Profile screen — Week 3 refactor.
///
/// This screen now consumes the [ProfileService] only — it does NOT touch
/// the repository directly. Week 4 replaces the manual service instantiation
/// here with a Riverpod provider so dependency injection is centralised.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.name});

  final String name;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // NOTE — manual wiring this week; in W4 Riverpod replaces this.
  late final ProfileService _service = ProfileService(FakeProfileRepository());

  bool _saving = false;
  String? _savedRole;

  Future<void> _enrol() async {
    setState(() => _saving = true);
    final profile = await _service.enrol(
      id: widget.name.toLowerCase(),
      name: widget.name,
    );
    if (!mounted) return;
    setState(() {
      _saving = false;
      _savedRole = profile.role;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Enrolled ${profile.name} as ${profile.role}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              if (_savedRole != null)
                Text('Enrolled as $_savedRole', style: theme.textTheme.bodyLarge),
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
