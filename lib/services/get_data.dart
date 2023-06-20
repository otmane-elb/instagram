import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Databsecontroller extends GetxController {
  static Databsecontroller get instance => Get.find();

  Rx<String> username = "".obs;
  void getUsername() async {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      print(snap.data());
      username.value = (snap.data() as Map<String, dynamic>)['email'];
      print(username);
    }
  }

  void reset() {
    username.value = "";
  }

  @override
  void onReady() {
    getUsername();
    super.onReady();
  }
}
