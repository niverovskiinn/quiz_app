import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/models/data/statistic/category_statistic_dto.dart';

part 'category_statistic.freezed.dart';

@freezed
class CategoryStatistic with _$CategoryStatistic {
  const CategoryStatistic._();
  const factory CategoryStatistic({
    required String title,
    required int questionsCount,
    required int rightAnsweredQuestions,
  }) = _CategoryStatistic;

  int get percentOfRightAnswers =>
      (rightAnsweredQuestions / questionsCount * 100).toInt();

  factory CategoryStatistic.fromDto(CategoryStatisticDto dto) =>
      CategoryStatistic(
        title: dto.title,
        questionsCount: dto.questionsCount,
        rightAnsweredQuestions: dto.rightAnsweredQuestions,
      );
  CategoryStatisticDto toDto() => CategoryStatisticDto(
        title: title,
        questionsCount: questionsCount,
        rightAnsweredQuestions: rightAnsweredQuestions,
      );
}
