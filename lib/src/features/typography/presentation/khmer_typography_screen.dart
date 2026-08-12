import 'package:flutter/material.dart';
import 'package:khmer_text/khmer_text.dart';

/// Side by side: what Khmer looks like when the defaults are left alone, and
/// what it looks like when they are not.
///
/// This screen exists to be photographed. Both columns hold the same string;
/// the only difference is whether the text went through [KhmerText].
class KhmerTypographyScreen extends StatelessWidget {
  const KhmerTypographyScreen({super.key});

  /// One sentence with no spaces anywhere inside it, which is normal Khmer.
  ///
  /// Measure before you believe anyone about this, including this book: on
  /// Android the platform line breaker carries an ICU Khmer dictionary and
  /// wraps it correctly with no help at all.
  static const sample =
      'កម្មវិធីនេះរក្សាទុកកំណត់ត្រានៅក្នុងទូរស័ព្ទរបស់អ្នកហើយផ្ញើទៅម៉ាស៊ីនមេនៅពេលមានបណ្ដាញ';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Khmer typography')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Panel(
            label: 'Text — Flutter defaults',
            tone: theme.colorScheme.primary,
            note: 'Wraps at word boundaries — Android already knows Khmer.',
            // The plain widget, with no help.
            child: SizedBox(
              width: 190,
              child: Text(sample, style: theme.textTheme.bodyLarge),
            ),
          ),
          const SizedBox(height: 20),
          _Panel(
            label: 'KhmerText — break hints + metrics',
            tone: theme.colorScheme.primary,
            note: 'Identical on Android. The hints buy portability, not beauty.',
            child: SizedBox(
              width: 190,
              child: KhmerText(sample, style: theme.textTheme.bodyLarge),
            ),
          ),
          const SizedBox(height: 20),
          _Panel(
            label: 'Line height — default',
            tone: theme.colorScheme.error,
            note: 'Tight line box, Latin metrics.',
            child: Container(
              color: theme.colorScheme.errorContainer,
              child: Text(
                'ខ្ញុំកំពុងស្វែងរកព័ត៌មាន',
                style: theme.textTheme.headlineSmall?.copyWith(height: 1.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _Panel(
            label: 'Line height — khmerSafe()',
            tone: theme.colorScheme.primary,
            note: 'Same string and size, room for the stacks.',
            child: Container(
              color: theme.colorScheme.primaryContainer,
              child: Text(
                'ខ្ញុំកំពុងស្វែងរកព័ត៌មាន',
                style: theme.textTheme.headlineSmall?.khmerSafe(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _Panel(
            label: 'Truncation',
            tone: theme.colorScheme.primary,
            note: 'substring cuts a cluster; truncateKhmer does not.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'substring(0, 8):  ${sample.substring(0, 8)}',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  'truncateKhmer(4):  ${truncateKhmer(sample, 4)}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({
    required this.label,
    required this.note,
    required this.tone,
    required this.child,
  });

  final String label;
  final String note;
  final Color tone;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: tone.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: tone,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          child,
          const SizedBox(height: 8),
          Text(
            note,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
