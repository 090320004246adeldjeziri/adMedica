// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as flutter_toast;
import 'package:get/get.dart';
import 'package:medical/auth/Users.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical/view/location.dart';

import '../auth/login.dart';

class SignUpController extends GetxController {
  var agreementChecked = false.obs;
  var role = "".obs;
  var emailpage = "".obs;
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
  LocationController locControl= Get.put(LocationController());
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
        locControl.latitude.value = position.latitude;
        locControl.longitude.value = position.longitude;
      
      print('Current location: (${position.latitude}, ${position.longitude})');
    } catch (e) {
      print('Error getting location: $e');
    }
  }
 
  void onSignUp() {
    if (!agreementChecked.value) {
      flutter_toast.Fluttertoast.showToast(
        msg: "Please accept the agreement!",
        toastLength: flutter_toast.Toast.LENGTH_SHORT,
        gravity: flutter_toast.ToastGravity.BOTTOM,
        backgroundColor: Colors.red[400],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      createAccount(email.text, password.text, role.value);
    }
  }

  Future<void> createAccount(String email, String password, String role) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = userCredential.user!.uid;

      UserData userData = UserData(
        uid: uid,
        name: name.text,
        email: email,
        phone: phone.text,
        prenom: surname.text,
        role: role,
      );

      await userData.saveToFirestore();
      emailpage.value = email;
      if (role == "Pharmacy") {
        var pharmacies = FirebaseFirestore.instance.collection('pharmacies');
        await pharmacies.doc(userData.uid).set({
          'name': name.text,
          'email': email,
          'latitude':  locControl.latitude.value ,
          'longitude':  locControl.longitude.value ,
          
        });
        FirebaseFirestore.instance.collection('pharmacies');
      }
      print("Account Created");

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
          msg: "Email Already Exists",
          toastLength: flutter_toast.Toast.LENGTH_SHORT,
          gravity: flutter_toast.ToastGravity.BOTTOM,
          backgroundColor: Colors.red[400],
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print("Email Already Exists. Please Login!");
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
}
