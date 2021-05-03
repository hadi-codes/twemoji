# twemoji

Twitter Emojis for Flutter

## Usage

Just wrap **TwemojiTextSpan** with **RichText** and it will render the twitter Emojies
```dart
 RichText(
              text: TwemojiTextSpan(
                text: 'Text 🍕🍔🌭🍿🧂🥓🥨🥐🍞🥞🥞',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
```


**Screenshot**


<img width="300px" alt="Demo" src="art/1.png"/>  
