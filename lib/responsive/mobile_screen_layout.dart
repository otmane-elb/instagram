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
      body: Center(
        child: Column(
          children: [
            Text("This is mobile"),
            TextButton(
              onPressed: () {
                controller.logout();
              },
              child: Text("Logout"),
            ),
            TextButton(
              onPressed: () {
                getUsername();
              },
              child: Text("print"),
            ),
          ],
        ),
      ),
    );
  }
}
