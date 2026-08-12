import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/logs_providers.dart';
import '../domain/failure.dart';
import '../domain/log_entry.dart';

/// Logs list screen — Week 6 version.
///
/// Same four-state structure as W5. The new piece: the error state now
/// pattern-matches on the [Failure] variant to give a typed UI per failure,
/// not just a stringified exception message.
class LogsListScreen extends ConsumerWidget {
  const LogsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(logsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(logsNotifierProvider),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(logsNotifierProvider),
        child: state.when(
          loading: () => const _LoadingState(),
          error: (e, _) => _ErrorState(
            failure: e is Failure ? e : UnknownFailure(message: e.toString()),
            onRetry: () => ref.invalidate(logsNotifierProvider),
          ),
          data: (entries) => entries.isEmpty
              ? const _EmptyState()
              : _DataState(entries: entries),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ref.read(logsNotifierProvider.notifier).addEntry(
              title: 'Quick note',
              body: 'Added at ${DateTime.now()}',
              category: 'demo',
            ),
        icon: const Icon(Icons.add),
        label: const Text('Add sample'),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      children: [
        const SizedBox(height: 120),
        Icon(Icons.notes_outlined, size: 72, color: theme.colorScheme.outline),
        const SizedBox(height: 16),
        Text('No logs yet',
            style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(
          'Tap "Add sample" below to create your first log.',
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.outline),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Typed error state — different UI per Failure variant.
class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.failure, required this.onRetry});

  final Failure failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Exhaustive switch — compiler complains if a variant is missed.
    final (icon, title) = switch (failure) {
      NetworkFailure() => (Icons.wifi_off, 'Network unavailable'),
      NotFoundFailure() => (Icons.search_off, 'Not found'),
      UnauthorizedFailure() => (Icons.lock_outline, 'Please sign in'),
      UnknownFailure() => (Icons.error_outline, 'Something went wrong'),
    };

    return ListView(
      padding: const EdgeInsets.all(32),
      children: [
        const SizedBox(height: 80),
        Icon(icon, size: 64, color: theme.colorScheme.error),
        const SizedBox(height: 16),
        Text(title,
            style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(
          failure.message,
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.outline),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Center(
          child: FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ),
      ],
    );
  }
}

class _DataState extends StatelessWidget {
  const _DataState({required this.entries});
  final List<LogEntry> entries;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      itemBuilder: (_, i) {
        final e = entries[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.note_alt_outlined),
            title: Text(e.title),
            subtitle: Text(e.body),
            trailing: Chip(label: Text(e.category)),
          ),
        );
      },
    );
  }
}
