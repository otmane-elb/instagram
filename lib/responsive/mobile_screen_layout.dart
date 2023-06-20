import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/auth.dart';
import 'package:instagramv2/services/get_data.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  final controller = Get.put(AuthRepo());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("This is mobile"),
          TextButton(
            onPressed: () {
              controller.logout();
            },
            child: const Text("Logout"),
          ),
          TextButton(
            onPressed: () {
              getUsername();
            },
            child: const Text("print"),
          ),
        ],
      ),
    );
  }
}
