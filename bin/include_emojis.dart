// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:characters/src/extensions.dart';
import 'package:io/io.dart';
import 'package:path/path.dart' as path;
import 'package:twemoji/src/utils.dart';
import 'package:yaml/yaml.dart';

Future<void> main(List<String> args) async {
  // Navigate to the .dart_tool directory and read the path of the twemoji
  // script from the package_config. The script will live in:
  // .dart_tool/pub/bin/twemoji/script so we need to walk up 4 directories.
  final packageConfigDirectory =
      Directory(Platform.script.toFilePath()).parent.parent.parent.parent;

  final packageConfigFile =
      File('${packageConfigDirectory.path}/package_config.json');

  final packageConfigStr = packageConfigFile.readAsStringSync();
  final packageConfigJson = jsonDecode(packageConfigStr);

  final List packages = packageConfigJson['packages'];
  final Map? twemojiPackageConfig =
      packages.firstWhere((package) => package['name'] == 'twemoji');

  if (twemojiPackageConfig == null) {
    print('Could not find twemoji package');
    exit(0);
  }

  final String twemojiPackageRootUri = twemojiPackageConfig['rootUri'];
  final twemojiPackagePath = twemojiPackageRootUri.replaceFirst('file://', '');
  final twemojiPackageAbsolutePath = path.isRelative(twemojiPackagePath)
      ? path.normalize(
          path.join(
            packageConfigDirectory.path,
            twemojiPackagePath,
          ),
        )
      : twemojiPackagePath;

  final pubspecFile = File('${Directory.current.path}/pubspec.yaml');

  final pubspecYamlStr = pubspecFile.readAsStringSync();
  final pubspecYaml = loadYaml(pubspecYamlStr);

  final String? includedEmojis = (pubspecYaml['twemoji'] ?? {})['includes'];

  final assetsPath = '$twemojiPackageAbsolutePath/assets';
  final allAssetsPath = '$twemojiPackageAbsolutePath/all_assets';

  final allAssetsDirectory = Directory(allAssetsPath);

  if (!allAssetsDirectory.existsSync()) {
    allAssetsDirectory.createSync();
  }

  // Move all assets to an all_assets backup folder.
  await copyPath(assetsPath, allAssetsPath);

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
