import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

const imgOnboard1 = "images/onboard1.png";
const imgOnboard2 = 'images/onboard2.png';
const imgOnboard3 = 'images/onboard3.png';
const imgSplashscreen = 'images/splashscreen.png';
const imgEmptyTask = 'images/empty-task.png';

const icNavHome = 'icons/home-2.svg';
const icNavCalendar = 'icons/calendar.svg';
const icNavFocuse = 'icons/clock.svg';
const icNavProfile = 'icons/user.svg';

const icTimer = 'icons/timer.svg';
const icTag = 'icons/tag.svg';
const icFlag = 'icons/flag.svg';
const icSend = 'icons/send.svg';

const icWork = 'icons/icon_work.svg';
const icUniversity = 'icons/icon_university.svg';

final pathDB = FirebaseDatabase.instance.ref("ToDo").child(FirebaseAuth
    .instance.currentUser!.email!
    .substring(0, FirebaseAuth.instance.currentUser!.email!.indexOf("@")));

const Color primaryColor = Color(0xFF8875FF);
const Color greyColor = Color.fromARGB(255, 49, 49, 49);

const Color category1 = Color(0xFFC1FF84);
const Color category2 = Color(0xFFFF9680);
const Color category3 = Color(0xFF80FFFF);
const Color category4 = Color(0xFF80FFD9);
const Color category5 = Color(0xFF809CFF);
const Color category6 = Color(0xFFFF80EB);
const Color category7 = Color(0xFFFC80FF);
const Color category8 = Color(0xFF80FFA3);
const Color category9 = Color(0xFF80D1FF);
const Color category10 = Color(0xFFFFCC80);
const Color createCategory = Color(0xFF80FFD1);