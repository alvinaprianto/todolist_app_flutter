import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const routeName = '/mainscreen';

  static route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => MainScreen());
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
