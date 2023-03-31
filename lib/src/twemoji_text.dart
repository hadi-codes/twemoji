import 'package:flutter/material.dart';
import 'package:twemoji_v2/twemoji_v2.dart';

/// A text widget which renders emojis as twemojis. This utilizes [Text.rich] in
/// combination with [TwemojiTextSpan].
class TwemojiText extends StatelessWidget {
  const TwemojiText({
    Key? key,
    required this.text,
    this.emojiFontMultiplier = 1.0,
    this.twemojiFormat = TwemojiFormat.svg,
    this.fitzpatrickTypes = FitzpatrickType.values,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : super(key: key);

  /// The text to display.
  final String text;

  /// Allows to multiply the rendered emoji's size. Defaults to 1.
  final double emojiFontMultiplier;

  /// Specifies the way the twemojis get rendered. [TwemojiFormat.png] uses the
  /// 72x72px PNG, while [TwemojiFormat.svg] uses the corresponding SVG.
  final TwemojiFormat twemojiFormat;

  /// A list with allowed fitzpatrick types. This contains all types by default.
  /// If an emoji uses a fitzpatrick type that is not in this list, it will
  /// fall back to it's default, yellow, variation.
  final List<FitzpatrickType> fitzpatrickTypes;

  /// The [TextStyle] to use.
  /// This is directly passed into the [Text.rich] widget.
  final TextStyle? style;

  /// The [StrutStyle] to use.
  /// This is directly passed into the [Text.rich] widget.
  final StrutStyle? strutStyle;

  /// The [TextAlign] to use.
  /// This is directly passed into the [Text.rich] widget.
  final TextAlign? textAlign;

  /// The [TextDirection] to use.
  /// This is directly passed into the [Text.rich] widget.
  final TextDirection? textDirection;

  /// The [Locale] to use.
  /// This is directly passed into the [Text.rich] widget.
  final Locale? locale;

  /// Whether to use [softWrap].
  /// This is directly passed into the [Text.rich] widget.
  final bool? softWrap;

  /// The [TextOverflow] to use.
  /// This is directly passed into the [Text.rich] widget.
  final TextOverflow? overflow;

  /// The [textScaleFactor] to use.
  /// This is identical to [MediaQueryData.textScaleFactor]
  /// This is directly passed into the [Text.rich] widget.
  final double? textScaleFactor;

  /// The maximum amount of lines allowed.
  /// This is directly passed into the [Text.rich] widget.
  final int? maxLines;

  /// The [semanticsLabel] to use.
  /// This is directly passed into the [Text.rich] widget.
  final String? semanticsLabel;

  /// The [TextWidthBasis] to use.
  /// This is directly passed into the [Text.rich] widget.
  final TextWidthBasis? textWidthBasis;

  /// The [TextHeightBehavior] to use.
  /// This is directly passed into the [Text.rich] widget.
  final TextHeightBehavior? textHeightBehavior;

  /// The [selectionColor] to use.
  /// This is directly passed into the [Text.rich] widget.
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) => Text.rich(
        TwemojiTextSpan(
            text: text,
            emojiFontMultiplier: emojiFontMultiplier,
            twemojiFormat: twemojiFormat,
            fitzpatrickTypes: fitzpatrickTypes),
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
}
