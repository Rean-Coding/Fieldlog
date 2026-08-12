import 'chars.dart';

/// Canonical ordering of the marks that may follow one Khmer base.
///
/// Khmer allows several marks on a single consonant, and a keyboard will happily
/// emit them in whatever order the user pressed the keys. The result renders
/// identically but is a different sequence of code points, so `==`, `contains`
/// and a database `LIKE` all disagree with the reader's eyes.
///
/// Unicode's own NFC does not fix this. Almost every Khmer mark has combining
/// class 0, and NFC only reorders marks with a non-zero class — so
/// `String.normalize`-style fixes, where they exist, leave Khmer untouched.
/// The ordering has to be applied by the script's own rules.
const _rankCoengCluster = 1;
const _rankRobat = 2;
const _rankShifter = 3;
const _rankVowel = 4;
const _rankNasalAspirate = 5;
const _rankOther = 6;

int _rankOf(int c) {
  if (isKhmerRobat(c)) return _rankRobat;
  if (isKhmerShifter(c)) return _rankShifter;
  if (isKhmerDependentVowel(c)) return _rankVowel;
  if (isKhmerNasalOrAspirate(c)) return _rankNasalAspirate;
  return _rankOther;
}

/// One base plus every mark bound to it.
class _Cluster {
  _Cluster(this.base);

  final int base;

  /// (rank, codepoints) — a coeng cluster carries two code points, everything
  /// else carries one.
  final List<(int, List<int>)> parts = [];

  void write(StringBuffer out) {
    out.writeCharCode(base);
    // Stable sort: marks of equal rank keep the order the author typed, which
    // matters for consecutive subscripts where the sequence is meaningful.
    final sorted = [...parts]
      ..sort((a, b) => a.$1.compareTo(b.$1));
    for (final (_, codes) in sorted) {
      for (final c in codes) {
        out.writeCharCode(c);
      }
    }
  }
}

/// Options for [normalizeKhmer].
class KhmerNormalizeOptions {
  const KhmerNormalizeOptions({
    this.reorderMarks = true,
    this.removeInherentVowels = true,
    this.removeZeroWidth = false,
  });

  /// Put the marks on each base into canonical order.
  final bool reorderMarks;

  /// Drop U+17B4 and U+17B5, which are invisible and are always encoding noise.
  final bool removeInherentVowels;

  /// Drop U+200B, U+200C and U+200D.
  ///
  /// Off by default, because a zero-width space is load-bearing for display:
  /// it is often the only thing telling the line breaker where a word ends.
  /// Turn it on for comparison and search, not for text you are about to draw.
  final bool removeZeroWidth;

  static const forDisplay = KhmerNormalizeOptions();
  static const forSearch = KhmerNormalizeOptions(removeZeroWidth: true);
}

/// Put [input] into a canonical form so that text which looks the same *is* the
/// same.
///
/// ```dart
/// final typedOneWay = 'កុំ';   // ក + ុ + ំ
/// final typedAnother = 'កំុ';  // ក + ំ + ុ
/// typedOneWay == typedAnother;                                   // false
/// normalizeKhmer(typedOneWay) == normalizeKhmer(typedAnother);    // true
/// ```
///
/// Non-Khmer text passes through untouched, so it is safe to run over a mixed
/// string.
String normalizeKhmer(
  String input, {
  KhmerNormalizeOptions options = KhmerNormalizeOptions.forDisplay,
}) {
  final codes = input.runes.toList();
  final out = StringBuffer();
  _Cluster? current;

  void flush() {
    current?.write(out);
    current = null;
  }

  for (var i = 0; i < codes.length; i++) {
    final c = codes[i];

    if (options.removeInherentVowels &&
        (c == inherentAq || c == inherentAa)) {
      continue;
    }
    if (options.removeZeroWidth &&
        (c == zeroWidthSpace ||
            c == zeroWidthNonJoiner ||
            c == zeroWidthJoiner)) {
      continue;
    }

    if (isKhmerBase(c)) {
      // A base only starts a new cluster when it is not the consonant being
      // pulled underneath by a preceding coeng.
      flush();
      current = _Cluster(c);
      continue;
    }

    if (current == null || !options.reorderMarks) {
      flush();
      out.writeCharCode(c);
      continue;
    }

    if (c == coeng) {
      // Coeng binds the next character to itself; the pair moves as one.
      if (i + 1 < codes.length && isKhmerBase(codes[i + 1])) {
        current!.parts.add((_rankCoengCluster, [c, codes[i + 1]]));
        i++;
      } else {
        // A trailing coeng with nothing to subscript. Keep it rather than
        // silently deleting the user's data.
        current!.parts.add((_rankCoengCluster, [c]));
      }
      continue;
    }

    if (isKhmerMark(c)) {
      current!.parts.add((_rankOf(c), [c]));
      continue;
    }

    flush();
    out.writeCharCode(c);
  }

  flush();
  return out.toString();
}

/// The form to compare, search and de-duplicate with — never the form to draw.
///
/// Normalises mark order, drops invisible characters, and lower-cases so a
/// mixed Khmer/Latin string behaves. Two strings that a reader would call the
/// same word have the same search key.
String khmerSearchKey(String input) =>
    normalizeKhmer(input, options: KhmerNormalizeOptions.forSearch)
        .toLowerCase();

/// Whether two strings are the same word to a reader, whatever the keystrokes.
bool khmerEquals(String a, String b) => khmerSearchKey(a) == khmerSearchKey(b);

/// [haystack] contains [needle], comparing the way a reader would.
bool khmerContains(String haystack, String needle) =>
    khmerSearchKey(haystack).contains(khmerSearchKey(needle));
