import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagramv2/services/get_data.dart';
import 'package:instagramv2/utils/colors.dart';
import 'package:instagramv2/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Databsecontroller());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/ic_instagram.svg",
          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
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
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final post = snapshot.data!.docs[index];

              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(post.id) // Get the document ID of the post
                    .collection('Comments')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final commentCount = snapshot.data!.docs.length;

                    return PostCard(
                      snap: post,
                      commentCount: commentCount,
                      userId: controller.mUser.value!.uid,
                    );
                  } else {
                    return Container(); // Placeholder while loading comments
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
