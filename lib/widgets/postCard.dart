import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/screens/comment_screen.dart';
import 'package:instagramv2/services/get_data.dart';
import 'package:instagramv2/utils/colors.dart';
import 'package:instagramv2/utils/constants.dart';
import 'package:instagramv2/utils/full_screen_image.dart';
import 'package:instagramv2/utils/time_format.dart';
import 'package:instagramv2/widgets/like_animation.dart';

class PostCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snap;
  final String userId;

  const PostCard({Key? key, required this.snap, required this.userId})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  // Add a stream to fetch comments
  late Stream<QuerySnapshot> commentStream;

  @override
  void initState() {
    super.initState();

    // Initialize the stream in initState
    commentStream = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.snap.id) // Get the document ID of the post
        .collection('Comments')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Databsecontroller());
    final width = MediaQuery.of(context).size.width;

    // Use the commentStream within a StreamBuilder
    return StreamBuilder<QuerySnapshot>(
      stream: commentStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(); // Placeholder while loading comments
        }

        if (snapshot.hasData) {
          final commentCount = snapshot.data!.docs.length;

          // The rest of your PostCard code
          return Container(
            decoration: BoxDecoration(
                color: mobileBackgroundColor,
                border: width > webScreenSize
                    ? Border.all(
                        color: Colors.white, // Border color
                        width: 1.0, // Border width
                      )
                    : null,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                // *********** header section *************
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                          .copyWith(right: 0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: CachedNetworkImageProvider(
                            widget.snap['profImage']),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.snap['username'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      if (widget.snap['uid'] == widget.userId)
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: ListView(
                                  shrinkWrap: true,
                                  // ...
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller
                                            .deletePost(widget.snap['postId']);
                                        Get.back();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 20),
                                        child:
                                            const Center(child: Text('Delete')),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.more_vert),
                        )
                    ],
                  ),
                ),
                //*****image section
                GestureDetector(
                  onTap: () {
                    Get.to(() => FullScreenImage(
                        imageProvider: CachedNetworkImageProvider(
                            widget.snap['postUrl'])));
                  },
                  onDoubleTap: () async {
                    if (controller.mUser.value == null) {
                      // handle this situation, maybe show a warning to the user
                      return;
                    }
                    await controller.likePost(
                      widget.snap['postId'],
                      controller.mUser.value!.uid,
                      widget.snap['likes'],
                    );

                    setState(() {
                      isLikeAnimating = true;
                    });

                    // Use the stored mounted value
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: widget.snap['postUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isLikeAnimating ? 1 : 0,
                        child: LikeAnimation(
                            onEnd: () {
                              setState(() {
                                isLikeAnimating = false;
                              });
                            },
                            duration: const Duration(milliseconds: 200),
                            isAnimating: isLikeAnimating,
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 120,
                            )),
                      )
                    ],
                  ),
                ),
                //**** like section
                Row(
                  children: [
                    LikeAnimation(
                      smallLike: true,
                      isAnimating: widget.snap['likes']
                          .contains(controller.mUser.value?.uid),
                      child: IconButton(
                        onPressed: () async {
                          await controller.likePost(
                              widget.snap['postId'],
                              controller.mUser.value!.uid,
                              widget.snap['likes']);
                        },
                        icon: widget.snap['likes']
                                .contains(controller.mUser.value?.uid)
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_outline),
                        color: widget.snap['likes']
                                .contains(controller.mUser.value?.uid)
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(() => CommentSection(
                              postId: widget.snap['postId'],
                            ));
                      },
                      icon: const Icon(Icons.mode_comment_outlined),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send_outlined),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_border),
                      ),
                    ))
                  ],
                ),
                //***Description + comments  */
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w800),
                        child: Text(
                          '${widget.snap['likes'].length} likes',
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(color: primaryColor),
                            children: [
                              TextSpan(
                                text: widget.snap['username'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' ${widget.snap['description']}',
                              ),
                            ],
                          ),
                        ),
                      ),
                      commentCount == 0
                          ? Container()
                          : InkWell(
                              onTap: () {
                                Get.to(() => CommentSection(
                                      postId: widget.snap['postId'],
                                    ));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  'View all $commentCount comments ',
                                  style: const TextStyle(
                                      fontSize: 16, color: secondaryColor),
                                ),
                              ),
                            ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          formatTimestamp(widget.snap['datePublished']),
                          style: const TextStyle(
                              fontSize: 14, color: secondaryColor),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(); // Placeholder if no comments found
        }
      },
    );
  }
}
