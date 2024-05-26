import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical/auth/Users.dart';
import 'package:medical/mohamed/nouv_ist_pharma.dart';
import 'package:medical/splashScreen.dart';
import 'package:medical/view/location.dart';
import 'News.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  fetchDataFromFirestore();
  //fetchDatapharmacyFromFirestore();
  LocationController X = Get.put(LocationController());
  _checkLocationPermission();
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
      // home : LIstPharma2(name: '',),
    );
  }
}

Future<void> _checkLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    _showLocationSettingsDialog(); // Show a dialog to guide the user to settings
  } else if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      _closeApp(); // If permission is still denied, close the app
    }
  } else {
    // If permission is granted, proceed with your app logic
    _getCurrentLocation();
  }
}

void _getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  print('Current location: (${position.latitude}, ${position.longitude})');
  // Proceed with your app logic after obtaining the location
}

void _showLocationSettingsDialog() {
  // Show a dialog guiding the user to location settings
  print('Location Permission Required. Please enable location permissions in settings to use this app.');
  // You can implement the dialog to guide the user to settings as needed for your app
}

void _closeApp() {
  // Close the app
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  exit(0);
}