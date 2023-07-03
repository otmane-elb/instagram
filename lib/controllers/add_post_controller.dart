import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramv2/models/post_model.dart';
import 'package:instagramv2/services/storage.dart';
import 'package:instagramv2/utils/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddPostController extends GetxController {
  static AddPostController get instance => Get.find();
  late Rx<Uint8List?> gfile;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AddPostController() {
    gfile = Rx<Uint8List?>(null);
  }
  selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a post "),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(8),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Get.back();
                  Uint8List file = await pickerimage(ImageSource.camera);
                  gfile.value = file;
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(8),
                child: const Text("Choose from Gallery"),
                onPressed: () async {
                  Get.back();
                  Uint8List file = await pickerimage(ImageSource.gallery);
                  gfile.value = file;
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(8),
                child: const Text("Cancel "),
                onPressed: () async {
                  Get.back();
                },
              ),
            ],
          );
        });
  }

//

  // add post to firestore
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String profImage, String username) async {
    String res = 'error';
    try {
      String photoUrl = await StorageMethodes()
          .uploadImageToStorage('posts', file, true, uid);
      String postId = Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          postId: postId,
          username: username,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          likes: [],
          profImage: profImage);
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
