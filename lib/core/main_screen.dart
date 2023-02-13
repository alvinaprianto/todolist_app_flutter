import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:todolist_app_flutter/features/task/screens/home_screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:todolist_app_flutter/features/user/screens/profile_screen.dart';

import '../features/task/models/category.dart';
import '../features/task/models/task.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const routeName = '/mainscreen';

  static route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const MainScreen());
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _myPage = PageController(initialPage: 0);
  int _currentIndex = 0;
  final _db = FirebaseDatabase.instance.ref("ToDo");
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(
                      Icons.home_outlined,
                      color: _currentIndex == 0 ? primaryColor : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _myPage.jumpToPage(0);
                      });
                    },
                  ),
                  Text(
                    "Home",
                    style: _currentIndex == 0
                        ? Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: primaryColor)
                        : Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                    iconSize: 30.0,
                    icon: Image(
                      image: const Svg(icNavCalendar, size: Size(25, 25)),
                      color: _currentIndex == 1 ? primaryColor : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _myPage.jumpToPage(1);
                      });
                    },
                  ),
                  Text(
                    "Calendar",
                    style: _currentIndex == 1
                        ? Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: primaryColor)
                        : Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              Column(
                children: [
                  IconButton(
                    iconSize: 30.0,
                    icon: Image(
                      image: const Svg(icNavFocuse, size: Size(25, 25)),
                      color: _currentIndex == 2 ? primaryColor : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _myPage.jumpToPage(2);
                      });
                    },
                  ),
                  Text(
                    "Focus",
                    style: _currentIndex == 2
                        ? Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: primaryColor)
                        : Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                    iconSize: 30.0,
                    icon: Image(
                      image: const Svg(icNavProfile, size: Size(25, 25)),
                      color: _currentIndex == 3 ? primaryColor : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _myPage.jumpToPage(3);
                      });
                    },
                  ),
                  Text(
                    "Profile",
                    style: _currentIndex == 3
                        ? Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: primaryColor)
                        : Theme.of(context).textTheme.bodySmall,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _myPage,
        onPageChanged: ((value) {
          setState(() {
            _currentIndex = value;
          });
        }),
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          HomeScreen(),
          Center(
            child: Text('Empty Body 1'),
          ),
          Center(
            child: Text('Empty Body 2'),
          ),
          ProfileScreen()
        ],
      ),
      floatingActionButton: SizedBox(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () async {
              Map<String, dynamic>? result = await addTask(context);

              DateTime now = DateTime.now();

              var nowDate = now.formatDate();

              if (result != null && result["isSend"] == true) {
                Task model = result["model"];
                _db
                    .child(_auth.currentUser!.email!
                        .substring(0, _auth.currentUser!.email!.indexOf("@")))
                    .child(model.date ?? nowDate)
                    .set({
                  "title": (model.title != "" ? model.title : "Untitled"),
                  "desc":
                      (model.description != "" ? model.description : "null"),
                  "date": (model.date ?? nowDate),
                  "tag": model.category != null
                      ? {
                          "title": model.category!.title,
                          "img": model.category!.img,
                          "color": model.category!.colorHex
                        }
                      : "null",
                  "priority": (model.priority ?? "null"),
                  "is_complete": model.isComplete
                });
              }
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            // elevation: 5.0,
          ),
        ),
      ),
    );
  }

  Future<String?> _showCalender() async {
    var selectedDate = DateTime.now();
    String? selectedDateString;
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      helpText: 'Select Time',
      cancelText: 'Cancel',
      confirmText: 'Choose Time',
    );
    if (selected != null && selected != selectedDate) {
      await _showTime().then((value) {
        if (value != null) {
          setState(() {
            selectedDate = selected;

            selectedDateString = selectedDate.formatDate();
          });
        }
      });
    }
    return selectedDateString;
  }

  Future<String?> _showTime() async {
    var selectedTime = TimeOfDay.now();
    String? selectedString;
    final TimeOfDay? selected = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        confirmText: "Save",
        cancelText: "Cancel");
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
        selectedString = "${selectedTime.hour}:${selectedTime.minute}";
      });
    } else if (selected != null && selected == selectedTime) {
      setState(() {
        selectedString = "${selectedTime.hour}:${selectedTime.minute}";
      });
    }
    return selectedString;
  }

  Future<Category?> addCategory() async {
    List<Category> categories = Category.generateList();
    int? selectedIndex;
    return await showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: ((context, setState) {
                return SimpleDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: greyColor,
                  title: Text(
                    "Choose Category",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  children: [
                    Container(
                      height: 1.2,
                      margin: const EdgeInsets.only(bottom: 12),
                      color: Colors.white,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 300,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                          itemCount: Category.generateList().length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 30,
                                  mainAxisExtent: 80,
                                  crossAxisCount: 3),
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: (() {
                                            if (selectedIndex == index) {
                                              return Color(int.parse(
                                                      categories[index]
                                                          .colorHex,
                                                      radix: 16))
                                                  .withOpacity(0.6);
                                            } else {
                                              return Color(int.parse(
                                                  categories[index].colorHex,
                                                  radix: 16));
                                            }
                                          }()),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                          child: Image(
                                        image: Svg(categories[index].img),
                                      )),
                                    ),
                                    Text(
                                      categories[index].title,
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ]),
                            );
                          })),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50))),
                        onPressed: () {
                          Navigator.of(context).pop(selectedIndex != null
                              ? categories[selectedIndex!]
                              : null);
                          // print(categories[selectedIndex!].color);
                        },
                        child: const Text("Add Category"),
                      ),
                    )
                  ],
                );
              }),
            ));
  }

  Future<int?> addPriority() async {
    int? selectedIndex;
    return await showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: ((context, setState) {
                return SimpleDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: greyColor,
                  title: Text(
                    "Choose Priority",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  children: [
                    Container(
                      height: 1.2,
                      margin: const EdgeInsets.only(bottom: 12),
                      color: Colors.white,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 300,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                          itemCount: 10,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 30,
                                  mainAxisExtent: 80,
                                  crossAxisCount: 3),
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: (() {
                                      if (selectedIndex == index) {
                                        return primaryColor;
                                      } else {
                                        return const Color.fromRGBO(0, 0, 0, 1)
                                            .withOpacity(0.8);
                                      }
                                    }()),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: [
                                    const Image(
                                      image: Svg(icFlag),
                                    ),
                                    Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(double.infinity, 50))),
                              onPressed: () {
                                Navigator.of(context).pop(selectedIndex);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryColor),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(double.infinity, 50))),
                              onPressed: () {
                                Navigator.of(context).pop(selectedIndex! + 1);
                              },
                              child: const Text("Save"),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
            ));
  }

  Future<Map<String, dynamic>?> addTask(BuildContext context) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    String? selectedDate;
    Category? selectedCategory;
    int? selectedPriority;
    var isSend = false;
    return await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: greyColor,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Add Task',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: TextField(
                      controller: titleController,
                      textInputAction: TextInputAction.next,
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white.withOpacity(0.6)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                      autofocus: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: TextField(
                      controller: descController,
                      textInputAction: TextInputAction.done,
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: InputDecoration(
                          hintText: 'Description',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white.withOpacity(0.6)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () async {
                            var result = await _showCalender();
                            if (result != null) {
                              setState(() {
                                selectedDate = result;
                              });
                            }
                          },
                          icon: Image(
                              image: const Svg(
                                icTimer,
                                size: Size(25, 25),
                              ),
                              color: selectedDate == null
                                  ? Colors.white
                                  : primaryColor)),
                      IconButton(
                          onPressed: () async {
                            var result = await addCategory();
                            if (result != null) {
                              setState(() {
                                selectedCategory = result;
                              });
                            }
                          },
                          icon: Image(
                              image: const Svg(
                                icTag,
                                size: Size(25, 25),
                              ),
                              color: selectedCategory == null
                                  ? Colors.white
                                  : primaryColor)),
                      IconButton(
                          onPressed: () async {
                            var result = await addPriority();
                            if (result != null) {
                              setState(() {
                                selectedPriority = result;
                              });
                            }
                          },
                          icon: Image(
                              image: const Svg(icFlag, size: Size(25, 25)),
                              color: selectedPriority == null
                                  ? Colors.white
                                  : primaryColor)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Task model = Task(
                                title: titleController.text,
                                description: descController.text,
                                date: selectedDate,
                                category: selectedCategory,
                                priority: selectedPriority,
                                isComplete: false);
                            model.toJson();
                            setState(() {
                              isSend = true;
                            });
                            Navigator.of(context)
                                .pop({"isSend": isSend, "model": model});
                          },
                          icon: const Image(
                            image: Svg(icSend, size: Size(25, 25)),
                          ))
                    ],
                  )
                ],
              ),
            ));
  }
}

extension Format on DateTime {
  String formatDate() {
    return DateFormat("EEE, dd-MM-yy hh:mm:ss", null).format(this);
  }
}
