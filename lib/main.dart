import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TestTypingAnimationWidget(),
    );
  }
}

class TestTypingAnimationWidget extends StatefulWidget {
  const TestTypingAnimationWidget({
    super.key,
  });

  @override
  State<TestTypingAnimationWidget> createState() =>
      _TestTypingAnimationWidgetState();
}

class _TestTypingAnimationWidgetState extends State<TestTypingAnimationWidget> {
  final String firstText = "Your Text Here!";
  Timer? _timer;
  String displayedText = "";
  int index = 0;

  @override
  void initState() {
    super.initState();
    startTypingAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTypingAnimation() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      String currentText = firstText;
      if (index < currentText.length) {
        if (mounted) {
          setState(() {
            displayedText += currentText[index];
            index++;
          });
        }
      } else {
        _timer?.cancel();
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              displayedText = "";
              index = 0;
            });
          }
          startTypingAnimation();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          displayedText,
          style: const TextStyle(
            fontSize: 44.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
