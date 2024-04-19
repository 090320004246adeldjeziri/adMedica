import 'package:flutter/material.dart';

class MyPasswordField extends StatelessWidget {
  final String ButtonName;
  final Icon icon;
  final TextEditingController textEditingController;
  final TextInputType serviceType;
final Widget? suffixIcon;
   MyPasswordField(
      {super.key,
      required this.ButtonName,
      required this.icon,
      required this.textEditingController, required this.serviceType, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: textEditingController,
            keyboardType: serviceType,obscureText: true,
            decoration: InputDecoration(
              suffixIcon:  suffixIcon,
              
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
