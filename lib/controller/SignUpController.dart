
// ignore_for_file: depend_on_referenced_packages


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as flutter_toast;
import 'package:get/get.dart';

import '../auth/login.dart';

class SignUpController extends GetxController {
  var agreementChecked = false.obs;
  var role = "".obs;
    

  void toggleAgreement(bool value) {
    agreementChecked.value = value;
  }

  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  void onSignUp() {
    if (!agreementChecked.value) {
      flutter_toast.Fluttertoast.showToast(
        msg: "Accept agreement please !",
        toastLength: flutter_toast.Toast.LENGTH_SHORT,
        gravity: flutter_toast.ToastGravity.BOTTOM,
        backgroundColor: Colors.red[400],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      createAccount(email.text , password.text , role.value);
    }
  }

  Future<void> createAccount(String email, String password,String role) async {
    // if (equal(password,confirmpassword)) {
    //   flutter_toast.Fluttertoast.showToast(
    //     msg: "Password Don't Match",
    //     toastLength: flutter_toast.Toast.LENGTH_SHORT,
    //     gravity: flutter_toast.ToastGravity.BOTTOM,
    //     backgroundColor: Colors.green[600],
    //     textColor: Colors.white,
    //     fontSize: 16.0,
    //   );
    // } else {
      try {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print("Account Created");
                  postDetailsToFirestore(email,role);

        flutter_toast.Fluttertoast.showToast(
          msg: "Account Created",
          toastLength: flutter_toast.Toast.LENGTH_SHORT,
          gravity: flutter_toast.ToastGravity.BOTTOM,
          backgroundColor: Colors.green[600],
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Get.offAll(() => LoginPage());
      } on FirebaseAuthException catch (ex) {
        if (ex.code == "weak-password") {
          flutter_toast.Fluttertoast.showToast(
            msg: "Weak Password",
            toastLength: flutter_toast.Toast.LENGTH_SHORT,
            gravity: flutter_toast.ToastGravity.BOTTOM,
            backgroundColor: Colors.orange[400],
            textColor: Colors.white,
            fontSize: 16.0,
          );
          print("Weak Password");
        } else if (ex.code == "email-already-in-use") {
          flutter_toast.Fluttertoast.showToast(
            msg: "Email Already exists",
            toastLength: flutter_toast.Toast.LENGTH_SHORT,
            gravity: flutter_toast.ToastGravity.BOTTOM,
            backgroundColor: Colors.red[400],
            textColor: Colors.white,
            fontSize: 16.0,
          );
          print("Email Already exists Login Please !");
        }
      } catch (ex) {
        print(ex);
        flutter_toast.Fluttertoast.showToast(
          msg: ex.toString(),
          toastLength: flutter_toast.Toast.LENGTH_SHORT,
          gravity: flutter_toast.ToastGravity.BOTTOM,
          backgroundColor: Colors.red[400],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
    postDetailsToFirestore(String email,  String role) async {
      print('*********************************');
      print(role);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': email, 'rool': role});
        Get.offAll(() => LoginPage());
    }
}
