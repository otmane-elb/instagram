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
    // final controller = Get.put(AuthRepo());

    // final dataController = Get.put(Databsecontroller());
    final pagecontroller = Get.put(PagesController());

    int page = 0;

    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: [
            Text("home"),
            Text("home1"),
            Text("home2"),
            Text("home3"),
            Text("home4"),
          ],
          controller: pagecontroller.pageController.value,
        ),
      )

      /*Column(
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
      ),*/
      ,
      bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: Obx(
                  ()=> Icon(
                    Icons.home,
                    color: pagecontroller.page.value == 0 ? primaryColor : secondaryColor,
                  ),
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Obx(
                  ()=> Icon(
                    Icons.search,
                    color: pagecontroller.page.value == 1 ? primaryColor : secondaryColor,
                  ),
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Obx(
                  ()=> Icon(
                    Icons.add_circle,
                    color: pagecontroller.page.value == 2 ? primaryColor : secondaryColor,
                  ),
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Obx(
                  ()=>Icon(
                    Icons.favorite,
                    color: pagecontroller.page.value == 3 ? primaryColor : secondaryColor,
                  ),
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon:Obx(
                  ()=> Icon(
                    Icons.person,
                    color: pagecontroller.page.value == 4 ? primaryColor : secondaryColor,
                  ),
                ),
                backgroundColor: primaryColor),
          ],
          onTap: (int page) {
            pagecontroller.navigationTapped(page);
           
          }),
    );
  }
}
