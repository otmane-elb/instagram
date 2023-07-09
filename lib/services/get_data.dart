import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagramv2/models/user_model.dart' as model;

class Databsecontroller extends GetxController {
  static Databsecontroller get instance => Get.find();

  Rx<model.User?> mUser = Rx<model.User?>(null);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Rx<model.User?>?> getUserData() async {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      mUser.value = model.User.fromsnapshot(snap);
      return mUser;
    }
    return null;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> deletePost(String postId) async {
    try {
    await   _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onReady() {
    getUserData();
    super.onReady();
  }
}
