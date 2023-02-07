import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/navigation/page_route_names.dart';
import 'package:quiz_app/pages/splash/splash_vm.dart';
import 'package:quiz_app/resourses/images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await context.read<SplashVM>().loadResourses();
      // ignore: use_build_context_synchronously
      context.go(PageRoutePathes.homePage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Image.asset(AppImages.logo),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
