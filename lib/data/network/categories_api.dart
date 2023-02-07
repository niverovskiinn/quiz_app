import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/data/network/base/base_api.dart';
import 'package:retrofit/retrofit.dart';

part 'categories_api.g.dart';

@RestApi()
@singleton
abstract class CategoriesApi extends BaseApi {
  @factoryMethod
  factory CategoriesApi(Dio dio) = _CategoriesApi;

  @GET('/categories')
  Future<dynamic> getCategories();
}
