import 'dart:async';

import 'package:quiz_app/models/data/statistic/statistic_dto.dart';

abstract class StatisticRepository {
  FutureOr<StatisticDto?> getStatistic();
  Future<void> writeStatistic(StatisticDto dto);
}
