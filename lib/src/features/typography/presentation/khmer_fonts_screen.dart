import 'package:flutter/material.dart';
import 'package:khmer_text/khmer_text.dart';

/// The same Khmer sentence in three faces, so the difference is a thing you can
/// look at rather than a thing you are told.
///
/// Choosing a Khmer font is not decoration. The three here differ in stroke
/// weight, in how much room the coeng stacks take, and in how well they hold
/// together at small sizes — and those differences decide whether a dense list
/// is readable on a cheap phone in daylight.
class KhmerFontsScreen extends StatelessWidget {
  const KhmerFontsScreen({super.key});

  static const sample = 'ខ្ញុំកំពុងស្វែងរកព័ត៌មាន';
  static const paragraph =
      'កម្មវិធីនេះរក្សាទុកកំណត់ត្រានៅក្នុងទូរស័ព្ទរបស់អ្នក ហើយផ្ញើទៅម៉ាស៊ីនមេនៅពេលមានបណ្ដាញ។';

  /// `null` means "whatever the platform picks" — on Android that is the
  /// system Khmer font, which is why Khmer renders at all without bundling
  /// anything. It also means your app looks different on different devices.
  static const faces = <(String, String?)>[
    ('System default', null),
    ('Kantumruy Pro', 'Kantumruy Pro'),
    ('Noto Sans Khmer', 'Noto Sans Khmer'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Khmer fonts')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final (label, family) in faces) ...[
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    sample,
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontFamily: family)
                        .khmerSafe(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    paragraph,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontFamily: family)
                        .khmerSafe(),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
