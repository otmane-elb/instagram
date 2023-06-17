import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/signup_controller.dart';
import 'package:instagramv2/screens/login_screen.dart';
import 'package:instagramv2/utils/colors.dart';
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
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://pbs.twimg.com/profile_images/1326578374085472256/zBYZNAJN_400x400.jpg',
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 64,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    Positioned(
                        left: 80,
                        bottom: -10,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.blueAccent,
                            )))
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  controller: controller.username,
                  hintText: 'Username',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  controller: controller.bio,
                  hintText: 'Bio',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  controller: controller.email,
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  controller: controller.password,
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
                        controller.email.text.trim(),
                        controller.password.text.trim(),
                        controller.username.text,
                        controller.bio.text);
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
                        Get.to(() => LoginScreen());
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
