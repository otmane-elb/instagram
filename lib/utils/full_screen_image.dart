import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final ImageProvider imageProvider;

  const FullScreenImage({super.key, required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.black,
        child: PhotoView(
          imageProvider: imageProvider,
        ),
      ),
    );
  }
}
