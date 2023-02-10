import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          centerTitle: true,
          actions: [
            ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: FirebaseAuth.instance.currentUser!.photoURL != null
                    ? Image.network(
                        FirebaseAuth.instance.currentUser!.photoURL!,
                        height: 38,
                        width: 38,
                      )
                    : const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ))),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: FirebaseAnimatedList(
          query: pathDB,
          itemBuilder: ((context, snapshot, animation, index) {
            if (snapshot.exists == true) {
              var path = snapshot.child("tag").child("color").value.toString();

              var colorTag = Color.fromARGB(
                  int.parse(path.substring(0, 3).toString()),
                  int.parse(path.substring(3, 6).toString()),
                  int.parse(path.substring(6, 9).toString()),
                  int.parse(path.substring(9).toString()));

              return Container(
                height: 100,
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 8.0,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: greyColor, borderRadius: BorderRadius.circular(8)),
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: ((value) {}),
                        shape: const CircleBorder(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.child("title").value.toString()),
                          Text(
                            snapshot.child("date").value.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          FittedBox(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                  color: colorTag,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: [
                                  Image(
                                    image: const Svg(
                                      icWork,
                                    ),
                                    height: 20,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    snapshot
                                        .child("tag")
                                        .child("title")
                                        .value
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.8)),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
              );
            } else if (snapshot.exists == false) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    Image.asset(
                      imgEmptyTask,
                    ),
                    Text(
                      "What do you want to do today?",
                      textAlign: TextAlign.center,
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
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ));
  }
}
