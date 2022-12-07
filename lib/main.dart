import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/config.dart';
import 'package:todolist_app_flutter/core/router.dart';
import 'package:todolist_app_flutter/features/introduction/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: AppRouter.onGenerateRoute,
      title: 'Flutter Demo',
      theme: Config.myTheme,
      home: SplashScreen(),
    );
  }
}
