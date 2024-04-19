import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigationMenu.dart';

class LoginController extends GetxController {
  var email = TextEditingController();
  var password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      Get.offAll(() => NavigationMenu());
    } catch (e) {
      print("Error logging in: $e");
      displayErrorSnackbar("Error logging in: $e");
    }
  }

  void displayErrorSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
