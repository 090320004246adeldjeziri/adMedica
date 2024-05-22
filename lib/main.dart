import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical/auth/Users.dart';
import 'package:medical/mohamed/nouv_ist_pharma.dart';
import 'package:medical/splashScreen.dart';
import 'News.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import 'mohamed/listPharma.dart';


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
      title: 'DAWAIY',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       home: SplashScreen(),
      //  home : LIstPharma2(name: '',),
    );
  }
}

