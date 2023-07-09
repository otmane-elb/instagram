import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/models/comment_model.dart';

import 'package:uuid/uuid.dart';

class AddCommentController extends GetxController {
  static AddCommentController get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final descriptionController = TextEditingController().obs;
  final RxBool isLoading = false.obs;

  void postImage(
      String uid, String username, String profImage, String postId) async {
    try {
      isLoading.value = true;

      String res = await uploadComment(
          descriptionController.value.text, uid, profImage, username, postId);
      if (res == "success") {
        Get.snackbar('Posted', res, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', res, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> uploadComment(String description, String uid, String profImage,
      String username, String postId) async {
    try {
      String commentId = const Uuid().v1();
      Commant comment = Commant(
          description: description,
          uid: uid,
          commentId: commentId,
          postId: postId,
          username: username,
          datePublished: DateTime.now(),
          likes: [],
          profImage: profImage);
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('Comments')
          .doc(commentId)
          .set(comment.toJson());
      return "success";
    } catch (e) {
      return e.toString();
    }
  }
}
