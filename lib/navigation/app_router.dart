import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/domain/category.dart';
import 'package:quiz_app/models/domain/quiz_results.dart';
import 'package:quiz_app/navigation/page_route_names.dart';
import 'package:quiz_app/pages/home/home_page.dart';
import 'package:quiz_app/pages/home/home_vm.dart';
import 'package:quiz_app/pages/new_quiz/new_quiz_page.dart';
import 'package:quiz_app/pages/new_quiz/new_quiz_vm.dart';
import 'package:quiz_app/pages/quiz/quiz_page.dart';
import 'package:quiz_app/pages/quiz/quiz_vm.dart';
import 'package:quiz_app/pages/quiz_results/quiz_results_page.dart';
import 'package:quiz_app/pages/quiz_results/quiz_results_vm.dart';
import 'package:quiz_app/pages/splash/splash_page.dart';
import 'package:quiz_app/pages/splash/splash_vm.dart';
import 'package:quiz_app/utils/service_locator.dart';

@singleton
class AppRouter {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: PageRoutePathes.splashPage,
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => SplashVM(),
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        path: PageRoutePathes.homePage,
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => HomeVM(serviceLocator.get()),
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: PageRoutePathes.newQuizPage,
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => NewQuizVM(serviceLocator.get()),
          child: const NewQuizPage(),
        ),
      ),
      GoRoute(
        path: PageRoutePathes.quizPage,
        builder: (context, state) {
          final json = state.queryParametersAll;
          assert(json.containsKey('title') && json.containsKey('queryNames'));
          final categ = Category(json['title']!.first, json['queryNames']!);
          return ChangeNotifierProvider(
            create: (context) => QuizVM(serviceLocator.get()),
            child: QuizPage(category: categ),
          );
        },
      ),
      GoRoute(
        path: PageRoutePathes.quizResultsPage,
        builder: (context, state) {
          assert(state.extra is QuizResults);
          return ChangeNotifierProvider(
            create: (context) => QuizResultsVM(serviceLocator.get()),
            child: QuizResultsPage(
              quizResults: state.extra as QuizResults,
            ),
          );
        },
      ),
    ],
  );

  GoRouter get router => _router;
}
