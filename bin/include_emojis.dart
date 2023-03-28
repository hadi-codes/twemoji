// ignore_for_file: avoid_print

import 'dart:io';
import 'package:characters/src/extensions.dart';
import 'package:io/io.dart';
import 'package:twemoji_v2/src/utils.dart';
import 'package:yaml/yaml.dart';

Future<void> main(List<String> args) async {
  final pubspecFile = File('${Directory.current.path}/pubspec.yaml');

  final pubspecYamlStr = pubspecFile.readAsStringSync();
  final pubspecYaml = loadYaml(pubspecYamlStr);

  // The script's path is the /bin directory of the Twemoji package so to navigate
  // to the assets path we go up once for the file and a second time to navigate
  // out of the /bin directory.
  final twemojiPackageAbsolutePath =
      Directory(Platform.script.toFilePath()).parent.parent.path;

  final assetsPath = '$twemojiPackageAbsolutePath/assets';
  final allAssetsPath = '$twemojiPackageAbsolutePath/all_assets';
  final allAssetsDirectory = Directory(allAssetsPath);

  if (!allAssetsDirectory.existsSync()) {
    allAssetsDirectory.createSync();
  }

  // Move all assets to an all_assets backup folder.
  await copyPath(assetsPath, allAssetsPath);

  final String? includedEmojis = (pubspecYaml['twemoji'] ?? {})['includes'];

  // If there is no twemoji includes config property then all assets
  // should be included.
  if (includedEmojis == null) {
    await copyPath(allAssetsPath, assetsPath);

    print('No twemojis to include specified in ${pubspecFile.path}');
    exit(0);
  }

  final pngAssetsDirectory = Directory('$assetsPath/png/');
  final svgAssetsDirectory = Directory('$assetsPath/svg/');

  // Empty the svg/png directories so that they can be repopulated with the
  // emojis specified in the client's pubspec.yaml
  if (pngAssetsDirectory.existsSync()) {
    pngAssetsDirectory.deleteSync(recursive: true);
  }
  if (svgAssetsDirectory.existsSync()) {
    svgAssetsDirectory.deleteSync(recursive: true);
  }

  // Recreate the directories so that the new files can be written under them.
  pngAssetsDirectory.createSync();
  svgAssetsDirectory.createSync();

  final copyEmojisFutures = <Future<File>>[];

  // Iterate over characters, not code units as described here:
  // https://github.com/dart-lang/language/issues/685
  // and write the assets corresponding to the client's emojis into the svg and
  // png directories.
  for (final char in includedEmojis.characters) {
    final unicodeStr = emojiToUnicode(char);

    if (unicodeStr.isNotEmpty) {
      copyEmojisFutures.addAll([
        File('$allAssetsPath/png/$unicodeStr.png')
            .copy('$assetsPath/png/$unicodeStr.png'),
        File('$allAssetsPath/svg/$unicodeStr.svg')
            .copy('$assetsPath/svg/$unicodeStr.svg'),
      ]);
    }
  }

  await Future.wait(copyEmojisFutures);

  print('Emojis included: $includedEmojis');

  exit(0);
}
