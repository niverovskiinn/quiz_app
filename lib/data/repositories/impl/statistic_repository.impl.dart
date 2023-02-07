import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiz_app/data/repositories/statistic_repository.dart';
import 'package:quiz_app/models/data/statistic/statistic_dto.dart';
import 'package:quiz_app/utils/errors_handler.dart';

@Singleton(as: StatisticRepository)
class StatisticRepositoryImpl implements StatisticRepository {
  final _kStatistic = 'statistic';

  final SharedPreferences _sharedPreferences;
  final ErrorHandler _errorHandler;

  StatisticRepositoryImpl(this._sharedPreferences, this._errorHandler);

  @override
  FutureOr<StatisticDto?> getStatistic() async {
    final val = _sharedPreferences.getString(_kStatistic);
    if (val != null) {
      return StatisticDto.fromJson(jsonDecode(val));
    }
    return null;
  }

  @override
  Future<void> writeStatistic(StatisticDto dto) async =>
      await _sharedPreferences.setString(_kStatistic, jsonEncode(dto.toJson()));
}
