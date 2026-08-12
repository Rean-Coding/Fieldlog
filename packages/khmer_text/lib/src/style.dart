import 'package:flutter/material.dart';

import 'chars.dart';
import 'segmentation.dart';

/// Line height that leaves room for Khmer.
///
/// A Khmer syllable can stack a superscript vowel above the base and a coeng
/// consonant below it, so the ink extends much further from the baseline than
/// Latin does. Material's defaults are tuned for Latin, and the visible symptom
/// is a row of clipped diacritics — text that looks fine in a design tool and
/// wrong on the device, because the clipping only happens once the line box is
/// tight.
///
/// 1.6 is the floor. Dense UI with two-line labels wants more.
const double khmerLineHeight = 1.6;

extension KhmerTextStyle on TextStyle {
  /// Make a Latin-tuned style safe for Khmer.
  ///
  /// Raises the line height and distributes the extra space evenly above and
  /// below, rather than all above, which is what keeps subscripts inside the
  /// line box.
  TextStyle khmerSafe({double height = khmerLineHeight}) => copyWith(
        height: height,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

extension KhmerTextTheme on TextTheme {
  /// Apply [KhmerTextStyle.khmerSafe] across a whole text theme.
  ///
  /// Call this once when building your `ThemeData` for the Khmer locale, rather
  /// than remembering it at four hundred call sites.
  TextTheme khmerSafe({double height = khmerLineHeight}) => apply(
        fontFamily: null,
      ).copyWith(
        displayLarge: displayLarge?.khmerSafe(height: height),
        displayMedium: displayMedium?.khmerSafe(height: height),
        displaySmall: displaySmall?.khmerSafe(height: height),
        headlineLarge: headlineLarge?.khmerSafe(height: height),
        headlineMedium: headlineMedium?.khmerSafe(height: height),
        headlineSmall: headlineSmall?.khmerSafe(height: height),
        titleLarge: titleLarge?.khmerSafe(height: height),
        titleMedium: titleMedium?.khmerSafe(height: height),
        titleSmall: titleSmall?.khmerSafe(height: height),
        bodyLarge: bodyLarge?.khmerSafe(height: height),
        bodyMedium: bodyMedium?.khmerSafe(height: height),
        bodySmall: bodySmall?.khmerSafe(height: height),
        labelLarge: labelLarge?.khmerSafe(height: height),
        labelMedium: labelMedium?.khmerSafe(height: height),
        labelSmall: labelSmall?.khmerSafe(height: height),
      );
}

/// Does this string contain any Khmer at all?
///
/// Useful for deciding per-string whether to apply Khmer metrics, in an app
/// whose content is mixed regardless of the selected locale.
bool containsKhmer(String input) => input.runes.any(isKhmerCodePoint);

/// A [Text] that wraps Khmer at word boundaries and leaves room for the marks.
///
/// Equivalent to `Text`, except that it inserts invisible break opportunities
/// and raises the line height. Reach for it when the string is user data — for
/// UI strings, put the break hints in your ARB files once, at build time,
/// rather than paying for segmentation on every rebuild.
class KhmerText extends StatelessWidget {
  const KhmerText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height = khmerLineHeight,
    this.segmenter,
  });

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double height;
  final KhmerSegmenter? segmenter;

  static final KhmerSegmenter _shared = KhmerSegmenter();

  @override
  Widget build(BuildContext context) {
    final base = style ?? DefaultTextStyle.of(context).style;
    return Text(
      (segmenter ?? _shared).withWordBreaks(data),
      // The break hints are a layout instruction, not content. Without this,
      // the zero-width spaces reach the accessibility tree — a screen reader
      // announces the word in pieces, and any test or automation matching on
      // the label fails against a string that looks correct on screen.
      semanticsLabel: data,
      style: base.khmerSafe(height: height),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
