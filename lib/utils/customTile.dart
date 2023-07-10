import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final int index;
  final double extent;
  final Widget child;

  const CustomTile({
    required this.index,
    required this.extent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: extent,
      height: extent,
      child: child,
    );
  }
}
