import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/auth.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthRepo());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home"),
            ElevatedButton(
                onPressed: () {
                  //  controller.logout();
                },
                child: Text("Log out"))
          ],
        ),
      ),
    );
  }
}
