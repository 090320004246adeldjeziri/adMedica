import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical/modelPharm.dart';
import 'package:medical/services/imagesService.dart';
import 'package:medical/view/location.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'img_controller.dart';

class Pharmacy {
  final String name;
  double distance;
  final double latitude;
  final String email;
  final double longitude;
  final List<String> imagePath;
  bool isSelected;

  Pharmacy({
    required this.name,
    this.distance = 300,
    required this.latitude,
    required this.longitude,
    required this.email,
    required this.imagePath,
    this.isSelected = false,
  });
}



class LIstPharma2 extends StatefulWidget {
  const LIstPharma2({Key? key}) : super(key: key);

  @override
  State<LIstPharma2> createState() => _LIstPharma2State();
}

class _LIstPharma2State extends State<LIstPharma2> {
  static ImageController controller = ImageController();
  LocationController locControl = Get.put(LocationController());
  Map<String, bool> _selectedUsers = {};
  double selectedDistance = 1000;
  bool isLocationLoaded = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        locControl.latitude.value = position.latitude;
        locControl.longitude.value = position.longitude;
        isLocationLoaded = true;
      });
      print('Current location: (${position.latitude}, ${position.longitude})');
    } catch (e) {
      print('Error getting location: $e');
    }
  }
 

  List<Pharmacy> filteredPharmacies(List<DocumentSnapshot> pharmacies) {
    return pharmacies.map((pharmacy) {
      var pharmacyData = pharmacy.data() as Map<String, dynamic>;
       double distanceInMeters = Geolocator.distanceBetween(
  locControl.latitude.value,
  locControl.longitude.value,
  pharmacyData['latitude'],
  pharmacyData['longitude'],
);
      //double distanceInMeters = (pharmacyData['distance'] ?? 400.0).toDouble();

      print('Pharmacy: ${pharmacyData['name']}, Distance: $distanceInMeters meters');

      return Pharmacy(
        name: pharmacyData['name'],
        email: pharmacyData['email'],
        latitude: pharmacyData['latitude'],
        longitude: pharmacyData['longitude'],
        imagePath: [""],
        distance: distanceInMeters,
      );
    }).where((pharmacy) => pharmacy.distance <= selectedDistance).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool anyItemSelected = _selectedUsers.values.any((isSelected) => isSelected);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pharmacy List',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Select Distance: ',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<int>(
                  value: selectedDistance.toInt(),
                  onChanged: (int? value) {
                    setState(() {
                      selectedDistance = value!.toDouble();
                    });
                  },
                  items: [1000, 1500, 2000, 3000,10000,20000].map<DropdownMenuItem<int>>((int distance) {
                    return DropdownMenuItem<int>(
                      value: distance,
                      child: Text(
                        distance == 1000 ? 'Less than 1 km' : '${distance / 1000} km',
                        style: GoogleFonts.poppins(
                          color: Colors.teal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.teal,
                  ),
                  underline: Container(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLocationLoaded
                ? StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('pharmacies').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No pharmacies found.'));
                      }

                      var pharmacies = filteredPharmacies(snapshot.data!.docs);

                      if (pharmacies.isEmpty) {
                        print('No pharmacies within the selected distance');
                      } else {
                        pharmacies.forEach((pharmacy) {
                          print('Pharmacy within distance: ${pharmacy.name}, ${pharmacy.distance} meters');
                        });
                      }

                      return ListView.builder(
                        itemCount: pharmacies.length,
                        itemBuilder: (context, index) {
                          var pharmacy = pharmacies[index];
                          var pharmacyId = snapshot.data!.docs[index].id;

                          if (_selectedUsers[pharmacyId] == null) {
                            _selectedUsers[pharmacyId] = false;
                          }

                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: ListTile(
                              title: Text(
                                pharmacy.name,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal,
                                ),
                              ),
                              subtitle: Text(formatDistance(pharmacy.distance.toInt())),
                              leading: IconButton(
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.teal,
                                ),
                                onPressed: () {
                                  _launchMap(pharmacy);
                                },
                              ),
                              trailing: Checkbox(
                                value: _selectedUsers[pharmacyId],
                                onChanged: (bool? value) {setState(() {
                                    _selectedUsers[pharmacyId] = value!;
                                  });
                                },
                                activeColor: Colors.teal,
                                checkColor: Colors.white,
                              ),
                              onTap: () {
                                ImageService.selectedImagePath = pharmacy.imagePath.last;
                              },
                            ),
                          );
                        },
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                bool allSelected = _selectedUsers.values.every((isSelected) => isSelected);
                _selectedUsers.updateAll((key, value) => !allSelected);
              });
            },
            label: Text(
              _selectedUsers.values.every((isSelected) => isSelected) ? 'Deselect All' : 'Select All',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: Icon(
              _selectedUsers.values.every((isSelected) => isSelected) ? Icons.deselect : Icons.select_all,
            ),
            backgroundColor: Colors.teal,
          ),
          const SizedBox(width: 16),
          anyItemSelected
              ? FloatingActionButton(
                  backgroundColor: Colors.teal,
                  onPressed: () {
                    if (ImageService.selectedImagePath != "") {
                      _handleSendImage(context, ImageService.selectedImagePath!);
                    } else {
                      print("Please select an image");
                    }
                  },
                  child: const Icon(Icons.send),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  void _launchMap(Pharmacy pharmacy) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${pharmacy.latitude},${pharmacy.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

      Timer(
        const Duration(seconds: 5),
        () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Image sent'),
                content: const Text('Your image has been successfully sent.'),
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
          content: Text('Please select at least one pharmacy.'),
        ),
      );
    }
  }

  String formatDistance(int meters) {
    if (meters >= 1000) {
      double kilometers = meters / 1000;
      return '${kilometers.toStringAsFixed(1)} km';
    } else {
      return '${meters} m';
    }
  }
}