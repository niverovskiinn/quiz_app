import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/data/network/base/base_api.dart';
import 'package:retrofit/retrofit.dart';
import 'package:quiz_app/models/data/questions/get_questions_query.dart';
import 'package:quiz_app/models/data/questions/question_dto.dart';

part 'questions_api.g.dart';

@RestApi()
@singleton
abstract class QuestionsApi extends BaseApi {
  @factoryMethod
  factory QuestionsApi(Dio dio) = _QuestionsApi;

  @GET('/questions')
  Future<List<QuestionDto>> getQuestions(
      {@Queries() GetQuestionsQuery? questionsQuery});
}
