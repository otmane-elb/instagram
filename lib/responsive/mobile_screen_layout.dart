import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/pages.dart';
import 'package:instagramv2/services/get_data.dart';
import 'package:instagramv2/utils/colors.dart';
import 'package:instagramv2/utils/constants.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {

    final dataController = Get.put(Databsecontroller());
    final pagecontroller = Get.put(PagesController());

    return Scaffold(
      body: SafeArea(
        child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pagecontroller.pageController.value,
            onPageChanged: (value) {},
            children: homeScreenItems),
      ),
      bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: Obx(
                  () => Icon(
                    Icons.home,
                    color: pagecontroller.page.value == 0
                        ? primaryColor
                        : secondaryColor,
                  ),
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Obx(
                  () => Icon(
                    Icons.search,
                    color: pagecontroller.page.value == 1
                        ? primaryColor
                        : secondaryColor,
                  ),
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Obx(
                  () => Icon(
                    Icons.add_circle,
                    color: pagecontroller.page.value == 2
                        ? primaryColor
                        : secondaryColor,
                  ),
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Obx(
                  () => Icon(
                    Icons.favorite,
                    color: pagecontroller.page.value == 3
                        ? primaryColor
                        : secondaryColor,
                  ),
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: pagecontroller.page.value == 4
                            ? Colors.white
                            : Colors.transparent,
                        width: 3, // Set the border width
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage:
                          dataController.mUser.value?.photoUrl != null
                              ? CachedNetworkImageProvider(
                                  dataController.mUser.value!.photoUrl)
                              : null,
                    ),
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
