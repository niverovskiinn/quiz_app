import 'package:flutter/material.dart';
import 'package:quiz_app/models/domain/question.dart';
import 'package:quiz_app/resourses/strings.dart';

class ExpansionQuizQuestion extends StatelessWidget {
  final Question question;
  final String userAnswer;
  final bool initiallyExpanded;
  final void Function(bool)? onExpansionChanged;
  const ExpansionQuizQuestion({
    Key? key,
    required this.question,
    required this.userAnswer,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
  }) : super(key: key);

  Widget _buildAnswerLine(BuildContext context, String title, String answer) {
    return Text.rich(
      TextSpan(
        text: title,
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(
            text: answer,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
      textAlign: TextAlign.left,
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor =
        question.correctAnswer == userAnswer ? Colors.green : Colors.red;

    return ExpansionTile(
      key: ValueKey(question.question),
      collapsedIconColor: iconColor,
      iconColor: iconColor,
      title: Text(question.question),
      onExpansionChanged: onExpansionChanged,
      initiallyExpanded: initiallyExpanded,
      expandedAlignment: Alignment.centerLeft,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAnswerLine(context, AppStrings.yourAnswer, userAnswer),
            _buildAnswerLine(
                context, AppStrings.correctAnswer, question.correctAnswer),
          ],
        )
      ],
    );
  }
}
