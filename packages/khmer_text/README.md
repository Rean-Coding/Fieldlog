# khmer_text

Khmer text handling for Dart and Flutter: normalisation for search and
comparison, word-break hints, Khmer numerals, collation, and text metrics that
leave room for the marks.

Khmer breaks four assumptions that ordinary string code is built on. Each one
fails quietly — the app runs, the tests pass, and the text is wrong only to
someone who reads Khmer.

## 1. Words are not separated by spaces

A space in Khmer ends a phrase, roughly where English uses a comma. So a line
breaker that splits on whitespace has almost nothing to work with: a long
sentence overflows its box, or wraps mid-word.

```dart
final segmenter = KhmerSegmenter();
Text(segmenter.withWordBreaks(note.body));   // invisible U+200B at boundaries
```

The string still reads identically — `withWordBreaks(x).replaceAll('​', '')`
returns `x` — but now it wraps where a reader would break it.

For UI strings, put the hints in your ARB files once. Segmentation is cheap but
`build` runs on every frame.

## 2. The same visible text has more than one encoding

Several marks can attach to one consonant, and a keyboard emits them in the
order the keys were pressed. `កុំ` and `កំុ` render identically and are
different strings.

```dart
'កុំ' == 'កំុ';                    // false
khmerEquals('កុំ', 'កំុ');          // true
khmerContains(haystack, needle);   // and search that agrees with the reader
```

**Unicode's NFC does not fix this.** Almost every Khmer mark has combining
class 0, and NFC only reorders marks with a non-zero class, so it leaves Khmer
exactly as it found it. The ordering has to come from the script's own rules.

Store `khmerSearchKey(text)` beside the original if you index or de-duplicate.
Normalise for comparison; keep the original for display.

## 3. A character is not a code point

`ខ្ញុំ` is one thing to a reader and five code points to Dart. `substring` will
cut a consonant away from its subscript and leave a vowel attached to nothing.

```dart
khmerLength('ខ្ញុំ');                 // 1, not 5
truncateKhmer(title, 20);            // never cuts a cluster in half
khmerClusters(text);                 // the safe unit to iterate
```

## 4. Code-point order is not alphabetical order

The consonants were encoded in alphabetical order, so a naive sort looks correct
until a word carries a mark — every vowel sign is numerically above every
consonant, so marks outrank letters.

```dart
['កាន់', 'កប់']..sort();                 // ['កប់', 'កាន់']  — wrong
['កាន់', 'កប់']..sort(khmerComparator);  // ['កាន់', 'កប់']  — right
sortByKhmer(entries, (e) => e.title);
```

## Text metrics

A Khmer syllable can stack a vowel above the base and a subscript consonant
below it, so the ink reaches much further from the baseline than Latin does.
Material's defaults are tuned for Latin and clip the marks.

```dart
Text(label, style: theme.bodyMedium!.khmerSafe());
ThemeData(textTheme: base.textTheme.khmerSafe());   // once, not at every call site
KhmerText(userSuppliedString);                      // breaks + metrics together
```

## Numerals

```dart
toKhmerDigits('2026');        // ២០២៦
tryParseKhmerInt('២០២៦');     // 2026   — int.parse returns null for this
```

## Install

```yaml
dependencies:
  khmer_text: ^0.1.0
```

## What this is not

It does not convert legacy **Limon** (pre-Unicode) text — a separate problem with
its own font-specific mapping tables.

Segmentation is longest-match against a wordlist, and is only as good as the
list you give it. [`starterKhmerWords`] holds a few hundred common words, enough
for UI strings and tests. For prose, load a real dictionary and pass it in:

```dart
KhmerSegmenter(words: await loadWordlist());
```

Collation is a two-level comparison — letters, then marks. It is not
CLDR-complete and does not implement contractions or locale tailoring.

## Licence

MIT. Written for *Flutter in the AI Era* by Sok Pongsametrey, and published
separately so it is useful to anyone building Khmer software.
