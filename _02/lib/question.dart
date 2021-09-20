import 'package:flutter/cupertino.dart';

class Question extends StatelessWidget {
  final String questionText;

  const Question({Key? key, this.questionText = 'Question'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Text(
        questionText,
        style: const TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
