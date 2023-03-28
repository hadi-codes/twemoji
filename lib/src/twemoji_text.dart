import 'package:flutter/material.dart';

import 'package:twemoji_v2/twemoji.dart';

/// returns a widget with rendered text with twitter emojis
class TwemojiText extends StatelessWidget {
  /// The Text
  final String text;

  /// Describes the font style and the emoji size
  final TextStyle? style;

  /// Multiplie the emoji size, by default it's 1
  final double emojiFontMultiplier;

  /// Maximal lines to be rendered
  final int? maxLines;

  /// The format of the emoji image it can be [TwemojiFormat.png]
  /// 72*72 png or [TwemojiFormat.svg] svg by default.
  final TwemojiFormat twemojiFormat;

  const TwemojiText({
    Key? key,
    required this.text,
    this.style,
    this.maxLines,
    this.emojiFontMultiplier = 1.0,
    this.twemojiFormat = TwemojiFormat.svg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RichText(
        text: TwemojiTextSpan(
          text: text,
          emojiFontMultiplier: emojiFontMultiplier,
          twemojiFormat: twemojiFormat,
          style: style,
        ),
        maxLines: maxLines,
      );
}
