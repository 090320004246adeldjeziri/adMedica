import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/auth/login.dart';
import 'package:medical/navigationMenu.dart';
import 'package:medical/widgets/auth_widget/fieldtext.dart';

import '../controller/SignUpController.dart';

class ChooseRolePage extends StatelessWidget {
  ChooseRolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController());

    List<String> userTypeOptions = ['Pharmacy', 'Client','Administration'];
    String selectedUserType = userTypeOptions.first;
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
                child: Image.network(
                  'https://th.bing.com/th/id/R.b3a46e6760afe03b45f87b841402ea2b?rik=pGG3sg9kQ6loew&pid=ImgRaw',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Choose Your Role",
                style: GoogleFonts.lexend(fontSize: 33),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedUserType,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    selectedUserType = newValue;
                  }
                },
                items: userTypeOptions.map((String userType) {
                  return DropdownMenuItem<String>(
                    value: userType,
                    child: Text(userType),
                  );
                }).toList(),
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
                    if (selectedUserType == 'Pharmacy') {
                      // Navigate to pharmacy registration page
                    } else {
                      // Navigate to client registration page
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
