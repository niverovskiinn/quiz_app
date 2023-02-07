import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:quiz_app/models/domain/quiz_results.dart';
import 'package:quiz_app/navigation/page_route_names.dart';
import 'package:quiz_app/pages/quiz_results/quiz_results_vm.dart';
import 'package:quiz_app/resourses/strings.dart';
import 'package:quiz_app/widgets/expansion_quiz_question.dart';
import 'package:quiz_app/widgets/info_dialog.dart';

class QuizResultsPage extends StatefulWidget {
  final QuizResults quizResults;

  const QuizResultsPage({Key? key, required this.quizResults})
      : super(key: key);

  @override
  State<QuizResultsPage> createState() => _QuizResultsPageState();
}

class _QuizResultsPageState extends State<QuizResultsPage> {
  late final _questionsEntries =
      widget.quizResults.questionsWithUserAnswers.entries.toList();
  late final List<bool> _expansionStatus =
      List.filled(widget.quizResults.questionsWithUserAnswers.length, false);

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<QuizResultsVM>().saveQuizResults(widget.quizResults);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => context.go(PageRoutePathes.homePage),
        ),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => const InfoDialog(
                text: AppStrings.redForIncorrectGreenForCorrect,
              ),
            ),
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, i) => ExpansionQuizQuestion(
            question: _questionsEntries[i].key,
            userAnswer: _questionsEntries[i].value,
            onExpansionChanged: (v) => _expansionStatus[i] = v,
            initiallyExpanded: _expansionStatus[i],
          ),
          itemCount: _questionsEntries.length,
        ),
      ),
    );
  }
}
