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

  void PasswordReset() {
    _auth.sendPasswordResetEmail(email: email.text);
    flutter_toast.Fluttertoast.showToast(
        msg:
            "Verifer Your Boite Mail , We send You message to reset your Password ");
  }

  void SignIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      // If the user is successfully signed in, go to NavigationMenu page
      flutter_toast.Fluttertoast.showToast(
          msg: 'Login Successful !',
          backgroundColor: Colors.green[600],
          fontSize: 17);
      Get.offAll(() => const NavigationMenu());
    } on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }

    }
  }
}
