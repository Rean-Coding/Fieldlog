import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/logs_providers.dart';
import '../domain/log_entry.dart';

/// Logs list screen — renders the four states explicitly.
///
/// This is the Week 5 teaching artifact. Every async surface in this course
/// must render four distinct UIs:
///   1. Loading  — a skeleton, NOT a centered CircularProgressIndicator
///   2. Data     — the list of entries
///   3. Empty    — "Add your first log" CTA (not just an empty list)
///   4. Error    — error message with a Retry button
///
/// We use `state.when(...)` for exhaustive pattern matching on AsyncValue.
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
            message: e.toString(),
            onRetry: () => ref.invalidate(logsNotifierProvider),
          ),
          data: (entries) => entries.isEmpty
              ? const _EmptyState()
              : _DataState(entries: entries),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addSample(ref),
        icon: const Icon(Icons.add),
        label: const Text('Add sample'),
      ),
    );
  }

  void _addSample(WidgetRef ref) {
    ref.read(logsNotifierProvider.notifier).addEntry(
          title: 'Quick note',
          body: 'Added at ${DateTime.now()}',
          category: 'demo',
        );
  }
}

/// Loading state — a skeleton (gray placeholder rows), not a spinner.
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}

/// Empty state — explicit CTA, not just an empty ListView.
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
        Text(
          'No logs yet',
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Tap "Add sample" below to create your first log.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.outline,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Error state — message + Retry. NEVER silently swallow errors.
class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(32),
      children: [
        const SizedBox(height: 80),
        Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
        const SizedBox(height: 16),
        Text(
          'Could not load logs',
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.outline,
          ),
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

/// Data state — the actual list.
class _DataState extends StatelessWidget {
  const _DataState({required this.entries});

  final List<LogEntry> entries;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      itemBuilder: (context, i) {
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
