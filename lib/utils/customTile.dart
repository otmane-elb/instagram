import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final int index;
  final double extent;
  final Widget child;

  const CustomTile({super.key, 
    required this.index,
    required this.extent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: extent,
      height: extent,
      child: child,
    );
  }
}
