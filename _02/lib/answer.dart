import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String? answerText;
  final VoidCallback? select;

  const Answer({Key? key, this.answerText, this.select}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(answerText as String),
        onPressed: select,
        style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            textStyle: const TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}
