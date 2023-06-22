import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagramv2/models/user_model.dart' as model;

class Databsecontroller extends GetxController {
  static Databsecontroller get instance => Get.find();

  Rx<String> username = "".obs;
  Rx<model.User?> mUser = Rx<model.User?>(null);
  void getUsername() async {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      username.value = (snap.data() as Map<String, dynamic>)['username'];
    }
  }

  Future<Rx<model.User?>?> getUserData() async {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      print(snap.data());
      username.value = (snap.data() as Map<String, dynamic>)['username'];
      mUser.value = model.User.fromsnapshot(snap);
      return mUser;
    }
  }

  void reset() {
    username.value = "";
  }

  @override
  void onReady() {
    getUsername();
    getUserData();
    super.onReady();
  }
}
