import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/auth.dart';
import 'package:instagramv2/services/get_data.dart';

class MobileScreenLayout extends StatelessWidget {
  MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthRepo());

    final dataController = Get.put(Databsecontroller());

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => Text(dataController.username.value)),
          TextButton(
            onPressed: () {
              controller.logout();
            },
            child: const Text("Logout"),
          ),
          Obx(() {
            if (dataController.mUser != null &&
                dataController.mUser.value != null) {
              return Text(dataController.mUser.value!.bio);
            } else {
              return const Text("Loading...");
            }
          }),
        ],
      ),
    );
  }
}
