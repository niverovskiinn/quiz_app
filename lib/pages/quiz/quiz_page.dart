import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/domain/category.dart';
import 'package:quiz_app/models/domain/quiz_results.dart';
import 'package:quiz_app/navigation/page_route_names.dart';
import 'package:quiz_app/pages/quiz/quiz_vm.dart';

class QuizPage extends StatefulWidget {
  final Category category;
  const QuizPage({Key? key, required this.category}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<QuizVM>().initQuestions(widget.category);
    });
  }

  void rightBtnAction(QuizVM vm) {
    if (vm.isLast) {
      context.go(PageRoutePathes.quizResultsPage,
          extra: QuizResults(
              questionsWithUserAnswers: vm.questionsWithUserAnswers,
              category: widget.category));
    } else {
      vm.nextQuestion();
    }
  }

  Widget _buildBody(BuildContext context) {
    final vm = context.watch<QuizVM>();
    if (vm.currentQuestion == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            height: 2,
            width: double.infinity,
            decoration: ShapeDecoration(
              shape: const StadiumBorder(),
              color: Theme.of(context).primaryColorLight,
            ),
            alignment: Alignment.centerLeft,
            child: LayoutBuilder(builder: (context, constraints) {
              final w = constraints.maxWidth * vm.processIndicator;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                constraints: BoxConstraints.expand(width: w),
                decoration: ShapeDecoration(
                  shape: const StadiumBorder(),
                  color: Theme.of(context).primaryColorDark,
                ),
              );
            }),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Text(
              vm.currentQuestion?.question ?? '',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: ToggleButtons(
                    direction: Axis.vertical,
                    onPressed: (int index) =>
                        vm.selectAnswer(vm.currentQuestion!.allAnswers[index]),
                    isSelected: vm.currentQuestion!.allAnswers
                        .map((e) => e == vm.selectedAnswer)
                        .toList(),
                    children: vm.currentQuestion!.allAnswers
                        .map(
                          (ans) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(ans),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (vm.processIndicator > 0)
                    IconButton(
                        onPressed: () => vm.previousQuestion(),
                        icon: const Icon(Icons.arrow_back_ios)),
                  const Spacer(),
                  if (vm.selectedAnswer != null)
                    IconButton(
                      onPressed: () => rightBtnAction(vm),
                      icon: Icon(
                        vm.isLast ? Icons.check : Icons.arrow_forward_ios,
                      ),
                    ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildBody(context),
        ),
      ),
    );
  }
}
