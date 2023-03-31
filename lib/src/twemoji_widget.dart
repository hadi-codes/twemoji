import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twemoji_v2/twemoji_v2.dart';

/// returns an image of an emoji
///
/// The format of the emoji image it can be [TwemojiFormat.png]
/// 72*72 png or [TwemojiFormat.svg] svg by default.
class Twemoji extends StatelessWidget {
  const Twemoji(
      {Key? key,
      required this.emoji,
      this.height,
      this.width,
      this.fit,
      this.twemojiFormat = TwemojiFormat.svg,
      this.fitzpatrickTypes = FitzpatrickType.values})
      : super(key: key);

  /// The emoji as a string. When multiple emojis are passed, this will
  /// simply just display the last one.
  final String emoji;

  /// The dimensions for this emoji.
  final double? height, width;

  /// How to inscribe the image into the space allocated during layout.
  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  final BoxFit? fit;

  /// Specifies the way the twemojis get rendered. [TwemojiFormat.png] uses the
  /// 72x72px PNG, while [TwemojiFormat.svg] uses the corresponding SVG.
  final TwemojiFormat twemojiFormat;

  /// A list with allowed fitzpatrick types. This contains all types by default.
  /// If an emoji uses a fitzpatrick type that is not in this list, it will
  /// fall back to it's default, yellow, variation.
  final List<FitzpatrickType> fitzpatrickTypes;

  @override
  Widget build(BuildContext context) {
    var cleanEmoji = '';
    emoji.splitMapJoin(
      TwemojiUtils.emojiRegex,
      onMatch: (m) => cleanEmoji = m.input.substring(m.start, m.end),
    );
    var unicode = TwemojiUtils.toUnicode(cleanEmoji);
    if (unicode == '') {
      return const SizedBox.shrink();
    }
    if (TwemojiUtils.isFitzpatrick(unicode)) {
      for (final type in FitzpatrickType.values) {
        if (!fitzpatrickTypes.contains(type)) {
          unicode = unicode.replaceAll('-${type.unicode}', '');
        }
      }
    }
    switch (twemojiFormat) {
      case TwemojiFormat.png:
        return Image.asset(
          'assets/png/$unicode.png',
          fit: fit,
          height: width,
          width: height,
          package: 'twemoji_v2',
        );
      case TwemojiFormat.svg:
        return SvgPicture.asset(
          'assets/svg/$unicode.svg',
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
          package: 'twemoji_v2',
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
