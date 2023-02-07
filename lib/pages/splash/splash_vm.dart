import 'package:flutter/material.dart';

class SplashVM extends ChangeNotifier {
  bool routeNext = false;
  Future<void> loadResourses() async {
    await Future.delayed(const Duration(seconds: 1));
    routeNext = true;
    notifyListeners();
  }
}
