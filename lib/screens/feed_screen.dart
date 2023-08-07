import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagramv2/services/get_data.dart';
import 'package:instagramv2/utils/colors.dart';
import 'package:instagramv2/utils/constants.dart';
import 'package:instagramv2/widgets/postCard.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Databsecontroller());
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MediaQuery.of(context).size.width > webScreenSize
          ? webBackgroundColor
          : Colors.black,
      appBar: MediaQuery.of(context).size.width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                "assets/ic_instagram.svg",
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                height: 32,
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.messenger))
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No posts found.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final post = snapshot.data!.docs[index];

              return Container(
                decoration: BoxDecoration(),
                margin: EdgeInsets.symmetric(
                    horizontal: width > webScreenSize ? width * 0.3 : 0,
                    vertical: width > webScreenSize ? 10 : 0),
                child: PostCard(
                  snap: post,
                  userId: controller.mUser.value?.uid ?? '',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
