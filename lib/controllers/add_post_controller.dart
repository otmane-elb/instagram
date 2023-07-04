import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final descriptionController = TextEditingController().obs;
  final RxBool isLoading = false.obs;

  AddPostController() {
    gfile = Rx<Uint8List?>(null);
  }
  clearfile() {
    gfile.value = null;
  }

  void selectImage(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a post"),
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
              child: const Text("Cancel"),
              onPressed: () async {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    try {
      isLoading.value = true;
      Uint8List? file = gfile.value;

      if (file == null) {
        Get.snackbar('Error', 'No image selected',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      String res = await uploadPost(
          descriptionController.value.text, file, uid, profImage, username);
      if (res == "success") {
        Get.snackbar('Posted', res, snackPosition: SnackPosition.BOTTOM);
        clearfile();
        descriptionController.value.clear();
      } else {
        Get.snackbar('Error', res, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print('Error posting image: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String profImage, String username) async {
    try {
      String photoUrl = await StorageMethodes()
          .uploadImageToStorage('posts', file, true, uid);
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          postId: postId,
          username: username,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          likes: [],
          profImage: profImage);
      await _firestore.collection('posts').doc(postId).set(post.toJson());
      return "success";
    } catch (e) {
      return e.toString();
    }
  }
}
