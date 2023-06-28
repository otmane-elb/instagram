import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagramv2/models/user_model.dart' as model;

class Databsecontroller extends GetxController {
  static Databsecontroller get instance => Get.find();

  Rx<model.User?> mUser = Rx<model.User?>(null);

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



  @override
  void onReady() {
    getUserData();
    super.onReady();
  }
}
