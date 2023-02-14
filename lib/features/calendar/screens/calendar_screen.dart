import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todolist_app_flutter/core/constants.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  static const routeName = "/calendarscreen";
  static route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const CalendarScreen());
  }

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final now = DateTime.now();
  var formatTime;
  bool isClickedToday = true;
  bool isClickedCompleted = false;
  var pathQuery = pathDB;

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
          "Calendar",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            daysOfWeekHeight: 0,
            calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: primaryColor,
                    shape: BoxShape.rectangle)),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Container(
            height: 80,
            color: greyColor,
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (() => setState(() {
                            isClickedToday = !isClickedToday;
                            isClickedCompleted = !isClickedCompleted;
                          })),
                      child: Container(
                        decoration: isClickedToday
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: primaryColor)
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white)),
                        child: const Center(child: Text("Today")),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (() => setState(() {
                            isClickedCompleted = !isClickedCompleted;
                            isClickedToday = !isClickedToday;
                          })),
                      child: Container(
                        decoration: isClickedCompleted
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: primaryColor)
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white)),
                        child: const Center(child: Text("Completed")),
                      ),
                    ),
                  )
                ]),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              // physics: const NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              query: pathDB,
              itemBuilder: ((context, snapshot, animation, index) {
                if (snapshot.exists == true) {
                  var path =
                      snapshot.child("tag").child("color").value.toString();

                  if (snapshot
                              .child("date")
                              .value
                              .toString()
                              .substring(5, 13) ==
                          formatTime &&
                      isClickedToday == true) {
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
                                    snapshot.child("is_complete").value == true
                                        ? true
                                        : false,
                                onChanged: ((value) {
                                  pathDB
                                      .child(snapshot
                                          .child("date")
                                          .value
                                          .toString())
                                      .update({
                                    "is_complete": value != true ? false : true
                                  });
                                }),
                                shape: const CircleBorder(),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      if (snapshot.child("tag").value != "null")
                                        FittedBox(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                                color: Color(
                                                    int.parse(path, radix: 16)),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
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
                                                          .withOpacity(0.8)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (snapshot.child("tag").value != "null")
                                        const SizedBox(
                                          width: 12,
                                        ),
                                      if (snapshot.child("priority").value !=
                                          "null")
                                        FittedBox(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 4),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: primaryColor,
                                                    width: 0.8),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
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
                  } else if (snapshot.child("is_complete").value == true &&
                      isClickedCompleted == true) {
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
                                    snapshot.child("is_complete").value == true
                                        ? true
                                        : false,
                                onChanged: ((value) {
                                  pathDB
                                      .child(snapshot
                                          .child("date")
                                          .value
                                          .toString())
                                      .update({
                                    "is_complete": value != true ? false : true
                                  });
                                }),
                                shape: const CircleBorder(),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      if (snapshot.child("tag").value != "null")
                                        FittedBox(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                                color: Color(
                                                    int.parse(path, radix: 16)),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
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
                                                          .withOpacity(0.8)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (snapshot.child("tag").value != "null")
                                        const SizedBox(
                                          width: 12,
                                        ),
                                      if (snapshot.child("priority").value !=
                                          "null")
                                        FittedBox(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 4),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: primaryColor,
                                                    width: 0.8),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
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
                  } else {
                    return Container();
                  }
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
          )
        ],
      ),
    );
  }
}
