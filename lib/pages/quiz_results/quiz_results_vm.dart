import 'package:flutter/material.dart';
import 'package:quiz_app/data/repositories/statistic_repository.dart';
import 'package:quiz_app/models/data/statistic/category_statistic_dto.dart';
import 'package:quiz_app/models/data/statistic/statistic_dto.dart';
import 'package:quiz_app/models/domain/category_statistic.dart';
import 'package:quiz_app/models/domain/quiz_results.dart';

class QuizResultsVM extends ChangeNotifier {
  final StatisticRepository _statisticRepository;

  QuizResultsVM(this._statisticRepository);
  Future<void> saveQuizResults(QuizResults quizResults) async {
    final questionsCount = quizResults.questionsWithUserAnswers.length;
    final rightAnswers = quizResults.questionsWithUserAnswers.entries
        .where((e) => e.value == e.key.correctAnswer)
        .length;
    final statistic = await _statisticRepository.getStatistic();

    if (statistic != null) {
      final categStatDtoIndex = statistic.categoriesStatistic
          .indexWhere((dto) => dto.title == quizResults.category.title);
      if (categStatDtoIndex >= 0) {
        final categStatOld = CategoryStatistic.fromDto(
            statistic.categoriesStatistic[categStatDtoIndex]);

        final categStatNew = categStatOld.copyWith(
          questionsCount: categStatOld.questionsCount + questionsCount,
          rightAnsweredQuestions:
              categStatOld.rightAnsweredQuestions + rightAnswers,
        );
        statistic.categoriesStatistic[categStatDtoIndex] = categStatNew.toDto();

        await _statisticRepository.writeStatistic(
          StatisticDto(
              categoriesStatistic: statistic.categoriesStatistic,
              lastQuizTime: DateTime.now()),
        );
      } else {
        final categStatDto = CategoryStatisticDto(
          title: quizResults.category.title,
          questionsCount: questionsCount,
          rightAnsweredQuestions: rightAnswers,
        );
        statistic.categoriesStatistic.add(categStatDto);
        await _statisticRepository.writeStatistic(
          StatisticDto(
              categoriesStatistic: statistic.categoriesStatistic,
              lastQuizTime: DateTime.now()),
        );
      }
    } else {
      final statistic = StatisticDto(
        categoriesStatistic: [
          CategoryStatisticDto(
            title: quizResults.category.title,
            questionsCount: questionsCount,
            rightAnsweredQuestions: rightAnswers,
          )
        ],
        lastQuizTime: DateTime.now(),
      );

      await _statisticRepository.writeStatistic(statistic);
    }
  }
}
