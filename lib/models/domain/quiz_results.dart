import 'package:quiz_app/models/domain/category.dart';
import 'package:quiz_app/models/domain/question.dart';

class QuizResults {
  final Map<Question, String> questionsWithUserAnswers;
  final Category category;

  QuizResults({
    required this.questionsWithUserAnswers,
    required this.category,
  });
}
