/// Specifies the way the twemojis get rendered.
enum TwemojiFormat {
  /// Uses the corresponding SVG.
  svg,

  /// Similar to [svg], but gets the SVG-file from
  /// https://abs.twimg.com/emoji/v2/svg
  networkSvg,

  /// Utilizes the 72x72px PNGs.
  png,
}
