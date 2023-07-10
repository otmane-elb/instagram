import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/search_controller.dart';
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
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .where('username',
              isGreaterThanOrEqualTo: controller.searchController.text)
          .where('username', isLessThan: controller.searchController.text + 'z')
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Get.to(() => ProfileScreen(
                      uid: (snapshot.data! as dynamic).docs[index]['uid'],
                    ));
              },
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    (snapshot.data! as dynamic).docs[index]['photoUrl']),
              ),
              title: Text((snapshot.data! as dynamic).docs[index]['username']),
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
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  }
}
