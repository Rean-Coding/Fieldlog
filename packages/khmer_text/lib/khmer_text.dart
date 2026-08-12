/// Khmer text handling for Dart and Flutter.
///
/// Khmer breaks four assumptions that most string code is built on:
///
/// 1. **Words are not separated by spaces.** A space in Khmer ends a phrase, so
///    a whitespace line breaker has nothing to work with. See [KhmerSegmenter].
/// 2. **The same visible text has more than one encoding.** Marks can be typed
///    in any order and render identically, so `==` disagrees with the reader.
///    See [normalizeKhmer] and [khmerSearchKey].
/// 3. **A character is not a code point.** A base plus its subscript and vowels
///    is one thing to a reader and several to `String`. See [khmerClusters].
/// 4. **Code-point order is not alphabetical order** once marks are involved.
///    See [compareKhmer].
///
/// Everything here leaves non-Khmer text alone, so it is safe on mixed strings.
library khmer_text;

export 'src/chars.dart'
    show
        coeng,
        zeroWidthSpace,
        isKhmerBase,
        isKhmerConsonant,
        isKhmerDependentVowel,
        isKhmerDigit,
        isKhmerCodePoint,
        isKhmerMark;
export 'src/clusters.dart' show khmerClusters, khmerLength, truncateKhmer;
export 'src/collation.dart'
    show compareKhmer, khmerComparator, sortByKhmer;
export 'src/dictionary.dart' show starterKhmerWords;
export 'src/digits.dart'
    show
        toAsciiDigits,
        toKhmerDigits,
        tryParseKhmerDouble,
        tryParseKhmerInt;
export 'src/normalize.dart'
    show
        KhmerNormalizeOptions,
        khmerContains,
        khmerEquals,
        khmerSearchKey,
        normalizeKhmer;
export 'src/segmentation.dart' show KhmerSegmenter;
export 'src/style.dart'
    show
        KhmerText,
        KhmerTextStyle,
        KhmerTextTheme,
        containsKhmer,
        khmerLineHeight;
