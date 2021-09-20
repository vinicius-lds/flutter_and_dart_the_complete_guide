import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final VoidCallback reset;
  final int result;

  const Result({Key? key, required this.reset, required this.result})
      : super(key: key);

  String get resultPhrase {
    var resultText = 'You did it! ';
    if (result <= 8) {
      resultText += 'You are awsome and inocent';
    } else if (result <= 12) {
      resultText += 'Pretty likeable';
    } else if (result <= 16) {
      resultText += 'Your are... strange?';
    } else {
      resultText += 'Pretty bad';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            child: const Text('Restart Quiz!'),
            style: TextButton.styleFrom(
              textStyle: const TextStyle(color: Colors.blue),
            ),
            onPressed: reset,
          )
        ],
      ),
    );
  }
}
