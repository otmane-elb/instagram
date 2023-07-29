import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/pages.dart';
import 'package:instagramv2/utils/colors.dart';
import 'package:instagramv2/utils/constants.dart';

import '../services/get_data.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.put(Databsecontroller());
    final pagecontroller = Get.put(PagesController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/ic_instagram.svg",
          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
          height: 32,
        ),
        actions: [
          IconButton(
              onPressed: () {
                pagecontroller.navigationTapped(0);
              },
              icon: Obx(
                () => Icon(
                  Icons.home,
                  color: pagecontroller.page.value == 0
                      ? primaryColor
                      : secondaryColor,
                ),
              )),
          IconButton(
            onPressed: () {
              pagecontroller.navigationTapped(1);
            },
            icon: Obx(
              () => Icon(
                Icons.search,
                color: pagecontroller.page.value == 1
                    ? primaryColor
                    : secondaryColor,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              pagecontroller.navigationTapped(2);
            },
            icon: Obx(
              () => Icon(
                Icons.add_circle,
                color: pagecontroller.page.value == 2
                    ? primaryColor
                    : secondaryColor,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              pagecontroller.navigationTapped(3);
            },
            icon: Obx(
              () => Icon(
                Icons.favorite,
                color: pagecontroller.page.value == 3
                    ? primaryColor
                    : secondaryColor,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              pagecontroller.navigationTapped(4);
            },
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
                  backgroundImage: dataController.mUser.value?.photoUrl != null
                      ? CachedNetworkImageProvider(
                          dataController.mUser.value!.photoUrl)
                      : null,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pagecontroller.pageController.value,
            onPageChanged: (value) {},
            children: homeScreenItems),
      ),
    );
  }
}
