import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/auth/firstPage.dart';
import 'package:medical/controller/SignUpController.dart';

class SettingController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void logOut() {
    logout();
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(FirstPage()); // Navigate to the login page
  }
}

class Setting extends StatelessWidget {
  final SettingController controller = Get.put(SettingController());

  Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(226, 239, 247, 1),
        title: Text(
          'Setting',
          style: GoogleFonts.lexend(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 2),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/dawa.png", fit: BoxFit.contain),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => controller.logout(),
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 60,
                  child: Text(
                    "Sign Out",
                    style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
