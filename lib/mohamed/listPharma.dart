import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

import 'img_controller.dart';
import '../services/imagesService.dart';

class Pharmacy {
  final String name;
  final double distance;
  final double latitude;
  final double longitude;
  final String imagePath; // New field for image path
  bool isSelected;

  Pharmacy({
    required this.name,
    required this.distance,
    required this.latitude,
    required this.longitude,
    required this.imagePath, // Include image path in constructor
    this.isSelected = false,
  });
}

class PharmacyListScreen extends StatefulWidget {
  const PharmacyListScreen({Key? key}) : super(key: key);

  @override
  _PharmacyListScreenState createState() => _PharmacyListScreenState();
}

class _PharmacyListScreenState extends State<PharmacyListScreen> {
  List<double> distances = [500, 1000, 1500, 2000];
  double selectedDistance = 500;
  static ImageController controller = ImageController();
  List<Pharmacy> pharmacies = [
    Pharmacy(
      name: 'Pharmacy Benhabi fethallah',
      distance: 2.5,
      latitude: 35.30094,
      longitude: -1.12382,
      imagePath: 'path_to_image1', // Image path for pharmacy 1
    ),
    Pharmacy(
      name: 'Pharmacy DR kichah',
      distance: 4.0,
      latitude: 35.29580,
      longitude: -1.12705,
      imagePath: 'path_to_image2', // Image path for pharmacy 2
    ),
    Pharmacy(
      name: 'Pharmacy Belghoumari',
      distance: 1.2,
      latitude: 35.30728,
      longitude: -1.13514,
      imagePath: 'path_to_image3', // Image path for pharmacy 3
    ),
  ];
  bool isAllSelected = false;

  @override
  Widget build(BuildContext context) {
    bool anyItemSelected = pharmacies.any((pharmacy) => pharmacy.isSelected);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy List'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              const Flexible(
                child: Text(
                  'Choisissez la distance : ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  softWrap: true,
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
                items: [500, 1000, 1500, 2000].map<DropdownMenuItem<int>>((int distance) {
                  return DropdownMenuItem<int>(
                    value: distance,
                    child: Text(distance == 500 ? 'Moins de 500 mètres' : '${distance / 1000} km'),
                  );
                }).toList(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                icon: const Icon(Icons.arrow_drop_down),
                underline: Container(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pharmacies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(pharmacies[index].name),
                  subtitle: Text('${pharmacies[index].distance} km away'),
                  leading: IconButton(
                    icon: const Icon(Icons.location_on),
                    onPressed: () {
                      _launchMap(pharmacies[index]);
                    },
                  ),
                  trailing: Checkbox(
                    value: pharmacies[index].isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        pharmacies[index].isSelected = value!;
                        _checkAllSelected();
                      });
                    },
                  ),
                  onTap: () {
                    // Set the selected image path when a pharmacy is tapped
                    ImageService.selectedImagePath = pharmacies[index].imagePath;
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  isAllSelected = !isAllSelected;
                  pharmacies.forEach((pharmacy) {
                    pharmacy.isSelected = isAllSelected;
                  });
                });
              },
              label: Text(isAllSelected ? 'Deselect All' : 'Select All'),
              icon: const Icon(Icons.select_all),
            ),
          ),
          const SizedBox(width: 10), // Add some space between buttons
          anyItemSelected
              ? FloatingActionButton(
                  onPressed: () {
                    if (ImageService.selectedImagePath != "nn") {
                      _handleSendImage(context, ImageService.selectedImagePath!);
                    } else {
                      print("select an image please");
                    }
                  },
                  child: const Icon(Icons.send),
                )
              : const SizedBox(), // Empty SizedBox if no item is selected
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
        top: MediaQuery.of(context).size.height*0.4,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
Center(
  child:   SpinKitFadingCircle(
  
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
