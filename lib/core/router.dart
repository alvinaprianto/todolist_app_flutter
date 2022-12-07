import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/features/authentication/screens/login_screen.dart';
import 'package:todolist_app_flutter/features/authentication/screens/register_screen.dart';
import 'package:todolist_app_flutter/features/introduction/screens/onboarding_screen.dart';
import 'package:todolist_app_flutter/features/introduction/screens/splashscreen.dart';
import 'package:todolist_app_flutter/features/introduction/screens/welcome_screen.dart';

import 'main_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Menuju ${settings.name}');
    switch (settings.name) {
      case SplashScreen.routeName:
        return SplashScreen.route();
      case OnBoardingScreen.routeName:
        return OnBoardingScreen.route();
      case WelcomeScreen.routeName:
        return WelcomeScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case RegisterScreen.routeName:
        return RegisterScreen.route();
        case MainScreen.routeName:
        return MainScreen.route();

      default:
        return errorRoute();
    }
  }

  static errorRoute() {
    MaterialPageRoute(
        settings: const RouteSettings(name: "errorRoute"),
        builder: (_) => const Scaffold(
              body: Center(child: Text("Invalid Route")),
            ));
  }
}
