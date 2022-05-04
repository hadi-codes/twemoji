// ignore_for_file: prefer_final_locals

final _u200D = String.fromCharCode(0x200D);

final _uFE0Fg = RegExp(
  r'\uFE0F',
  unicode: true,
);

/// Converts emoji to unicode 😀 => "1F600"
String emojiToUnicode(String rawText) => _toCodePoint(
      !rawText.contains(_u200D) ? rawText.replaceAll(_uFE0Fg, '') : rawText,
    );

String _toCodePoint(String input, {String sep = '-'}) {
  var r = [], c = 0, p = 0, i = 0;
  while (i < input.length) {
    c = input.codeUnitAt(i++);
    if (p != 0) {
      r.add((0x10000 + ((p - 0xD800) << 10) + (c - 0xDC00)).toRadixString(16));
      p = 0;
    } else if (0xD800 <= c && c <= 0xDBFF) {
      p = c;
    } else {
      r.add(c.toRadixString(16));
    }
  }
  return r.join(sep);
}
