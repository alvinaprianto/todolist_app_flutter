import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/homescreen';
  static route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imgEmptyTask),
        Text(
          "What do you want to do today?",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Tap + to add your tasks",
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
