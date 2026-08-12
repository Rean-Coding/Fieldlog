import 'chars.dart';
import 'clusters.dart';
import 'dictionary.dart';

/// Finds word boundaries in Khmer text.
///
/// Khmer does not put spaces between words — a space marks the end of a phrase,
/// roughly where English would use a comma. So a line breaker that splits on
/// whitespace has almost nothing to work with, and a long Khmer sentence either
/// overflows its box or breaks in the middle of a word.
///
/// The fix is to find the boundaries yourself and mark them with a zero-width
/// space, which is invisible but which every line breaker will honour.
///
/// This uses longest-match-first against a wordlist. That is the same approach
/// ICU takes, minus the statistical model it falls back on, and it is only ever
/// as good as the dictionary you give it — see [starterKhmerWords].
class KhmerSegmenter {
  KhmerSegmenter({Set<String>? words})
      : _words = words ?? starterKhmerWords,
        _longest = (words ?? starterKhmerWords)
            .fold(0, (m, w) => w.length > m ? w.length : m);

  final Set<String> _words;
  final int _longest;

  /// Split [input] into words, keeping every character.
  ///
  /// Runs of non-Khmer text (Latin, digits, punctuation, spaces) are emitted as
  /// single pieces, so this is safe on a mixed string.
  List<String> segment(String input) {
    final out = <String>[];
    var i = 0;

    while (i < input.length) {
      if (!isKhmerCodePoint(input.codeUnitAt(i))) {
        final start = i;
        while (i < input.length && !isKhmerCodePoint(input.codeUnitAt(i))) {
          i++;
        }
        out.add(input.substring(start, i));
        continue;
      }

      final match = _longestMatchAt(input, i);
      if (match != null) {
        out.add(match);
        i += match.length;
        continue;
      }

      // Nothing in the dictionary starts here. Consume one cluster and try
      // again — never one code unit, which would split a subscript from its
      // base and produce a fragment that cannot be rendered.
      final cluster = khmerClusters(input.substring(i)).first;
      out.add(cluster);
      i += cluster.length;
    }

    return out;
  }

  String? _longestMatchAt(String input, int start) {
    final limit = (start + _longest).clamp(0, input.length);
    for (var end = limit; end > start; end--) {
      final candidate = input.substring(start, end);
      if (_words.contains(candidate)) return candidate;
    }
    return null;
  }

  /// Insert an invisible break opportunity between words.
  ///
  /// The returned string looks identical and renders identically, but now wraps
  /// at word boundaries instead of overflowing or breaking mid-word.
  ///
  /// Do this once, when the text enters your app — not in `build`, which runs
  /// on every frame.
  String withWordBreaks(String input, {String separator = '​'}) {
    final pieces = segment(input);
    final out = StringBuffer();
    for (var i = 0; i < pieces.length; i++) {
      if (i > 0 && _breakBetween(pieces[i - 1], pieces[i])) {
        out.write(separator);
      }
      out.write(pieces[i]);
    }
    return out.toString();
  }

  /// No point marking a break next to something that already breaks — or next
  /// to punctuation, where a break would look like a typographic error.
  bool _breakBetween(String left, String right) {
    if (left.isEmpty || right.isEmpty) return false;
    if (left.trimRight() != left || right.trimLeft() != right) return false;
    final last = left.runes.last;
    final first = right.runes.first;
    if (isKhmerPunctuation(last) || isKhmerPunctuation(first)) return false;
    return isKhmerCodePoint(last) && isKhmerCodePoint(first);
  }
}
