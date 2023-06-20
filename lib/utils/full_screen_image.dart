import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final ImageProvider imageProvider;

  const FullScreenImage({required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.black,
          child: PhotoView(
            imageProvider: imageProvider,
          ),
        ),
      ),
    );
  }
}
