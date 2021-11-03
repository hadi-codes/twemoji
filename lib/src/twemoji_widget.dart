import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twemoji/twemoji.dart';

/// Will always return or[TwemojiFormat.svg]
/// on flutter web html renderer will return [TwemojiFormat.png]
TwemojiFormat getTwemojiFormat() {
  const isSkia = bool.fromEnvironment('FLUTTER_WEB_USE_SKIA');
  if (kIsWeb && !isSkia) {
    return TwemojiFormat.png;
  } else {
    return TwemojiFormat.svg;
  }
}

/// returns an image of an emoji
///
/// The format of the emoji image it can be [TwemojiFormat.png]
/// 72*72 png or [TwemojiFormat.svg] svg by default.
///
/// Note: svg does'nt works on Flutter html web renderer
class Twemoji extends StatelessWidget {
  const Twemoji(
      {Key? key,
      required this.emoji,
      this.height,
      this.width,
      this.twemojiFormat,
      this.fit})
      : super(key: key);

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
  final TwemojiFormat? twemojiFormat;
  @override
  Widget build(BuildContext context) {
    final _twemojiFormat = twemojiFormat ?? getTwemojiFormat();
    var cleanEmoji = '';
    emoji.splitMapJoin(
      regex,
      onMatch: (m) => cleanEmoji = m.input.substring(m.start, m.end),
    );
    final unicode = emojiToUnicode(cleanEmoji);
    if (unicode == '') {
      return const SizedBox.shrink();
    }
    switch (_twemojiFormat) {
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
