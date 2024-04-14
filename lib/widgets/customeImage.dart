// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomeLottieImage extends StatelessWidget {
  final double height;
  final String path;
  const CustomeLottieImage(
      {super.key,
      required this.height,
      required this.path,
      required double speed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        child: Lottie.asset(
          path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
