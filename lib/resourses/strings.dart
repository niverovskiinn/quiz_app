abstract class AppStrings {
  static const newQuiz = 'New quiz';
  static const noCategories = 'No categories';
  static const randomQuestions = 'Random questions';
  static const category = 'Category';
  static const yourAnswer = 'Your answer: ';
  static const correctAnswer = 'Correct answer: ';
  static const statistic = 'Statistic';
  static const youHaventTookQuizes = 'You haven\'t took quizes yet';
  static const ok = 'Ok';
  static const statisticDescribePersentCorrectAnswers =
      'Here you can watch statistic of taken quizes by their category and percent of correct answers.';

  static const redForIncorrectGreenForCorrect =
      'Red arrow mean your answer is incorrect\nGreen arrow mean your answer is correct';

  static String youHaventTookQuizesForDays(int days) {
    switch (days) {
      case 0:
        return "You have already taken quiz today.";
      case 1:
        return "You haven't taken quiz for $days day.";
      default:
        return "You haven't taken quiz for $days days.";
    }
  }
}
