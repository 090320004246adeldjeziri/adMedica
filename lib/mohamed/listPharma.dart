import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medical/mohamed/img_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';

import '../services/imagesService.dart';

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

class PharmacyListScreen extends StatefulWidget {
  const PharmacyListScreen({Key? key}) : super(key: key);

  @override
  _PharmacyListScreenState createState() => _PharmacyListScreenState();
}

class _PharmacyListScreenState extends State<PharmacyListScreen> {
  List<Pharmacy> pharmacies = [
    Pharmacy(
      name: 'Pharmacy Benhabi fethallah',
      email: 'benhabi@gmail.com',
      latitude: 35.30094,
      longitude: -1.12382,
      imagePath: [""],
    ),
    Pharmacy(
      name: 'Pharmacy DR kichah',
      latitude: 35.29580,
      longitude: -1.12705,
      email: 'kichah@gmail.com',
      imagePath: [""],
    ),
    Pharmacy(
      name: 'Pharmacy Belghoumari',
      latitude: 35.30728,
      longitude: -1.13514,
      email: "Belghoumari@gmail.com",
      imagePath: [""],
    ),
    Pharmacy(
      name: "Benmoussa",
      latitude: 35.30955709263271,
      longitude: -1.1337590229870942,
      email: "benmoussa@gmail.com",
      imagePath: [""],
    ),
    Pharmacy(
      name: "Saidi",
      latitude: 35.3101174216988,
      longitude: -1.1480069170569,
      email: "saidi@gmail.com",
      imagePath: [""],
    )
  ];
  bool isAllSelected = false;
  double selectedDistance = 500;
  Position? currentPosition;
  static ImageController controller = ImageController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentPosition = position;
    });
  }

  // todo litle modification
  List<Pharmacy> filteredPharmacies() {
  if (currentPosition != null) {
    return pharmacies.where((pharmacy) {
      double distanceInMeters = Geolocator.distanceBetween(
        35.30728,
        -1.13514,
        // currentPosition!.latitude,
        // currentPosition!.longitude,
        pharmacy.latitude,
        pharmacy.longitude,
      );
      
      pharmacy.distance = distanceInMeters;

      return distanceInMeters <= selectedDistance;
    }).toList();
  } else {
    return [];
  }
}


  @override
  Widget build(BuildContext context) {
    bool anyItemSelected = pharmacies.any((pharmacy) => pharmacy.isSelected);
String formatDistance(int meters) {
  if (meters >= 1000) {
    double kilometers = meters / 1000;
    return '${kilometers.toStringAsFixed(1)} km';
  } else {
    return '${meters} m';
  }
}
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
                  items: [500, 1000, 1500, 2000]
                      .map<DropdownMenuItem<int>>((int distance) {
                    return DropdownMenuItem<int>(
                      value: distance,
                      child: Text(
                        distance == 500
                            ? 'Less than 500 meters'
                            : '${distance / 1000} km',
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
            child: ListView.builder(
              itemCount: filteredPharmacies().length,
              itemBuilder: (context, index) {
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
                      filteredPharmacies()[index].name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.teal,
                      ),
                    ),
                    subtitle: Text(formatDistance(filteredPharmacies()[index].distance.toInt())),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.teal,
                      ),
                      onPressed: () {
                        _launchMap(filteredPharmacies()[index]);
                      },
                    ),
                    trailing: Checkbox(
                      value: filteredPharmacies()[index].isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          filteredPharmacies()[index].isSelected = value!;
                          _checkAllSelected();
                        });
                      },
                      activeColor: Colors.teal,
                      checkColor: Colors.white,
                    ),
                    onTap: () {
                      // Set the selected image path when a pharmacy is tapped
                      ImageService.selectedImagePath =
                          filteredPharmacies()[index].imagePath.last;
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                isAllSelected = !isAllSelected;
                pharmacies.forEach((pharmacy) {
                  pharmacy.isSelected = isAllSelected;
                });
              });
            },
            label: Text(
              isAllSelected ? 'Deselect All' : 'Select All',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: Icon(
              isAllSelected ? Icons.deselect : Icons.select_all,
            ),
            backgroundColor: Colors.teal,
          ),
          const SizedBox(width: 16),
          anyItemSelected
              ? FloatingActionButton(
                  backgroundColor: Colors.teal,
                  onPressed: () {
                    if (ImageService.selectedImagePath != "nn") {
                      _handleSendImage(
                          context, ImageService.selectedImagePath!);
                    } else {
                      print("Veuillez sélectionner une image");
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

  void _checkAllSelected() {
    setState(() {
      isAllSelected = pharmacies.every((pharmacy) => pharmacy.isSelected);
    });
  }

  void _handleSendImage(BuildContext context, String selectedImagePath) {
    controller.uploadImageToFirebaseStorage(selectedImagePath);
    controller.uploadImageAndAddToFirestore(selectedImagePath);

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
  }
}
