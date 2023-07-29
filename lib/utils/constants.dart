import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/screens/add_post_screen.dart';
import 'package:instagramv2/screens/feed_screen.dart';
import 'package:instagramv2/screens/profile_screen.dart';
import 'package:instagramv2/screens/search_screen.dart';

import '../services/get_data.dart';

const webScreenSize = 600;
final dataController = Get.put(Databsecontroller());

List<Widget> homeScreenItems = [
  const FeedScreen(),
  SearchScreen(),
  const AddPostScreen(),
  const Text("home3"),
  ProfileScreen(
    uid: dataController.mUser.value?.uid ??
        FirebaseAuth.instance.currentUser!.uid,
  )
];
