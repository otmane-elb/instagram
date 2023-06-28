import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/signup_controller.dart';
import 'package:instagramv2/screens/login_screen.dart';
import 'package:instagramv2/utils/colors.dart';
import 'package:instagramv2/utils/full_screen_image.dart';
import 'package:instagramv2/widgets/text_field_input.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: Container(),
                ),
                SvgPicture.asset(
                  "assets/ic_instagram.svg",
                  height: 64,
                  color: primaryColor,
                ),
                const SizedBox(
                  height: 64,
                ),
                Obx(() {
                  final Uint8List? imageValue = controller.image.value;

                  return Stack(
                    children: [
                      if (imageValue != null)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenImage(
                                    imageProvider: MemoryImage(imageValue)),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(imageValue),
                          ),
                        )
                      else
                        const CircleAvatar(
                          radius: 64,
                          backgroundImage: AssetImage("assets/profile.png"),
                        ),
                      Positioned(
                        left: 80,
                        bottom: -10,
                        child: IconButton(
                          onPressed: () {
                            controller.selectImage();
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.blueAccent,
                          ),
                        ),
                      )
                    ],
                  );
                }),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  controller: controller.username.value,
                  hintText: 'Username',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  controller: controller.bio.value,
                  hintText: 'Bio',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  controller: controller.email.value,
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  controller: controller.password.value,
                  hintText: 'password',
                  textInputType: TextInputType.visiblePassword,
                  ispassword: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    controller.signup(
                        controller.email.value.text.trim(),
                        controller.password.value.text.trim(),
                        controller.username.value.text,
                        controller.bio.value.text);
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.blue),
                    child: const Text('Sign up '),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("have an account? "),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
