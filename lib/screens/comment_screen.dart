import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/services/addcomments.dart';
import 'package:instagramv2/services/get_data.dart';
import 'package:instagramv2/utils/colors.dart';
import 'package:instagramv2/widgets/comment_card.dart';

class CommentSection extends StatefulWidget {
  final String postId;
  const CommentSection({super.key, required this.postId});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final controller = Get.put(Databsecontroller());
  final addcontroller = Get.put(AddCommentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Comments section"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.postId)
            .collection('Comments')
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
            itemBuilder: (context, index) =>
                CommentCrad(snap: snapshot.data!.docs[index]),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  controller.mUser.value!.photoUrl,
                ),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: addcontroller.descriptionController.value,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          'comment as @${controller.mUser.value!.username}',
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (addcontroller.descriptionController.value.text != "") {
                    addcontroller
                        .uploadComment(
                            addcontroller.descriptionController.value.text,
                            controller.mUser.value!.uid,
                            controller.mUser.value!.photoUrl,
                            controller.mUser.value!.username,
                            widget.postId)
                        .then((value) => addcontroller
                            .descriptionController.value.text = '');
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Obx(
                    () => addcontroller.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Post',
                            style: TextStyle(color: blueColor),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
