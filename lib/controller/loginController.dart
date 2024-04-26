// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart' as flutter_toast;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical/addProduct.dart';
import 'package:medical/mohamed/partie_pharmacy/addProductNotif.dart';
import 'package:medical/mohamed/selectImg.dart';
import '../mohamed/partie_pharmacy/ordonance_detail.dart';
import '../navigationMenu.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void login() {
    SignIn();
  }

  void PasswordReset() {
    _auth.sendPasswordResetEmail(email: email.text);
    // flutter_toast.Fluttertoast.showToast(
    // msg:
    //     " We send You message to reset your Password ");
  }

  void SignIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      flutter_toast.Fluttertoast.showToast(
        msg: 'Login Successful!',
        backgroundColor: Colors.green[600],
        fontSize: 17,
      );
      route();
    } on FirebaseAuthException catch (e) {
      print("***********regler***********");
      print(e.code.toString());
      print("**********");
      print(e.code);
      if (e.code == 'invalid-credential') {
        flutter_toast.Fluttertoast.showToast(
          msg: 'Wrong Password ',
          backgroundColor: Colors.red,
          fontSize: 17,
        );
      }
      if (e.code == "too-many-requests") {
        flutter_toast.Fluttertoast.showToast(
          msg: 'Reset your password or Stay 3 minutes',
          backgroundColor: Colors.red,
          fontSize: 17,
        );
      }
    } finally {
      isLoading.value = false; // Set isLoading to false after login
    }
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "Client") {
          Get.offAll(() => const NavigationMenu());
        } else if (documentSnapshot.get('rool') == "Pharmacy") {
          Get.offAll(() => const AddProductNotif());
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
