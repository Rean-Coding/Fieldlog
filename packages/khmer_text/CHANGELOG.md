## 0.1.0

First release.

- `normalizeKhmer`, `khmerSearchKey`, `khmerEquals`, `khmerContains` — canonical
  mark ordering, so text that looks the same compares the same.
- `KhmerSegmenter` — longest-match word segmentation and invisible break hints,
  with a starter wordlist.
- `khmerClusters`, `khmerLength`, `truncateKhmer` — cluster-safe measurement and
  truncation.
- `compareKhmer`, `khmerComparator`, `sortByKhmer` — letters before marks.
- `toKhmerDigits`, `toAsciiDigits`, `tryParseKhmerInt`, `tryParseKhmerDouble`.
- `KhmerText`, `khmerSafe()` on `TextStyle` and `TextTheme` — line metrics that
  do not clip stacked marks.
