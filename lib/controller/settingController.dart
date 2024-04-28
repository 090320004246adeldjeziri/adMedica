import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medical/auth/firstPage.dart';


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