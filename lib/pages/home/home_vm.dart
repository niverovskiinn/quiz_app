import 'package:flutter/material.dart';
import 'package:quiz_app/data/repositories/statistic_repository.dart';
import 'package:quiz_app/models/domain/category_statistic.dart';

class HomeVM extends ChangeNotifier {
  final StatisticRepository _statisticRepository;
  int? daysFromLastQuiz;
  List<CategoryStatistic>? categoriesStats;

  HomeVM(this._statisticRepository) {
    initStats();
  }

  Future<void> initStats() async {
    final stats = await _statisticRepository.getStatistic();
    if (stats != null) {
      daysFromLastQuiz = DateTime.now().difference(stats.lastQuizTime).inDays;
      categoriesStats = stats.categoriesStatistic
          .map((dto) => CategoryStatistic.fromDto(dto))
          .toList();
    } else {
      categoriesStats = [];
    }

    notifyListeners();
  }
}
