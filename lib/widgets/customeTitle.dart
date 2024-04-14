// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomeTitle extends StatelessWidget {
  final String title;
  final double size;
  const CustomeTitle({super.key, required this.title, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(title,style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: size),);
  }
}