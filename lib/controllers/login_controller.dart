import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/auth.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  // Add Rx<TextEditingController> for each text field
  final email = TextEditingController().obs;
  final password = TextEditingController().obs;

  // Add Rx<bool> to track whether the fields are empty or not
  final isEmailEmpty = false.obs;
  final isPasswordEmpty = false.obs;

  void login(String email, String password) async {
    // Clear previous validation states
    isEmailEmpty.value = false;
    isPasswordEmpty.value = false;

    // Check for empty fields and display snackbar if any field is empty
    if (email.isEmpty) {
      isEmailEmpty.value = true;
      Get.snackbar('Error', 'Email field is required',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (password.isEmpty) {
      isPasswordEmpty.value = true;
      Get.snackbar('Error', 'Password field is required',
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else {
      AuthRepo.instance.loginUserWithEmailAndPassword(email, password);
    }

    //********* */
    /* final email = TextEditingController();
  final password = TextEditingController();
*/
  }

  @override
  void onClose() {
    // Dispose the text editing controllers
    email.value.dispose();
    password.value.dispose();
    super.onClose();
  }
}
