import 'package:quiz_app/models/domain/category.dart';

abstract class CategoriesRepository {
  Future<List<Category>> getCategories();
}
