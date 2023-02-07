import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/resourses/strings.dart';

class InfoDialog extends StatelessWidget {
  final String text;
  const InfoDialog({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () => context.pop(),
              child: const Text(AppStrings.ok),
            )
          ],
        ),
      ),
    );
  }
}
