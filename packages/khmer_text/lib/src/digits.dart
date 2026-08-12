import 'chars.dart';

const _khmerZero = 0x17E0;
const _asciiZero = 0x30;

/// Rewrite ASCII digits as Khmer digits: `2026` → `២០២៦`.
///
/// Only the digits change. Everything else — separators, currency symbols,
/// letters — passes through, so this is safe to run over a formatted string.
String toKhmerDigits(String input) {
  final out = StringBuffer();
  for (final c in input.runes) {
    if (c >= _asciiZero && c <= _asciiZero + 9) {
      out.writeCharCode(_khmerZero + (c - _asciiZero));
    } else {
      out.writeCharCode(c);
    }
  }
  return out.toString();
}

/// The inverse: `២០២៦` → `2026`.
///
/// Needed more often than you would expect. A number typed on a Khmer keyboard
/// arrives in Khmer digits, and `int.parse` does not accept them.
String toAsciiDigits(String input) {
  final out = StringBuffer();
  for (final c in input.runes) {
    if (isKhmerDigit(c)) {
      out.writeCharCode(_asciiZero + (c - _khmerZero));
    } else {
      out.writeCharCode(c);
    }
  }
  return out.toString();
}

/// Parse an integer written in either script.
///
/// `int.tryParse('២០២៦')` returns null; this returns 2026.
int? tryParseKhmerInt(String input) => int.tryParse(toAsciiDigits(input.trim()));

/// Parse a decimal written in either script.
double? tryParseKhmerDouble(String input) =>
    double.tryParse(toAsciiDigits(input.trim()));
