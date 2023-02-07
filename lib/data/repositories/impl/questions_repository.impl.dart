import 'package:injectable/injectable.dart';
import 'package:quiz_app/data/network/questions_api.dart';
import 'package:quiz_app/data/repositories/questions_repository.dart';
import 'package:quiz_app/models/data/questions/get_questions_query.dart';
import 'package:quiz_app/models/data/questions/question_difficulty.dart';
import 'package:quiz_app/models/domain/question.dart';
import 'package:quiz_app/utils/errors_handler.dart';

@Singleton(as: QuestionsRepository)
class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionsApi _api;
  final ErrorHandler _errorHandler;

  QuestionsRepositoryImpl(this._api, this._errorHandler);

  @override
  Future<List<Question>> getQuestions({
    List<String>? categories,
    List<String>? tags,
    int? limit,
    QuestionDifficulty? difficulty,
  }) async {
    final resp = await _api.getQuestions(
        questionsQuery: GetQuestionsQuery(
      categories: categories,
      tags: tags,
      limit: limit,
      difficulty: difficulty,
    ));

    return resp.map((dto) => Question.fromQuestionDto(dto)).toList();
  }
}
