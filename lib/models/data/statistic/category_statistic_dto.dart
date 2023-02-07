import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_statistic_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryStatisticDto {
  final String title;
  final int questionsCount;
  final int rightAnsweredQuestions;

  CategoryStatisticDto({
    required this.title,
    required this.questionsCount,
    required this.rightAnsweredQuestions,
  });

  factory CategoryStatisticDto.fromJson(Map<String, Object?> json) =>
      _$CategoryStatisticDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryStatisticDtoToJson(this);
}
