// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomeBodyText extends StatelessWidget {
  final String body_;
  const CustomeBodyText({super.key, required this.body_});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: const EdgeInsets.all(27.0),
          child: Text(
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
              body_)),
    );
  }
}