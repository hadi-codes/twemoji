import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class TwemojiTextSpan extends TextSpan {
  TwemojiTextSpan({
    TextStyle? style,
    required String text,
    List<TextSpan>? children,
    GestureRecognizer? recognizer,
  }) : super(
            style: style,
            children: _parse(style ?? TextStyle(), text)
              ..addAll(children ?? []),
            recognizer: recognizer);

  static List<InlineSpan> _parse(TextStyle style, String text) {
    final spans = <InlineSpan>[];

    text.splitMapJoin(
      regex,
      onMatch: (m) {
        String emojiStr = (m.input.substring(m.start, m.end));

        for (var emoji in emojiStr.characters) {
          String path = replaceEmoji(emoji);
          if (path != 'null')
            spans.add(
              WidgetSpan(
                style: style,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: style.letterSpacing ?? 1,
                      vertical: style.height ?? 2),
                  child: Image.asset(
                    'assets/png/$path.png',
                    height: style.fontSize,
                    width: style.fontSize,
                    package: 'twemoji',
                  ),
                ),
              ),
            );
        }
        return '';
      },
      onNonMatch: (s) {
        spans.add(TextSpan(text: s));
        return '';
      },
    );

    return spans;
  }

  static String replaceEmoji(String text) {
    return emojis[text].toString().toLowerCase();
  }
}
