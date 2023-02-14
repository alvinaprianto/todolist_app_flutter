import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/homescreen';
  static route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final now = DateTime.now();
  var formatTime;
  final TextEditingController searchController = TextEditingController();
  var searchText = "";
  final FocusNode focus = FocusNode();
  @override
  void initState() {
    super.initState();
    formatTime = DateFormat("dd-MM-yy").format(now);
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80,
                margin: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                width: double.infinity,
                child: TextField(
                  focusNode: focus,
                  style: const TextStyle(fontSize: 14),
                  controller: searchController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search_outlined),
                      hintText: "Search for your task...",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: greyColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor))),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                    if (value == "") {
                      focus.unfocus();
                    }
                  },
                ),
              ),
              if (searchText != "")
                StreamBuilder(
                    stream: pathDB.onValue,
                    builder: (context, snapshot) {
                      List<Map<String, dynamic>> catatanList = [];
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          (snapshot.data!).snapshot.value != null) {
                        final toJson = Map<dynamic, dynamic>.from(
                            (snapshot.data!).snapshot.value
                                as Map<dynamic, dynamic>);
                        toJson.forEach((key, value) {
                          final modelFromJson =
                              Map<String, dynamic>.from(value);
                          catatanList.add(modelFromJson);
                        });

                        if (searchText != "") {
                          log(catatanList
                              .where(
                                (element) {
                                  return element["title"]
                                      .toString()
                                      .contains(searchText);
                                },
                              )
                              .toList()
                              .toString());
                          List<Map<String, dynamic>> searchCatatanList = [];
                          searchCatatanList.addAll(catatanList.where(
                            (element) {
                              return element["title"]
                                  .toString()
                                  .contains(searchText);
                            },
                          ));
                          return (snapshot.connectionState ==
                                  ConnectionState.waiting)
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchCatatanList.length,
                                  itemBuilder: (context, index) {
                                    return FittedBox(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 16.0,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 8.0,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: greyColor,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: searchCatatanList[index]
                                                            ["is_complete"] ==
                                                        true
                                                    ? true
                                                    : false,
                                                onChanged: ((value) {
                                                  pathDB
                                                      .child(searchCatatanList[
                                                          index]["date"])
                                                      .update({
                                                    "is_complete": value != true
                                                        ? false
                                                        : true
                                                  });
                                                }),
                                                shape: const CircleBorder(),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  if (searchCatatanList[index]
                                                              ["title"]
                                                          .toString() !=
                                                      "")
                                                    Text(
                                                        searchCatatanList[index]
                                                                ["title"]
                                                            .toString()),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    searchCatatanList[index]
                                                                    ["date"]
                                                                .toString()
                                                                .substring(
                                                                    5, 13) ==
                                                            formatTime
                                                        ? "Today At ${searchCatatanList[index]["date"].toString().substring(14)}"
                                                        : searchCatatanList[
                                                                index]["date"]
                                                            .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      if (searchCatatanList[
                                                              index]["tag"] !=
                                                          "null")
                                                        FittedBox(
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        4),
                                                            decoration: BoxDecoration(
                                                                color: Color(int.parse(
                                                                    searchCatatanList[index]["tag"]
                                                                            [
                                                                            "color"]
                                                                        .toString(),
                                                                    radix: 16)),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child: Row(
                                                              children: [
                                                                Image(
                                                                  image:
                                                                      const Svg(
                                                                    icWork,
                                                                  ),
                                                                  height: 20,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.8),
                                                                ),
                                                                const SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Text(
                                                                  searchCatatanList[index]
                                                                              [
                                                                              "tag"]
                                                                          [
                                                                          "title"]
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.8)),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      if (searchCatatanList[
                                                              index]["tag"] !=
                                                          "null")
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                      if (searchCatatanList[
                                                                  index]
                                                              ["priority"] !=
                                                          "null")
                                                        FittedBox(
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4,
                                                                    vertical:
                                                                        4),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                border: Border.all(
                                                                    color:
                                                                        primaryColor,
                                                                    width: 0.8),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                            child: Row(
                                                              children: [
                                                                const Image(
                                                                  image: Svg(
                                                                    icFlag,
                                                                  ),
                                                                  height: 18,
                                                                ),
                                                                Text(
                                                                  searchCatatanList[
                                                                              index]
                                                                          [
                                                                          "priority"]
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ]),
                                      ),
                                    );
                                  },
                                );
                        }
                      }
                      return Container();
                    }),
              if (searchText == "")
                ExpansionTile(
                  maintainState: true,
                  initiallyExpanded: true,
                  title: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 12.0,
                    ),
                    margin: const EdgeInsets.only(right: 200),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: greyColor),
                    child: const Text(
                      "Complete",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  children: [
                    FirebaseAnimatedList(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      query: pathDB.orderByChild("is_complete").equalTo(true),
                      itemBuilder: ((context, snapshot, animation, index) {
                        if (snapshot.exists == true) {
                          var path = snapshot
                              .child("tag")
                              .child("color")
                              .value
                              .toString();

                          return FittedBox(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 8.0,
                              ),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: greyColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value:
                                          snapshot.child("is_complete").value ==
                                                  true
                                              ? true
                                              : false,
                                      onChanged: ((value) {
                                        pathDB
                                            .child(snapshot
                                                .child("date")
                                                .value
                                                .toString())
                                            .update({
                                          "is_complete":
                                              value != true ? false : true
                                        });
                                      }),
                                      shape: const CircleBorder(),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (snapshot
                                                .child("title")
                                                .value
                                                .toString() !=
                                            "")
                                          Text(snapshot
                                              .child("title")
                                              .value
                                              .toString()),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot
                                                      .child("date")
                                                      .value
                                                      .toString()
                                                      .substring(5, 13) ==
                                                  formatTime
                                              ? "Today At ${snapshot.child("date").value.toString().substring(14)}"
                                              : snapshot
                                                  .child("date")
                                                  .value
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            if (snapshot.child("tag").value !=
                                                "null")
                                              FittedBox(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                      color: Color(int.parse(
                                                          path,
                                                          radix: 16)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Row(
                                                    children: [
                                                      Image(
                                                        image: const Svg(
                                                          icWork,
                                                        ),
                                                        height: 20,
                                                        color: Colors.black
                                                            .withOpacity(0.8),
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
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            if (snapshot.child("tag").value !=
                                                "null")
                                              const SizedBox(
                                                width: 12,
                                              ),
                                            if (snapshot
                                                    .child("priority")
                                                    .value !=
                                                "null")
                                              FittedBox(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      border: Border.all(
                                                          color: primaryColor,
                                                          width: 0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Row(
                                                    children: [
                                                      const Image(
                                                        image: Svg(
                                                          icFlag,
                                                        ),
                                                        height: 18,
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .child("priority")
                                                            .value
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ],
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          );
                        } else if (snapshot.exists == false) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
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
                    ),
                  ],
                ),
              if (searchText == "")
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 12.0,
                    ),
                    margin: const EdgeInsets.only(right: 180),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: greyColor),
                    child: const Text(
                      "Uncomplete",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  children: [
                    FirebaseAnimatedList(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      query: pathDB.orderByChild("is_complete").equalTo(false),
                      itemBuilder: ((context, snapshot, animation, index) {
                        if (snapshot.exists == true) {
                          var path = snapshot
                              .child("tag")
                              .child("color")
                              .value
                              .toString();

                          return FittedBox(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 8.0,
                              ),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: greyColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value:
                                          snapshot.child("is_complete").value ==
                                                  true
                                              ? true
                                              : false,
                                      onChanged: ((value) {
                                        pathDB
                                            .child(snapshot
                                                .child("date")
                                                .value
                                                .toString())
                                            .update({
                                          "is_complete":
                                              value != true ? false : true
                                        });
                                      }),
                                      shape: const CircleBorder(),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (snapshot
                                                .child("title")
                                                .value
                                                .toString() !=
                                            "")
                                          Text(snapshot
                                              .child("title")
                                              .value
                                              .toString()),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot
                                                      .child("date")
                                                      .value
                                                      .toString()
                                                      .substring(5, 13) ==
                                                  formatTime
                                              ? "Today At ${snapshot.child("date").value.toString().substring(14)}"
                                              : snapshot
                                                  .child("date")
                                                  .value
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            if (snapshot.child("tag").value !=
                                                "null")
                                              FittedBox(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                      color: Color(int.parse(
                                                          path,
                                                          radix: 16)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Row(
                                                    children: [
                                                      Image(
                                                        image: const Svg(
                                                          icWork,
                                                        ),
                                                        height: 20,
                                                        color: Colors.black
                                                            .withOpacity(0.8),
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
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            if (snapshot.child("tag").value !=
                                                "null")
                                              const SizedBox(
                                                width: 12,
                                              ),
                                            if (snapshot
                                                    .child("priority")
                                                    .value !=
                                                "null")
                                              FittedBox(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      border: Border.all(
                                                          color: primaryColor,
                                                          width: 0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Row(
                                                    children: [
                                                      const Image(
                                                        image: Svg(
                                                          icFlag,
                                                        ),
                                                        height: 18,
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .child("priority")
                                                            .value
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ],
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          );
                        } else if (snapshot.exists == false) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
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
                    ),
                  ],
                ),
            ],
          ),
        ));
  }
}
