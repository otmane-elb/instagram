import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/screens/comment_screen.dart';
import 'package:instagramv2/services/get_data.dart';
import 'package:instagramv2/utils/colors.dart';
import 'package:instagramv2/utils/full_screen_image.dart';
import 'package:instagramv2/utils/time_format.dart';
import 'package:instagramv2/widgets/like_animation.dart';

class PostCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snap;
  final int commentCount;
  final String userId; // Add a new property to store the user ID

  PostCard(
      {super.key,
      required this.snap,
      required this.commentCount,
      required this.userId});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Databsecontroller());

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // *********** header section *************
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage:
                      CachedNetworkImageProvider(widget.snap['profImage']),
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                if (widget.snap['uid'] ==
                    widget
                        .userId) // Check if the user ID matches the post's user ID
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
                                  controller.deletePost(widget.snap['postId']);
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child: Center(child: Text('Delete')),
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
                  imageProvider:
                      CachedNetworkImageProvider(widget.snap['postUrl'])));
            },
            onDoubleTap: () async {
              await controller.likePost(
                widget.snap['postId'],
                controller.mUser.value!.uid,
                widget.snap['likes'],
              );

              // Use the stored mounted value
              setState(() {
                isLikeAnimating = true;
                print('ok');
              });

              print(isLikeAnimating);
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
                isAnimating:
                    widget.snap['likes'].contains(controller.mUser.value?.uid),
                child: IconButton(
                  onPressed: () async {
                    await controller.likePost(widget.snap['postId'],
                        controller.mUser.value!.uid, widget.snap['likes']);
                  },
                  icon:
                      widget.snap['likes'].contains(controller.mUser.value?.uid)
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_outline),
                  color:
                      widget.snap['likes'].contains(controller.mUser.value?.uid)
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
          //***Description + commments  */
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' ${widget.snap['description']}',
                        ),
                      ],
                    ),
                  ),
                ),
                widget.commentCount == 0
                    ? Container()
                    : InkWell(
                        onTap: () {
                          Get.to(() => CommentSection(
                                postId: widget.snap['postId'],
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'View all ${widget.commentCount.toString()} comments ',
                            style:
                                TextStyle(fontSize: 16, color: secondaryColor),
                          ),
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    formatTimestamp(widget.snap['datePublished']),
                    style: const TextStyle(fontSize: 14, color: secondaryColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
