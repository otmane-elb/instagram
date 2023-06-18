import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/screens/home.dart';
import 'package:instagramv2/screens/login_screen.dart';
import 'package:instagramv2/screens/signup_screen.dart';

import 'controllers/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDSvgIqF6hYl-ZOhOEvyqBJbQRF2Na0YsQ",
      projectId: "instagram-24bf6",
      storageBucket: "instagram-24bf6.appspot.com",
      messagingSenderId: "506379882405",
      appId: "1:506379882405:web:4c717b163c45098be6e24c",
    )).then((value) => Get.put(AuthRepo()));
  } else {
    await Firebase.initializeApp().then((value) => Get.put(AuthRepo()));
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authRepo = AuthRepo.instance;
    final Widget initialScreen = authRepo.firebaseUser.value != null
        ? const Home()
        : const LoginScreen();

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram V2',
        theme: ThemeData.dark(useMaterial3: true),
        home: initialScreen
        /* const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),*/
        );
  }
}
