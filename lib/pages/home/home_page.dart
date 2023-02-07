import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/navigation/page_route_names.dart';
import 'package:quiz_app/pages/home/home_vm.dart';
import 'package:quiz_app/widgets/info_dialog.dart';
import 'package:quiz_app/resourses/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(PageRoutePathes.newQuizPage),
        child: const Icon(Icons.quiz_rounded),
      ),
      appBar: AppBar(
        title: const Text(AppStrings.statistic),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => const InfoDialog(
                text: AppStrings.statisticDescribePersentCorrectAnswers,
              ),
            ),
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: SafeArea(
        child: Consumer<HomeVM>(
          builder: (context, vm, _) {
            if (vm.categoriesStats == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (vm.categoriesStats!.isEmpty) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: Text(
                  AppStrings.youHaventTookQuizes,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (vm.daysFromLastQuiz != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Text(AppStrings.youHaventTookQuizesForDays(
                          vm.daysFromLastQuiz!)),
                    ),
                  ...vm.categoriesStats!.map(
                    (categ) => ListTile(
                      title: Text(categ.title),
                      trailing: Text('${categ.percentOfRightAnswers}%'),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
