import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/custom_section_profile.dart';
import '../widgets/custom_section_widget_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = "/profilescreen";

  static route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const ProfileScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: FirebaseAuth.instance.currentUser!.photoURL != null
                    ? Image.network(
                        FirebaseAuth.instance.currentUser!.photoURL!,
                        height: 100,
                        width: 100,
                      )
                    : const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ))),
            Text(
              FirebaseAuth.instance.currentUser!.displayName ?? "Your Name",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Center(child: Text("10 Task left")),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Center(child: Text("5 Task done")),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomSectionProfile(
              title: "Settings",
            ),
            CustomSectionWidgetProfile(
              icon: icNavProfile,
              title: "App Settings",
              onPressed: () {},
            ),
            const SizedBox(
              height: 12,
            ),
            const CustomSectionProfile(
              title: "Account",
            ),
            CustomSectionWidgetProfile(
              icon: icNavProfile,
              title: "Change account name",
              onPressed: (() {}),
            ),
            CustomSectionWidgetProfile(
              icon: icNavProfile,
              title: "Change account password",
              onPressed: (() {}),
            ),
            CustomSectionWidgetProfile(
              icon: icNavProfile,
              title: "Change account image",
              onPressed: (() {}),
            ),
            const SizedBox(
              height: 12,
            ),
            const CustomSectionProfile(
              title: "Uptodo",
            ),
            CustomSectionWidgetProfile(
              icon: icNavProfile,
              title: "About US",
              onPressed: (() {}),
            ),
            CustomSectionWidgetProfile(
              icon: icNavProfile,
              title: "FAQ",
              onPressed: (() {}),
            ),
            CustomSectionWidgetProfile(
              icon: icNavProfile,
              title: "Help & Feedback",
              onPressed: (() {}),
            ),
            CustomSectionWidgetProfile(
              icon: icNavProfile,
              title: "Support US",
              onPressed: (() {}),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Log out",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
