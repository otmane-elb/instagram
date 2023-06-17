import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/auth.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final username = TextEditingController();
  final bio = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  void signup(
    String email,
    String password,
    String username,
    String bio,
  ) async {
    AuthRepo.instance
        .createUserWithEmailAndPassword(email, password, username, bio);
  }
}
