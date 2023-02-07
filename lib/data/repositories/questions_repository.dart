import 'package:quiz_app/models/data/questions/question_difficulty.dart';
import 'package:quiz_app/models/domain/question.dart';

abstract class QuestionsRepository {
  Future<List<Question>> getQuestions({
    List<String>? categories,
    List<String>? tags,
    int? limit,
    QuestionDifficulty? difficulty,
  });
}
