import 'package:injectable/injectable.dart';
import 'package:quiz_app/models/exceptions/fetching_data_exception.dart';
import 'package:quiz_app/models/exceptions/quiz_app_exception.dart';

@singleton
class ErrorHandler {
  QuizAppException handle(e) {
    return FetcingDataException();
  }
}
