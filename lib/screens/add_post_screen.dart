import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramv2/controllers/add_post_controller.dart';
import 'package:instagramv2/utils/colors.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddPostController());
    Uint8List? file = controller.Gfile?.value;
    return file == null
        ? Center(
            child: IconButton(
                onPressed: () {
                  controller.selectImage(context);
                },
                icon: Icon(Icons.upload)),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              title: const Text("Add Post"),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ))
              ],
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/spectral-light-illuminates-transparent-bright-blue-colored-peonies-abstract-flower-art-generative-ai_157027-1721.jpg?w=1060&t=st=1688151615~exp=1688152215~hmac=4d6704bf3943be304d668321fa4a91d7ba2ed0478bf5642a5383312e56f78fe0'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Add caption ...",
                            border: InputBorder.none),
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
                              image: NetworkImage(
                                  'https://img.freepik.com/free-photo/spectral-light-illuminates-transparent-bright-blue-colored-peonies-abstract-flower-art-generative-ai_157027-1721.jpg?w=1060&t=st=1688151615~exp=1688152215~hmac=4d6704bf3943be304d668321fa4a91d7ba2ed0478bf5642a5383312e56f78fe0'),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter),
                        )),
                      ),
                    ),
                    Divider(),
                  ],
                )
              ],
            ),
          );
  }
}
