import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const routeName = '/welcomescreen';

  static route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const WelcomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Welcome to App Todo',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(width: 0.0, height: 40),
          Text(
            'Please login to your account or create new account to continue',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/loginscreen");
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: primaryColor),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/registerscreen");
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.black),
              child: Center(
                child: Text(
                  'create account'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
