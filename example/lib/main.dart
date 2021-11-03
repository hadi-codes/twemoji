import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:twemoji/twemoji.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Twemoji'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: '🍕🍔🌭👩‍🍳 :Device\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    TwemojiTextSpan(
                      text: '🍕🍔🌭👩‍🍳 :Twemoji.png\n',
                      twemojiFormat: TwemojiFormat.png,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    TwemojiTextSpan(
                      text: '🍕🍔🌭👩‍🍳 :Twemoji.svg x 1.3\n',
                      twemojiFormat: TwemojiFormat.svg,
                      emojiFontMultiplier: 1.3,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    TwemojiTextSpan(
                      text: '🍕🍔🌭👩‍🍳 :Twemoji.svg x 1.3\n',
                      twemojiFormat: TwemojiFormat.networkSvg,
                      emojiFontMultiplier: 1.3,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const TwemojiText(
                text: '💻👩‍💻👨‍💻 :auto format',
                emojiFontMultiplier: 2,
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: SizedBox(
                    height: 105,
                    width: 105,
                    child: Stack(
                      children: List.generate(
                        4,
                        (index) => Align(
                          alignment: _getAlign(index),
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation(index * 90 / 360),
                            child: const Twemoji(
                              emoji: '🍕',
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  AlignmentGeometry _getAlign(int index) {
    switch (index) {
      case 0:
        return Alignment.topCenter;
      case 1:
        return Alignment.centerRight;
      case 2:
        return Alignment.bottomCenter;
      case 3:
        return Alignment.centerLeft;
      default:
        return Alignment.topCenter;
    }
  }
}
