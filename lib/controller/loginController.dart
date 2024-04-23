import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart' as flutter_toast;
import 'package:cloud_firestore/cloud_firestore.dart';
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
          route();
      // Get.offAll(() => const NavigationMenu());
    } on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
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
        }else {
           Get.offAll(() => AgrandirImagePage(imageUrl: '',) );
   
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
