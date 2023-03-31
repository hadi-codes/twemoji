# twemoji_v2
> Originally maintained by [hadi-codes](https://github.com/hadi-codes), extended to support the newest set of twemoji.

[Twemoji](https://twemoji.twitter.com/) for Flutter, supports SVG and 72x72px PNG emojis

Based on [jdecked's fork of twemoji (v14.1.2)](https://github.com/jdecked/twemoji)

<img src="https://raw.githubusercontent.com/DynxstyGIT/twemoji_v2/main/art/1.png" width=270>

## Usage

**Twemoji** to display single emojis

```dart
Twemoji(
  emoji: '🍕',
  height: 50,
  width: 50,
)
```

**TwemojiText** returns a widget with rendered text with twitter emojis

```dart
TwemojiText(
  text: 'wow 💻👩‍💻👨‍💻 ',
),
```

**TwemojiTextSpan** with **RichText** and it will render the text with twitter Emojies

```dart
RichText(
  text: TwemojiTextSpan(
  text: 'Text 🍕🍔🌭🍿🧂🥓🥨🥐🍞🥞🥞',
  style: Theme.of(context).textTheme.headline6,
  ),
)
```

## Including specific emojis

By default the library includes support for all emojis. To reduce bundle size and only build the emojis your application requires, specify a list of them in your `pubspec.yaml`:

```dart
twemoji:
  includes: '👩‍👩‍👧‍👧👏👍'
```

Then call `flutter pub run twemoji:include_emojis` to have it filter down the list of emojis to generate assets for.
