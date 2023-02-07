import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/domain/category.dart';
import 'package:quiz_app/navigation/page_route_names.dart';
import 'package:quiz_app/pages/new_quiz/new_quiz_vm.dart';
import 'package:quiz_app/resourses/strings.dart';

class NewQuizPage extends StatefulWidget {
  const NewQuizPage({Key? key}) : super(key: key);

  @override
  State<NewQuizPage> createState() => _NewQuizPageState();
}

class _NewQuizPageState extends State<NewQuizPage> {
  void _goToQuizPage(Category category) {
    context.push(
        Uri(path: PageRoutePathes.quizPage, queryParameters: category.toJson())
            .toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.category),
      ),
      body: Builder(
        builder: (context) {
          final vm = context.watch<NewQuizVM>();
          if (vm.categories == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (vm.categories!.isEmpty) {
            return Center(
              child: Text(
                AppStrings.noCategories,
                style: Theme.of(context).textTheme.headline1,
              ),
            );
          }
          return ListView.separated(
            itemBuilder: (context, i) {
              if (i == 0) {
                return ListTile(
                  title: const Text(AppStrings.randomQuestions),
                  onTap: () {
                    final randomCategory = vm.selectRandom();
                    if (randomCategory != null) {
                      _goToQuizPage(randomCategory);
                    }
                  },
                );
              }

              return ListTile(
                title: Text(vm.categories![i - 1].title),
                onTap: () => _goToQuizPage(vm.categories![i - 1]),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: vm.categories!.length + 1,
          );
        },
      ),
    );
  }
}
