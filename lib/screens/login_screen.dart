import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagramv2/screens/signup_screen.dart';
import 'package:instagramv2/utils/colors.dart';
import 'package:instagramv2/utils/constants.dart';
import 'package:instagramv2/widgets/text_field_input.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                height: 64,
                // ignore: deprecated_member_use
                color: primaryColor,
              ),
              const SizedBox(
                height: 64,
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
                  controller.login(controller.email.value.text..trim(),
                      controller.password.value.text.trim());
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      color: Colors.blue),
                  child: const Text('Log in '),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account? "),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SignupScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Sign up",
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
    );
  }
}
