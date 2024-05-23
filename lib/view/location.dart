
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationController extends GetxController {
  // Observable variables to track latitude and longitude
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAndStoreLocation();
  }

  Future<void> fetchAndStoreLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Location permissions are permanently denied.');
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

    // Store location in Firestore
    await storeLocation(position.latitude, position.longitude);
  }

  Future<void> storeLocation(double latitude, double longitude) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Get.snackbar('Error', 'No user is currently signed in.');
        return;
      }

      // Store the location data in Firestore using the user's UID as the document ID
      await FirebaseFirestore.instance.collection('userLocation').doc(user.uid).set({
        'id': user.uid,
        'x': latitude,
        'y': longitude,
      });

      //Get.snackbar('Success', 'Location stored in Firestore.');
    } catch (e) {
     // Get.snackbar('Error', 'Failed to store location: $e');
    }
  }
}
