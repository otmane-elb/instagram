import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramv2/controllers/auth.dart';
import 'package:instagramv2/utils/image_picker.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final username = TextEditingController();
  final bio = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final Rx<Uint8List?> image = Rx<Uint8List?>(null);

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

  void signup(
    String email,
    String password,
    String username,
    String bio,
  ) async {
    AuthRepo.instance
        .createUserWithEmailAndPassword(email, password, username, bio,image.value ?? Uint8List(0));
  }
}
