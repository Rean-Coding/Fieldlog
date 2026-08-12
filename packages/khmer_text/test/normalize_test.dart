import 'package:flutter_test/flutter_test.dart';
import 'package:khmer_text/khmer_text.dart';

void main() {
  // Built from code points rather than pasted, so the test states exactly which
  // sequence it means. Pasted Khmer is precisely the thing that hides the bug.
  const ko = 'ក'; // ក
  const vowelU = 'ុ'; // ុ  dependent vowel
  const nikahit = 'ំ'; // ំ  sign
  const coengSign = '្'; // ្
  const kho = 'ខ'; // ខ

  group('normalizeKhmer', () {
    test('two typings of the same word become one string', () {
      const asRead = '$ko$vowelU$nikahit'; // vowel then sign
      const asTyped = '$ko$nikahit$vowelU'; // sign then vowel

      expect(asRead == asTyped, isFalse,
          reason: 'the two encodings really are different');
      expect(normalizeKhmer(asRead), normalizeKhmer(asTyped));
    });

    test('a coeng keeps the consonant it subscripts', () {
      // ក + coeng ខ + vowel, with the vowel typed before the subscript.
      const scrambled = '$ko$vowelU$coengSign$kho';
      final normalized = normalizeKhmer(scrambled);

      expect(normalized, '$ko$coengSign$kho$vowelU');
      expect(normalized.indexOf(coengSign) + 1,
          normalized.indexOf(kho),
          reason: 'coeng must stay immediately before its consonant');
    });

    test('inherent vowels are dropped', () {
      expect(normalizeKhmer('$ko឴$vowelU'), '$ko$vowelU');
    });

    test('zero-width space is kept for display and dropped for search', () {
      const text = 'ខ្ញុំ​ចង់';
      expect(normalizeKhmer(text), contains('​'));
      expect(khmerSearchKey(text), isNot(contains('​')));
    });

    test('non-Khmer text is untouched', () {
      const mixed = 'FieldLog v2.0 — báo cáo';
      expect(normalizeKhmer(mixed), mixed);
    });

    test('normalisation is idempotent', () {
      final once = normalizeKhmer('$ko$nikahit$vowelU');
      expect(normalizeKhmer(once), once);
    });

    test('no characters are lost', () {
      const input = '$ko$nikahit$vowelU$coengSign$kho';
      expect(normalizeKhmer(input).runes.length, input.runes.length);
    });
  });

  group('search helpers', () {
    test('khmerEquals sees through encoding differences', () {
      expect(khmerEquals('$ko$vowelU$nikahit', '$ko$nikahit$vowelU'), isTrue);
    });

    test('khmerContains sees through an invisible space', () {
      expect(khmerContains('ខ្ញុំ​ចង់​ទៅ', 'ចង់ទៅ'), isTrue);
      expect('ខ្ញុំ​ចង់​ទៅ'.contains('ចង់ទៅ'), isFalse,
          reason: 'which is exactly why khmerContains exists');
    });
  });
}
