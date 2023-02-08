import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/constants.dart';
import 'package:todolist_app_flutter/features/introduction/screens/welcome_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../widgets/onboarding_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const routeName = '/onboardingscreen';

  static route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const OnBoardingScreen());
  }

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final Map<String, List<String>> imgOnboardList = {
    imgOnboard1: [
      'Manage your tasks',
      'You can easily manage all of your daily tasks in DoMe for free'
    ],
    imgOnboard2: [
      'Create daily routine',
      'In Uptodo  you can create your personalized routine to stay productive'
    ],
    imgOnboard3: [
      'Orgonaize your tasks',
      'You can organize your daily tasks by adding your tasks into separate categories'
    ]
  };
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 400,
        leading: GestureDetector(
          onTap: () {
            storage.write(key: "isFirstRun", value: "false");
            Navigator.of(context).pushReplacementNamed("/welcomescreen");
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'SKIP',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.grey),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OnBoardingWidget(
              pageController: _pageController,
              imgOnboardList: imgOnboardList,
              currentPage: _currentPage,
              onTap: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      child: Container(
                          height: 48,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Back',
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                    )),
                          ))),
                  GestureDetector(
                      onTap: () {
                        if (_currentPage == imgOnboardList.length - 1) {
                          storage.write(key: "isFirstRun", value: "false");
                          Navigator.of(context)
                              .pushReplacementNamed("/welcomescreen");
                        }
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      child: Container(
                          height: 48,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: colorButton,
                          ),
                          child: Center(
                            child: Text('Next',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ))),
                ],
              ),
            )
          ]),
    );
  }
}
