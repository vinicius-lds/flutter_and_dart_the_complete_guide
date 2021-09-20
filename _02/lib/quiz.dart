import 'package:_02/answer.dart';
import 'package:_02/question.dart';
import 'package:flutter/cupertino.dart';

class Quiz extends StatelessWidget {
  final Function answerQuestion;
  final List<Map<String, Object>> questions;
  final int questionIndex;

  const Quiz(
      {Key? key,
      required this.answerQuestion,
      required this.questions,
      required this.questionIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questionText: questions[questionIndex]['questionText'] as String,
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map(
          (answer) {
            return Answer(
              answerText: answer['text'] as String,
              select: () => answerQuestion(answer['score']),
            );
          },
        ).toList(),
      ],
    );
  }
}
