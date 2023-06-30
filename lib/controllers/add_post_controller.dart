import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramv2/utils/image_picker.dart';

class AddPostController extends GetxController {
  static AddPostController get instance => Get.find();
  Rx<Uint8List>? Gfile;
  selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create a post "),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(8),
                child: Text("Take a photo"),
                onPressed: () async {
                  Get.back();
                  Uint8List file = await pickerimage(ImageSource.camera);
                  Gfile?.value = file;
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(8),
                child: Text("Choose from Gallery"),
                onPressed: () async {
                  Get.back();
                  Uint8List file = await pickerimage(ImageSource.gallery);
                  Gfile?.value = file;
                },
              ),
            ],
          );
        });
  }
}
