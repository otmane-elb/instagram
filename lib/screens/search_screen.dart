import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/search_controller.dart';
import 'package:instagramv2/models/user_model.dart';
import 'package:instagramv2/screens/profile_screen.dart';
import 'package:instagramv2/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagramv2/utils/customTile.dart';

class SearchScreen extends StatelessWidget {
  final controller = Get.put(SearcheController());

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: controller.searchController,
          decoration: InputDecoration(labelText: "Search for users"),
          onFieldSubmitted: (_) => controller.onFieldSubmitted(),
        ),
      ),
      body: Obx(
        () =>
            controller.isShowUsers.value ? buildUsersList() : buildPostsGrid(),
      ),
    );
  }

  Widget buildUsersList() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .where('username',
              isGreaterThanOrEqualTo: controller.searchController.text)
          .where('username', isLessThan: controller.searchController.text + 'z')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No users found.'),
          );
        }

        final users = snapshot.data!.docs
            .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              onTap: () {
                Get.to(() => ProfileScreen(uid: user.uid));
              },
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
              title: Text(user.username),
            );
          },
        );
      },
    );
  }

  Widget buildPostsGrid() {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('datePublished')
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return MasonryGridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context, index) {
            final imageUrl = (snapshot.data! as dynamic).docs[index]['postUrl'];

            return CustomTile(
              index: index,
              extent: ((index % 3) + 1) * 100,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  }
}
