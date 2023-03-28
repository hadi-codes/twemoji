import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twemoji_v2/twemoji.dart';

/// returns an image of an emoji
///
/// The format of the emoji image it can be [TwemojiFormat.png]
/// 72*72 png or [TwemojiFormat.svg] svg by default.
class Twemoji extends StatelessWidget {
  /// The emoji string
  ///
  /// on passing a string with text and emojis it will show the last emoji
  /// in that string
  final String emoji;
  final double? height;
  final double? width;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  final BoxFit? fit;

  /// The format of the emoji image it can be [TwemojiFormat.png]
  /// 72*72 png or [TwemojiFormat.svg] svg by default.
  ///
  /// Note: svg does'nt works on Flutter html web renderer
  final TwemojiFormat twemojiFormat;

  const Twemoji({
    Key? key,
    required this.emoji,
    this.height,
    this.width,
    this.twemojiFormat = TwemojiFormat.svg,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cleanEmoji = '';
    emoji.splitMapJoin(
      regex,
      onMatch: (m) => cleanEmoji = m.input.substring(m.start, m.end),
    );
    final unicode = emojiToUnicode(cleanEmoji);
    if (unicode == '') {
      return const SizedBox.shrink();
    }
    switch (twemojiFormat) {
      case TwemojiFormat.png:
        return Image.asset(
          'assets/png/$unicode.png',
          fit: fit,
          height: width,
          width: height,
          package: 'twemoji',
        );
      case TwemojiFormat.svg:
        return SvgPicture.asset(
          'assets/svg/$unicode.svg',
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
          package: 'twemoji',
        );
      case TwemojiFormat.networkSvg:
        return SvgPicture.network(
          'https://abs.twimg.com/emoji/v2/svg/$unicode.svg',
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
        );
    }
  }
}
