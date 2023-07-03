import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/add_post_controller.dart';
import 'package:instagramv2/services/get_data.dart';
import 'package:instagramv2/utils/colors.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();
    final controller = Get.put(AddPostController());
    final controller2 = Get.put(Databsecontroller());
    final controller3 = Get.put(AddPostController());
    void postImage(String uid, String username, String profImage) async {
      try {
        Uint8List? file = controller.gfile.value;

        String res = await controller3.uploadPost(
            descriptionController.text, file!, uid, profImage, username);
        if (res == "success") {
          Get.snackbar('Posted', res, snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar('Error', res, snackPosition: SnackPosition.BOTTOM);
        }
      } catch (e) {}
    }

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
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back),
                ),
                title: const Text("Add Post"),
                centerTitle: false,
                actions: [
                  TextButton(
                    onPressed: () {
                      postImage(
                          controller2.mUser.value!.uid,
                          controller2.mUser.value!.username,
                          controller2.mUser.value!.photoUrl);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(controller2.mUser.value!.photoUrl),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: const TextField(
                          decoration: InputDecoration(
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
