import 'package:flutter/material.dart';
import 'package:twemoji_v2/twemoji.dart';

import 'fitzpatrick_type.dart';

/// A [TextSpan] that renders emojis as twemojis.
class TwemojiTextSpan extends TextSpan {
  TwemojiTextSpan({
    required String text,
    this.twemojiFormat = TwemojiFormat.svg,
    this.fitzpatrickTypes = FitzpatrickType.values,
    TextStyle? style,
    List<TextSpan>? children,
    double emojiFontMultiplier = 1,
  }) : super(
          style: style,
          children: _parse(style, text, twemojiFormat, fitzpatrickTypes, emojiFontMultiplier)
            ..addAll(children ?? []),
        );

  /// The format of the emoji image it can be [TwemojiFormat.png]
  /// 72*72 png or [TwemojiFormat.svg] svg by default.
  final TwemojiFormat twemojiFormat;

  /// A list with allowed fitzpatrick types. This contains all types by default.
  /// If an emoji uses a fitzpatrick type that is not in this list, it will
  /// fall back to it's default, yellow, variation.
  final List<FitzpatrickType> fitzpatrickTypes;

  static List<InlineSpan> _parse(
    TextStyle? _style,
    String text,
    TwemojiFormat twemojiFormat,
    List<FitzpatrickType> fitzpatrickTypes,
    double emojiFontMultiplier,
  ) {
    final spans = <InlineSpan>[];
    final textStyle = _style ?? const TextStyle();

    final emojiStyle = textStyle.copyWith(
      fontSize: (textStyle.fontSize ?? 14) * emojiFontMultiplier,
    );
    text.splitMapJoin(
      TwemojiUtils.emojiRegex,
      onMatch: (m) {
        final emojiStr = m.input.substring(m.start, m.end);
        spans.add(
          WidgetSpan(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: emojiStyle.letterSpacing ?? 1,
                    vertical: emojiStyle.height ?? 2),
                child: Twemoji(
                  emoji: emojiStr,
                  twemojiFormat: twemojiFormat,
                  fitzpatrickTypes: fitzpatrickTypes,
                  height: emojiStyle.fontSize,
                  width: emojiStyle.fontSize,
                )),
          ),
        );
        return '';
      },
      onNonMatch: (s) {
        spans.add(TextSpan(
          text: s,
          style: _style,
        ));
        return '';
      },
    );

    return spans;
  }
}
