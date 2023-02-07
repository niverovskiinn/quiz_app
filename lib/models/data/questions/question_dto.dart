import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/models/data/questions/question_difficulty.dart';
import 'package:quiz_app/models/data/questions/question_type.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionDto {
  final String id;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final String question;
  final List<String> tags;
  final QuestionType type;
  final QuestionDifficulty? difficulty;
  final List<String> regions;
  final bool isNiche;

  QuestionDto({
    required this.id,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.question,
    required this.tags,
    required this.type,
    required this.difficulty,
    required this.regions,
    required this.isNiche,
  });

  factory QuestionDto.fromJson(Map<String, Object?> json) =>
      _$QuestionDtoFromJson(json);
}
