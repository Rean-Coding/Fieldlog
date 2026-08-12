import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khmer_text/khmer_text.dart';

void main() {
  group('digits', () {
    test('round-trips both ways', () {
      expect(toKhmerDigits('2026'), '២០២៦');
      expect(toAsciiDigits('២០២៦'), '2026');
      expect(toAsciiDigits(toKhmerDigits('01234567890')), '01234567890');
    });

    test('leaves everything that is not a digit alone', () {
      expect(toKhmerDigits('v1.2-beta'), 'v១.២-beta');
    });

    test('parses numbers typed on a Khmer keyboard', () {
      expect(int.tryParse('២០២៦'), isNull, reason: 'the problem');
      expect(tryParseKhmerInt('២០២៦'), 2026);
      expect(tryParseKhmerDouble('១២.៥'), 12.5);
      expect(tryParseKhmerInt('not a number'), isNull);
    });
  });

  group('clusters', () {
    test('a base keeps its subscript and vowel', () {
      // ខ្ញុំ — one thing to a reader, five code points to Dart.
      const word = 'ខ្ញុំ';
      expect(word.runes.length, greaterThan(1));
      expect(khmerClusters(word), hasLength(1));
      expect(khmerLength(word), 1);
    });

    test('truncation never cuts a cluster in half', () {
      const phrase = 'ខ្ញុំចង់ទៅ';
      final cut = truncateKhmer(phrase, 3);

      expect(cut, endsWith('…'));
      // The give-away for a bad cut is a mark with no base in front of it.
      final withoutEllipsis = cut.substring(0, cut.length - 1);
      expect(isKhmerMark(withoutEllipsis.runes.first), isFalse);
      expect(phrase.startsWith(withoutEllipsis), isTrue);
    });

    test('short text is returned unchanged', () {
      expect(truncateKhmer('ខ្ញុំ', 10), 'ខ្ញុំ');
    });
  });

  group('collation', () {
    test('sorts by letter first, marks second', () {
      // កាន់ (to hold) and កប់ (to bury). By letter: ក-ន comes before ក-ប,
      // so កាន់ sorts first. A code-point sort compares the vowel ា (U+17B6)
      // against the consonant ប (U+1794) and puts កប់ first, because every
      // vowel sign is numerically above every consonant. Marks must not
      // outrank letters.
      const hold = 'កាន់';
      const bury = 'កប់';

      final byCodePoint = [hold, bury]..sort();
      final byKhmer = [hold, bury]..sort(khmerComparator);

      expect(byCodePoint, [bury, hold], reason: 'what the SDK does');
      expect(byKhmer, [hold, bury], reason: 'what a reader expects');
    });

    test('sortByKhmer orders objects by a field', () {
      final rows = [
        (name: 'ខ', id: 1),
        (name: 'ក', id: 2),
      ];
      sortByKhmer(rows, (r) => r.name);
      expect(rows.first.id, 2);
    });
  });

  group('segmentation', () {
    final segmenter = KhmerSegmenter();

    test('splits a run of Khmer into dictionary words', () {
      expect(segmenter.segment('ខ្ញុំចង់ទៅ'), ['ខ្ញុំ', 'ចង់', 'ទៅ']);
    });

    test('inserts invisible breaks that do not change what is read', () {
      const input = 'ខ្ញុំចង់ទៅ';
      final hinted = segmenter.withWordBreaks(input);

      expect(hinted, isNot(input));
      expect(hinted.contains('​'), isTrue);
      expect(hinted.replaceAll('​', ''), input,
          reason: 'the visible text must be byte-identical');
    });

    test('keeps non-Khmer runs whole', () {
      expect(segmenter.segment('FieldLog ជា'), ['FieldLog ', 'ជា']);
    });

    test('unknown words fall back to clusters rather than being dropped', () {
      const unknown = 'ឆ្កែឆ្មា'; // not in the starter list
      final pieces = segmenter.segment(unknown);
      expect(pieces.join(), unknown);
    });
  });

  group('style', () {
    test('containsKhmer distinguishes mixed content', () {
      expect(containsKhmer('FieldLog'), isFalse);
      expect(containsKhmer('FieldLog កម្មវិធី'), isTrue);
    });
  });

  testWidgets('KhmerText renders and raises line height', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: KhmerText('ខ្ញុំចង់ទៅ'),
      ),
    );

    final text = tester.widget<Text>(find.byType(Text));
    expect(text.style!.height, khmerLineHeight);
    expect(text.data!.replaceAll('​', ''), 'ខ្ញុំចង់ទៅ');

    // The hints must not reach the accessibility tree: a screen reader would
    // announce the word in pieces, and anything matching on the label would
    // fail against a string that looks right on screen.
    expect(text.semanticsLabel, 'ខ្ញុំចង់ទៅ');
    expect(text.semanticsLabel, isNot(contains('​')));
  });
}
