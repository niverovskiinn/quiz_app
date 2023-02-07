import 'package:flutter/material.dart';
import 'package:quiz_app/navigation/app_router.dart';
import 'package:quiz_app/utils/service_locator.dart';

Future<void> main() async {
  await Future.wait([
    configureDependencies(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        toggleButtonsTheme: ToggleButtonsThemeData(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      routerConfig: serviceLocator.get<AppRouter>().router,
    );
  }
}
