import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/utils/configs.dart';

@module
abstract class DioModule {
  @singleton
  Dio get dio {
    final dio = Dio(BaseOptions(baseUrl: AppConfigs.apiUrl));
    dio.interceptors.add(PrettyDioLogger(
      canShowLog: true,
      queryParameters: true,
      requestBody: true,
      // logPrint: logger.d,
    ));
    return dio;
  }
}
