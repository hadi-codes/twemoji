# twemoji

Twitter Emojis for Flutter, this package supports svg and png 72x72 emojis

## Usage

**Twemoji** widget for a single emoji

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

**Screenshot**

<img width="300px" alt="Demo" src="https://github.com/bigblackclock/twemoji/raw/master/art/2.png"/>

**Limitation**
The svg emojis will not work on flutter html web renderer because the
[flutter_svg](https://pub.dev/packages/flutter_svg "flutter_svg") package does not support it

**TODO**

-   [x] Add SVG support
-   [x] Find a way to get an emoji code. For example: 😀 => "1F600"
-   [ ] Extend Textfield widget to support twemoji

**About**
twemoji: https://twemoji.twitter.com/
