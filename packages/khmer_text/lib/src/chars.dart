/// Character classification for the Khmer block, U+1780–U+17FF.
///
/// Everything else in this package is built on these predicates, so they are
/// kept boring and table-driven rather than clever.
library;

/// U+17D2. Turns the consonant that follows it into a subscript ("coeng").
const int coeng = 0x17D2;

/// U+200B. Invisible, and used across Khmer digital text to mark where one word
/// ends and the next begins — because Khmer does not separate words with
/// spaces. It is the single most common reason two Khmer strings that look
/// identical are not equal.
const int zeroWidthSpace = 0x200B;

/// U+200C and U+200D. Zero-width non-joiner and joiner.
const int zeroWidthNonJoiner = 0x200C;
const int zeroWidthJoiner = 0x200D;

/// U+17B4 and U+17B5. Inherent vowels: invisible, carry no meaning in modern
/// text, and are treated as encoding errors by every Khmer style guide. They
/// come from old input methods and from copy-paste out of legacy documents.
const int inherentAq = 0x17B4;
const int inherentAa = 0x17B5;

bool isKhmerConsonant(int c) => c >= 0x1780 && c <= 0x17A2;

bool isKhmerIndependentVowel(int c) => c >= 0x17A3 && c <= 0x17B3;

/// Dependent vowel signs, U+17B6–U+17C5. These attach to a base consonant and
/// may render above, below, before or after it — sometimes several at once,
/// which is why line height needs care.
bool isKhmerDependentVowel(int c) => c >= 0x17B6 && c <= 0x17C5;

/// U+17C9 MUUSIKATOAN and U+17CA TRIISAP — the register shifters.
bool isKhmerShifter(int c) => c == 0x17C9 || c == 0x17CA;

/// U+17CC ROBAT.
bool isKhmerRobat(int c) => c == 0x17CC;

/// U+17C6 NIKAHIT and U+17C7 REAHMUK.
bool isKhmerNasalOrAspirate(int c) => c == 0x17C6 || c == 0x17C7;

/// The remaining marks: U+17C8, U+17CB, U+17CD–U+17D1, U+17D3, U+17DD.
bool isKhmerOtherDiacritic(int c) =>
    c == 0x17C8 ||
    c == 0x17CB ||
    (c >= 0x17CD && c <= 0x17D1) ||
    c == 0x17D3 ||
    c == 0x17DD;

/// Any mark that attaches to a base rather than standing alone.
bool isKhmerMark(int c) =>
    isKhmerDependentVowel(c) ||
    isKhmerShifter(c) ||
    isKhmerRobat(c) ||
    isKhmerNasalOrAspirate(c) ||
    isKhmerOtherDiacritic(c) ||
    c == coeng;

/// A base a mark can attach to.
bool isKhmerBase(int c) => isKhmerConsonant(c) || isKhmerIndependentVowel(c);

/// Khmer digits ០–៩, U+17E0–U+17E9.
bool isKhmerDigit(int c) => c >= 0x17E0 && c <= 0x17E9;

/// Khmer punctuation and symbols, U+17D4–U+17DC, plus the lek attak numerals.
bool isKhmerPunctuation(int c) => c >= 0x17D4 && c <= 0x17DC;

/// Anything in the Khmer block or the Khmer Symbols block.
bool isKhmerCodePoint(int c) =>
    (c >= 0x1780 && c <= 0x17FF) || (c >= 0x19E0 && c <= 0x19FF);

bool isInvisible(int c) =>
    c == zeroWidthSpace ||
    c == zeroWidthNonJoiner ||
    c == zeroWidthJoiner ||
    c == inherentAq ||
    c == inherentAa;
