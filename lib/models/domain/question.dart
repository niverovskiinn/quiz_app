import 'package:quiz_app/models/data/questions/question_difficulty.dart';
import 'package:quiz_app/models/data/questions/question_dto.dart';
import 'package:quiz_app/models/data/questions/question_type.dart';

class Question {
  final String id;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final String question;
  final List<String> tags;
  final QuestionType type;
  final QuestionDifficulty? difficulty;
  final List<String> regions;
  final bool isNiche;
  late final List<String> allAnswers;

  Question({
    required this.id,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.question,
    required this.tags,
    required this.type,
    required this.difficulty,
    required this.regions,
    required this.isNiche,
  }) {
    final ans = List<String>.from(incorrectAnswers);
    ans.add(correctAnswer);
    ans.shuffle();
    allAnswers = ans;
  }

  factory Question.fromQuestionDto(QuestionDto dto) => Question(
      id: dto.id,
      correctAnswer: dto.correctAnswer,
      incorrectAnswers: dto.incorrectAnswers,
      question: dto.question,
      tags: dto.tags,
      type: dto.type,
      difficulty: dto.difficulty,
      regions: dto.regions,
      isNiche: dto.isNiche);
}
