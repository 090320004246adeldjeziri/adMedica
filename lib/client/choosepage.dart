// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/auth/sign.dart';
import 'package:medical/navigationMenu.dart';
import 'package:medical/widgets/auth_widget/fieldtext.dart';

import '../controller/SignUpController.dart';

class ChooseRolePage extends StatefulWidget {
  ChooseRolePage({Key? key}) : super(key: key);

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  String? selectedUserType;

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController());
    List<String> userTypeOptions = [
      'Pharmacy',
      'Client',
    ];

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(226, 239, 247, 1),
        title: Text(
          "Choose Your Role",
          style: GoogleFonts.lexend(
            fontSize: 20,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.2),
            ),
            child: const Icon(
              CupertinoIcons.back,
              color: Colors.green,
              size: 30,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/ic_launcher.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Choose Your Role",
                style: GoogleFonts.lexend(fontSize: 33),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                alignment: Alignment.center,
                hint: Text("Role"),
                value: selectedUserType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedUserType = newValue;
                  });
                },
                items: userTypeOptions
                    .map(
                      (String userType) => DropdownMenuItem<String>(
                        value: userType,
                        child: Text(userType),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (selectedUserType != null) {
                      Get.to(SignUpPage(role: selectedUserType!));
                      signUpController.role.value = selectedUserType!;
                    }
                  },
                  child: Text(
                    "Continue",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
