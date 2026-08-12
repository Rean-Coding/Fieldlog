import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khmer_text/khmer_text.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../l10n/locale_controller.dart';
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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.logsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () =>
                ref.read(localeControllerProvider.notifier).toggle(),
            tooltip: l10n.language,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(logsNotifierProvider),
            tooltip: l10n.refresh,
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
        onPressed: () => _addSample(ref, l10n),
        icon: const Icon(Icons.add),
        label: Text(l10n.addSample),
      ),
    );
  }

  void _addSample(WidgetRef ref, AppLocalizations l10n) {
    ref.read(logsNotifierProvider.notifier).addEntry(
          title: l10n.quickNote,
          body: l10n.savedAt(DateTime.now()),
          category: l10n.demoCategory,
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
    final l10n = AppLocalizations.of(context);
    return ListView(
      children: [
        const SizedBox(height: 120),
        Icon(Icons.notes_outlined, size: 72, color: theme.colorScheme.outline),
        const SizedBox(height: 16),
        KhmerText(
          l10n.emptyTitle,
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        // KhmerText rather than Text: this sentence is long enough to wrap, and
        // Khmer gives the line breaker no spaces to work with.
        KhmerText(
          l10n.emptyBody(l10n.addSample),
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
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(32),
      children: [
        const SizedBox(height: 80),
        Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
        const SizedBox(height: 16),
        KhmerText(
          l10n.errorTitle,
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
            label: Text(l10n.retry),
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
            title: KhmerText(e.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: KhmerText(e.body, maxLines: 2, overflow: TextOverflow.ellipsis),
            trailing: Chip(label: Text(e.category)),
          ),
        );
      },
    );
  }
}
