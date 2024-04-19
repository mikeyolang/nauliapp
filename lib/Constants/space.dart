import 'package:flutter/material.dart';

class SpaceVH extends StatelessWidget {
  final double? width;
  final double? height;
  const SpaceVH({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 0.0,
      width: width ?? 0.0,
    );
  }
}
