import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramv2/controllers/auth.dart';
import 'package:instagramv2/utils/image_picker.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final Rx<Uint8List?> image = Rx<Uint8List?>(null);
  //********* */
  final email = TextEditingController().obs;
  final password = TextEditingController().obs;
  final username = TextEditingController().obs;
  final bio = TextEditingController().obs;

  // Add Rx<bool> to track whether the fields are empty or not
  final isEmailEmpty = false.obs;
  final isPasswordEmpty = false.obs;
  final isUsernameEmpty = false.obs;
  final isBioEmpty = false.obs;

  void signup(
      String email, String password, String username, String bio) async {
    // Clear previous validation states
    isEmailEmpty.value = false;
    isPasswordEmpty.value = false;
    isUsernameEmpty.value = false;
    isBioEmpty.value = false;

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
    }

    if (username.isEmpty) {
      isUsernameEmpty.value = true;
      Get.snackbar('Error', 'Username field is required',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (bio.isEmpty) {
      isBioEmpty.value = true;
      Get.snackbar('Error', 'Bio field is required',
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else {
      AuthRepo.instance.createUserWithEmailAndPassword(
          email, password, username, bio, image.value ?? Uint8List(0));
    }
    // Continue with signup logic
    // ...
  }

//***** */
  @override
  void onInit() {
    super.onInit();
    loadImageFromAssets();
  }

  void loadImageFromAssets() async {
    final ByteData? imageData = await rootBundle.load('assets/profile.png');
    if (imageData != null) {
      image.value = imageData.buffer.asUint8List();
    }
  }

  void selectImage() async {
    Uint8List? im = await pickerimage(ImageSource.gallery);
    image.value = im;
  }

  @override
  void onClose() {
    // Dispose the text editing controllers
    email.value.dispose();
    password.value.dispose();
    username.value.dispose();
    bio.value.dispose();
    super.onClose();
  }
}
