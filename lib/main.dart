import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagramv2/responsive/mobile_screen_layout.dart';
import 'package:instagramv2/responsive/responsive.dart';
import 'package:instagramv2/responsive/web_screen_layout.dart';
import 'package:instagramv2/screens/login_screen.dart';

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
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram V2',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen()
        /* const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),*/
        );
  }
}
