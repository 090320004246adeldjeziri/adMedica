import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/HomePage.dart';
import 'package:medical/promo_slider.dart';
import 'News.dart';
import 'package:medical/searchBar.dart';
import 'package:medical/title.dart';
import 'auth/sign.dart';
import 'category.dart';
import 'controller/ProductController.dart';
import 'firebase_options.dart';
import 'leadingHomePage.dart';
import 'listViewProduct.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'navigationMenu.dart';
import 'searchScreen.dart';
import 'package:medical/mohamed/iconNotif.dart';
import 'package:medical/widget_starting/animated_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  fetchDataFromFirestore();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicament',
      home:SplashScreen(),
    );
  }
}
