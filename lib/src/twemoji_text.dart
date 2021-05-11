import 'package:flutter/material.dart';
import 'package:twemoji/src/src.dart';

/// returns a widget with rendered text with twitter emojis
class TwemojiText extends StatelessWidget {
  const TwemojiText(
      {Key? key,
      required this.text,
      this.style,
      this.emojiFontMultiplier,
      this.twemojiFormat})
      : super(key: key);

  /// The Text
  final String text;

  /// Describes the font style and the emoji size
  final TextStyle? style;

  /// Multiplie the emoji size, by default it's 1
  final double? emojiFontMultiplier;

  /// The format of the emoji image it can be [TwemojiFormat.png]
  /// 72*72 png or [TwemojiFormat.svg] svg by default.
  ///
  /// Note: svg does'nt works on Flutter html web renderer
  final TwemojiFormat? twemojiFormat;
  @override
  Widget build(BuildContext context) => RichText(
        text: TwemojiTextSpan(
          text: text,
          emojiFontMultiplier: emojiFontMultiplier!,
          twemojiFormat: twemojiFormat,
          style: style,
        ),
      );
}
