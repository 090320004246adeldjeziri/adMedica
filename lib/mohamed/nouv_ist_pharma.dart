import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical/modelPharm.dart';
import 'package:medical/services/imagesService.dart';
import 'package:medical/view/location.dart';
import 'package:get/get.dart';
import 'img_controller.dart';

class LIstPharma2 extends StatefulWidget {
  const LIstPharma2({
    Key? key,
  }) : super(key: key);

  @override
  State<LIstPharma2> createState() => _LIstPharma2State();
}

class _LIstPharma2State extends State<LIstPharma2> {
  static ImageController controller = ImageController();
  LocationController locControl = Get.put(LocationController());
  Map<String, bool> _selectedUsers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy Users'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('pharmacies').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Aucun utilisateur trouvé.'));
                }

                var pharmacies = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: pharmacies.length,
                  itemBuilder: (context, index) {
                    var pharmacy = pharmacies[index];
                    var pharmacyData = pharmacy.data() as Map<String, dynamic>;
                    var pharmacyId = pharmacy.id;

                    if (_selectedUsers[pharmacyId] == null) {
                      _selectedUsers[pharmacyId] = false;
                    }

                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: _selectedUsers[pharmacyId],
                          onChanged: (bool? value) {
                            setState(() {
                              _selectedUsers[pharmacyId] = value!;
                            });
                          },
                        ),
                        title: Text(pharmacyData['name']),
                        subtitle: StreamBuilder<DocumentSnapshot>(
  stream: FirebaseFirestore.instance.collection('pharmacies').doc(pharmacyId).snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData || snapshot.data!.data() == null) {
      return Text('Distance: Unknown');
    }

    var pharmacyLocation = snapshot.data!.data()! as Map<String, dynamic>; // Explicit cast
    double? latitude = pharmacyLocation['latitude']; // Access latitude property
    double? longitude = pharmacyLocation['longitude']; // Access longitude property

    if (latitude != null && longitude != null) {
      double distance = calculateDistance(
        locControl.latitude.value,
        locControl.longitude.value,
        latitude,
        longitude,
      );
      updatePharmacyDistance(pharmacyId, distance);
      return Text('Distance: ${formatDistance(distance.toInt())}');
    } else {
      return Text('Distance: Unknown');
    }
  },
),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (ImageService.selectedImagePath != "") {
                _handleSendImage(context, ImageService.selectedImagePath!);
              } else {
                print("Veuillez sélectionner une image");
              }
            },
            child: const Text('Envoyer un message'),
          ),
        ],
      ),
    );
  }

  void _handleSendImage(BuildContext context, String selectedImagePath) {
    List<String> selectedPharmacyIds = _selectedUsers.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    if (selectedPharmacyIds.isNotEmpty) {
      controller.uploadImageToFirebaseStorage(selectedImagePath);

      for (String pharmacyId in selectedPharmacyIds) {
        controller.uploadImageAndAddToFirestore(selectedImagePath, selectedPharmacyIds);
      }

      OverlayEntry? overlayEntry;
      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Center(
                child: SpinKitFadingCircle(
                  color: Colors.green,
                  size: 100.0,
                ),
              ),
            ],
          ),
        ),
      );

      Overlay.of(context)?.insert(overlayEntry);

      Timer(
        const Duration(seconds: 5),
        () {
          overlayEntry?.remove();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Image envoyée'),
                content: const Text('Votre image a été envoyée avec succès.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner au moins une pharmacie.'),
        ),
      );
    }
  }

  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    double distanceInMeters = Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
    return distanceInMeters;
  }

  String formatDistance(int distance) {
    return distance <= 1000 ? '$distance meters' : '${(distance / 1000).toStringAsFixed(1)} km';
  }
}
Future<void> updatePharmacyDistance(String pharmacyId, double distance) async {
    try {
      await FirebaseFirestore.instance.collection('pharmacies').doc(pharmacyId).update({
        'distance': distance,
      });
    } catch (e) {
      print("Failed to update pharmacy distance: $e");
    }
  }