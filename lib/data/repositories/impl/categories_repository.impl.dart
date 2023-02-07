import 'package:injectable/injectable.dart';
import 'package:quiz_app/data/network/categories_api.dart';
import 'package:quiz_app/data/repositories/categories_repository.dart';
import 'package:quiz_app/models/domain/category.dart';
import 'package:quiz_app/utils/errors_handler.dart';

@Singleton(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesApi _api;
  final ErrorHandler _errorHandler;
  CategoriesRepositoryImpl(this._api, this._errorHandler);

  @override
  Future<List<Category>> getCategories() async {
    final Map<String, dynamic> resp = await _api.getCategories();
    return resp.entries
        .map((e) => Category(e.key, List<String>.from(e.value)))
        .toList();
  }
}
