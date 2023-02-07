import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/models/data/statistic/category_statistic_dto.dart';

part 'statistic_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class StatisticDto {
  final List<CategoryStatisticDto> categoriesStatistic;
  final DateTime lastQuizTime;

  StatisticDto({
    required this.categoriesStatistic,
    required this.lastQuizTime,
  });

  factory StatisticDto.fromJson(Map<String, Object?> json) =>
      _$StatisticDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticDtoToJson(this);
}
