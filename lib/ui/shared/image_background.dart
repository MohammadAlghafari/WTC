import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageBackground extends StatelessWidget {
  const ImageBackground({Key? key, required this.image, required this.child})
      : super(key: key);
  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
      child: child,
    );
  }
}
