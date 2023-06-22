import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/auth.dart';
import 'package:instagramv2/controllers/pages.dart';
import 'package:instagramv2/services/get_data.dart';
import 'package:instagramv2/utils/colors.dart';

class MobileScreenLayout extends StatelessWidget {
  MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthRepo());

    final dataController = Get.put(Databsecontroller());
    final pagecontroller = Get.put(PagesController());

    int _page = 0;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            if (dataController.mUser != null &&
                dataController.mUser.value != null) {
              return Text(dataController.mUser.value!.username);
            } else {
              return const Text("Loading...");
            }
          }),
          TextButton(
            onPressed: () {
              controller.logout();
            },
            child: const Text("Logout"),
          ),
          Obx(() {
            if (dataController.mUser != null &&
                dataController.mUser.value != null) {
              return Text(dataController.mUser.value!.email);
            } else {
              return const Text("Loading...");
            }
          }),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _page == 0 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: _page == 1 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  color: _page == 2 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: _page == 3 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: _page == 4 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor),
          ],
          ),
    );
  }
}
