import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/constants.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  Duration duration = Duration();
  Timer? timer;
  var maxTime = 1;
  var minutes;
  var seconds;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void startTime() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        final second = duration.inSeconds + 1;
        duration = Duration(seconds: second);
      });
    });
  }

  String twoDigits(int n) => n.toString().padLeft(2, "0");

  @override
  Widget build(BuildContext context) {
    minutes = twoDigits(duration.inMinutes.remainder(60));
    seconds = twoDigits(duration.inSeconds.remainder(60));
    

    print(minutes);
    print(seconds);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Focus Mode",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(child: Text("$minutes:$seconds")),
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(primaryColor),
                    color: Colors.white,
                    value: int.parse(minutes.toString()) / maxTime,
                  ),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
