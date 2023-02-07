import 'package:flutter/material.dart';
import 'package:quiz_app/data/repositories/questions_repository.dart';
import 'package:quiz_app/models/domain/category.dart';
import 'package:quiz_app/models/domain/question.dart';

class QuizVM extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  var _questions = <Question>[];
  final _questionsWithUserAnswers = <Question, String>{};
  Map<Question, String> get questionsWithUserAnswers =>
      _questionsWithUserAnswers;
  String? get selectedAnswer =>
      _questionsWithUserAnswers[_questions[_currentQuestionIndex]];

  Question? get currentQuestion => _questions.length > _currentQuestionIndex
      ? _questions[_currentQuestionIndex]
      : null;

  double get processIndicator =>
      _questions.isEmpty ? 0 : _currentQuestionIndex / _questions.length;

  bool get isLast => _currentQuestionIndex + 1 == _questions.length;

  final QuestionsRepository _questionsRepository;

  QuizVM(this._questionsRepository);

  Future<void> initQuestions(Category category, {int limit = 10}) async {
    try {
      _questions = await _questionsRepository.getQuestions(
        categories: [
          category.queryNames.reduce((v, e) => v.length > e.length ? v : e)
        ],
        limit: limit,
      );
      if (_questions.isNotEmpty) {
        _currentQuestionIndex = 0;
      }
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void selectAnswer(String answer) {
    if (currentQuestion != null) {
      _questionsWithUserAnswers[currentQuestion!] = answer;
      notifyListeners();
    }
  }

  void previousQuestion() {
    --_currentQuestionIndex;
    notifyListeners();
  }

  void nextQuestion() {
    ++_currentQuestionIndex;
    notifyListeners();
  }
}
