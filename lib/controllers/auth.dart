import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramv2/responsive/mobile_screen_layout.dart';
import 'package:instagramv2/services/get_data.dart';
import 'package:instagramv2/utils/exception.dart';
import 'package:instagramv2/services/storage.dart';
import 'package:instagramv2/screens/login_screen.dart';
import 'package:instagramv2/screens/signup_screen.dart';
import 'package:instagramv2/models/user_model.dart' as model;
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String? errorMessage;
  late Rx<User?> firebaseUser;
  AuthRepo() {
    firebaseUser = Rx<User?>(_auth.currentUser);
  }
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
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ));
  }

  Future<void> createUserWithEmailAndPassword(String email, String password,
      String username, String bio, Uint8List image) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (kDebugMode) {
        print(cred.user!.uid);
      }
      String photoUrl = await StorageMethodes()
          .uploadImageToStorage("profile", image, false, cred.user!.uid);
      model.User user = model.User(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          followers: [],
          following: []);
      // adding pic to storage

      await _firestore.collection('users').doc(cred.user!.uid).set(
            user.toJson(),
          );
      errorMessage = null;
      if (kDebugMode) {
        print('Hi there ${firebaseUser.value}');
      }
      firebaseUser.value != null
          ? Get.offAll(() => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              ))
          : Get.offAll(() => const SignupScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.fromCode(e.code);
      if (kDebugMode) {
        print("Firbase auth exeption ${ex.message}");
      }
      errorMessage = ex.message;
      Get.snackbar('Error', errorMessage ?? '',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      const ex = SignUpWithEmailAndPasswordFailure();
      if (kDebugMode) {
        print("Exception :${ex.message}");
      }
      errorMessage = ex.message;
      Get.snackbar('Error', errorMessage ?? '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      errorMessage = null;

      firebaseUser.value != null
          ? Get.offAll(() => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              ))
          : Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      final ex = LoginWithEmailAndPasswordFailure.fromCode(e.code);
      if (kDebugMode) {
        print("Firbase auth exeption ${ex.message}");
      }
      errorMessage = ex.message;
      Get.snackbar('Error', errorMessage ?? '',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      errorMessage = e.toString();
      const ex = LoginWithEmailAndPasswordFailure();
      if (kDebugMode) {
        print("Exception :${ex.message}");
      }
      errorMessage = ex.message;
      Get.snackbar('Error', errorMessage ?? '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> logout() async {
    await _auth.signOut().then((value) {
      Get.delete<Databsecontroller>();
      Get.offAll(() => const LoginScreen());
    });
  }

  @override
  void onClose() {
    Get.delete<
        AuthRepo>(); // Remove the instance from the dependency injection container
    super.onClose();
  }
}
