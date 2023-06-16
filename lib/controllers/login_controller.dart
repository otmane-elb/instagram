import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/auth.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  void login(String email, String password) async {
    AuthRepo.instance.loginUserWithEmailAndPassword(email, password);
  }
}
