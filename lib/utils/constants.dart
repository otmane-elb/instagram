import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramv2/screens/add_post_screen.dart';
import 'package:instagramv2/screens/feed_screen.dart';
import 'package:instagramv2/screens/profile_screen.dart';
import 'package:instagramv2/screens/search_screen.dart';

const webScreenSize = 600;
List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("home3"),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  )
];
