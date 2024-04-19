import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical/navigationMenu.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Text editing controllers for email and password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Function to handle login
  Future<void> login() async {
    try {
      // Sign in with email and password
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // If successful, navigate to the home page or perform other actions
      Get.offAll(() => NavigationMenu());
    } catch (e) {
      // Handle login errors
      print("Error logging in: $e");
      // Show an error message to the user
      // You can implement this using a snackbar or a dialog
    }
  }

  @override
  void onClose() {
    // Clean up text editing controllers when the controller is closed
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
