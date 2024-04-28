import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical/auth/firstPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 5), () {
      // Navigate to the next screen after 5 seconds
      Get.offAll(() => const FirstPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ic_launcher.png', // Replace with your logo image path
              height: 150, // Adjust the height as per your requirement
            ),
          ],
        ),
      ),
    );
  }
}
