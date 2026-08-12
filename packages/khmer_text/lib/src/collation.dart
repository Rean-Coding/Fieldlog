import 'chars.dart';
import 'normalize.dart';

/// Sort Khmer strings the way a Khmer reader expects.
///
/// The Khmer consonants were encoded in alphabetical order — ក ខ គ ឃ ង … — so a
/// naive code-point sort looks correct until a word carries a mark. U+17D2
/// COENG sits above every consonant numerically, so `ក្ខ` sorts after `កា`,
/// which is wrong: the reader compares the letters first and the marks only to
/// break a tie.
///
/// This is a two-level comparison:
///
/// * **primary** — base letters only, marks ignored;
/// * **secondary** — the full normalised string, to order words that share
///   their letters but differ in marks.
///
/// It is not CLDR-complete — it does not implement contractions or
/// locale-tailored variants — but it puts a list of Khmer words in the order a
/// reader would put them in, which the SDK's default comparator does not.
int compareKhmer(String a, String b) {
  final primary = _bases(a).compareTo(_bases(b));
  if (primary != 0) return primary;
  return normalizeKhmer(a).compareTo(normalizeKhmer(b));
}

String _bases(String input) {
  final out = StringBuffer();
  for (final c in normalizeKhmer(input).runes) {
    // Marks and invisibles carry no primary weight; anything outside the Khmer
    // block keeps its own, so mixed lists still sort sensibly.
    if (isKhmerMark(c) || isInvisible(c)) continue;
    out.writeCharCode(c);
  }
  return out.toString();
}

/// A [Comparator] for `List.sort`.
///
/// ```dart
/// names.sort(khmerComparator);
/// ```
int Function(String, String) get khmerComparator => compareKhmer;

/// Sort a list of objects by a Khmer string field.
void sortByKhmer<T>(List<T> items, String Function(T) key) {
  items.sort((a, b) => compareKhmer(key(a), key(b)));
}
