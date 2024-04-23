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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() {
    SignIn();
  }

  void PasswordReset() {
    _auth.sendPasswordResetEmail(email: email.text);
    flutter_toast.Fluttertoast.showToast(
        msg:
            " We send You message to reset your Password ");
  }

  Future<void> SignIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      
      // If the user is successfully signed in, go to Na page
      flutter_toast.Fluttertoast.showToast(
          msg: 'Login Successful !',
          backgroundColor: Colors.green[600],
          fontSize: 17);
          route();
      // Get.offAll(() => const NavigationMenu());
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        flutter_toast.Fluttertoast.showToast(msg: "Email doesn't exist !");
      } else if (e.code == "wrong-password") {
        flutter_toast.Fluttertoast.showToast(
          msg: "Wrong Password !",
          toastLength: flutter_toast.Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[600],
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
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
        }else if (documentSnapshot.get('rool') == "Pharmacy") {
           Get.offAll(() => const AddProductNotif());
   
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
