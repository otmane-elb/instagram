import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/add_post_controller.dart';
import 'package:instagramv2/services/get_data.dart';
import 'package:instagramv2/utils/colors.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddPostController());
    final controller2 = Get.put(Databsecontroller());

    return Obx(() {
      Uint8List? file = controller.gfile.value;

      return file == null
          ? Center(
              child: IconButton(
                onPressed: () {
                  controller.selectImage(context);
                },
                icon: const Icon(Icons.upload),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: mobileBackgroundColor,
                leading: IconButton(
                  onPressed: () {
                    controller.clearfile();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                title: const Text("Add Post"),
                centerTitle: false,
                actions: [
                  TextButton(
                    onPressed: () {
                      controller.postImage(
                        controller2.mUser.value!.uid,
                        controller2.mUser.value!.username,
                        controller2.mUser.value!.photoUrl,
                      );
                    },
                    child: const Text(
                      "Post",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Obx(
                    () => controller.isLoading.value
                        ? const LinearProgressIndicator()
                        : Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(controller2.mUser.value!.photoUrl),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          controller: controller.descriptionController.value,
                          decoration: const InputDecoration(
                            hintText: "Add caption ...",
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(file),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ],
              ),
            );
    });
  }
}
