import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/models/data/questions/question_difficulty.dart';

part 'get_questions_query.freezed.dart';
part 'get_questions_query.g.dart';

@freezed
class GetQuestionsQuery with _$GetQuestionsQuery {
  const factory GetQuestionsQuery({
    required List<String>? categories,
    required List<String>? tags,
    required int? limit,
    required QuestionDifficulty? difficulty,
  }) = _GetQuestionsQuery;

  factory GetQuestionsQuery.fromJson(Map<String, Object?> json) =>
      _$GetQuestionsQueryFromJson(json);
}
