import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app/data/repositories/categories_repository.dart';
import 'package:quiz_app/models/domain/category.dart';

class NewQuizVM extends ChangeNotifier {
  List<Category>? categories;
  final CategoriesRepository _categoriesRepository;

  NewQuizVM(this._categoriesRepository) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final categories = await _categoriesRepository.getCategories();
      this.categories = categories;
    } catch (e) {
      categories = [];
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Category? selectRandom() {
    if (categories != null) {
      final i = Random().nextInt(categories!.length);
      return categories![i];
    }
    return null;
  }
}
