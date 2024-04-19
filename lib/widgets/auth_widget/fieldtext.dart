import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String ButtonName;
  final Icon icon;
  final TextEditingController textEditingController;

  const MyTextField(
      {super.key,
      required this.ButtonName,
      required this.icon,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
                filled: true,
                hintText: ButtonName,
                prefixIcon: icon,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none)),
          ),
        )
      ],
    );
  }
}
