import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramv2/utils/exception.dart';
import 'package:instagramv2/services/storage.dart';
import 'package:instagramv2/screens/home.dart';
import 'package:instagramv2/screens/login_screen.dart';
import 'package:instagramv2/screens/signup_screen.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String? errorMessage;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 2));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _usercheck);
    super.onReady();
  }

  _usercheck(User? user) {
    user == null
        ? Get.offAll(() => const SignupScreen())
        : Get.offAll(() => const Home());
  }

  Future<void> createUserWithEmailAndPassword(String email, String password,
      String username, String bio, Uint8List image) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (kDebugMode) {
        print(cred.user!.uid);
      }
      // adding pic to storage
      String photoUrl = await StorageMethodes()
          .uploadImageToStorage("profile", image, false, cred.user!.uid);
      print(photoUrl);
      print('uploaded');
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'username': username,
        'bio': bio,
        'email': email,
        'uid': cred.user!.uid,
        'followers': [],
        'following': [],
        'photoUrl': photoUrl,
      });
      errorMessage = null;
      if (kDebugMode) {
        print('Hi there ${firebaseUser.value}');
      }
      firebaseUser.value != null
          ? Get.offAll(() => const Home())
          : Get.offAll(() => const SignupScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.fromCode(e.code);
      if (kDebugMode) {
        print("Firbase auth exeption ${ex.message}");
      }
      errorMessage = ex.message;
      Get.snackbar('Error 1 ', errorMessage ?? '',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      const ex = SignUpWithEmailAndPasswordFailure();
      if (kDebugMode) {
        print("Exception :${ex.message}");
      }
      errorMessage = ex.message;
      Get.snackbar('Error 2', errorMessage ?? '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(firebaseUser.value!.uid);
      errorMessage = null;

      firebaseUser.value != null
          ? Get.offAll(() => const Home())
          : Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      final failure = LoginWithEmailAndPasswordFailure.fromCode(e.code);
      errorMessage = failure.message;
      Get.snackbar('Error', errorMessage ?? '',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      errorMessage = e.toString();
      Get.snackbar('Error', errorMessage ?? '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
