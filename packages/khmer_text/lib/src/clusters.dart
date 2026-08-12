import 'chars.dart';

/// Split [input] into orthographic clusters — a base letter plus every mark
/// that hangs off it.
///
/// A cluster is the smallest piece of Khmer you may cut without producing
/// nonsense. `String.substring`, `characters`, and anything counting UTF-16
/// units will all happily slice a consonant away from its subscript and leave a
/// vowel floating on nothing.
List<String> khmerClusters(String input) {
  final codes = input.runes.toList();
  final out = <String>[];
  final buffer = StringBuffer();

  void flush() {
    if (buffer.isNotEmpty) {
      out.add(buffer.toString());
      buffer.clear();
    }
  }

  for (var i = 0; i < codes.length; i++) {
    final c = codes[i];

    if (c == coeng) {
      // Coeng plus the consonant it subscripts belong to the cluster in
      // progress, never to the next one.
      buffer.writeCharCode(c);
      if (i + 1 < codes.length) {
        buffer.writeCharCode(codes[i + 1]);
        i++;
      }
      continue;
    }

    if (isKhmerMark(c) || isInvisible(c)) {
      buffer.writeCharCode(c);
      continue;
    }

    flush();
    buffer.writeCharCode(c);
  }

  flush();
  return out;
}

/// Truncate to at most [maxClusters] clusters, appending [ellipsis].
///
/// The reason to prefer this over `substring`: cutting mid-cluster strips a
/// consonant of its vowel, so the last visible character becomes a different
/// word — or a dotted circle where the renderer gave up.
String truncateKhmer(String input, int maxClusters, {String ellipsis = '…'}) {
  final clusters = khmerClusters(input);
  if (clusters.length <= maxClusters) return input;
  return clusters.take(maxClusters).join() + ellipsis;
}

/// The number of characters a reader would count — not `String.length`, which
/// counts UTF-16 units, and not `runes.length`, which counts code points.
int khmerLength(String input) => khmerClusters(input).length;
