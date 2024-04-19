import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart' as flutter_toast;

import '../navigationMenu.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() {
    SignIn();
  }

  Future<void> SignIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      print("Login");
      Get.offAll(() => NavigationMenu());
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        flutter_toast.Fluttertoast.showToast(msg: "Email doesn't exist !");
      } else if (e.code == "wrong-password") {
        flutter_toast.Fluttertoast.showToast(msg: "Wrong Password !");
      }
    }

    @override
    void onClose() {
      email.dispose();
      password.dispose();
      super.onClose();
    }
  }
}
