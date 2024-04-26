import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import 'img_controller.dart';
import '../services/imagesService.dart';

class Pharmacy {
  final String name;
  final double distance;
  final double latitude;
  final double longitude;
  final String imagePath;
  bool isSelected;

  Pharmacy({
    required this.name,
    required this.distance,
    required this.latitude,
    required this.longitude,
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
  List<double> distances = [500, 1000, 1500, 2000];
  double selectedDistance = 500;
  static ImageController controller = ImageController();
  List<Pharmacy> pharmacies = [
    Pharmacy(
      name: 'Pharmacy Benhabi fethallah',
      distance: 100,
      latitude: 35.30094,
      longitude: -1.12382,
      imagePath: 'path_to_image1',
    ),
    Pharmacy(
      name: 'Pharmacy DR kichah',
      distance: 300,
      latitude: 35.29580,
      longitude: -1.12705,
      imagePath: 'path_to_image2',
    ),
    Pharmacy(
      name: 'Pharmacy Belghoumari',
      distance: 490,
      latitude: 35.30728,
      longitude: -1.13514,
      imagePath: 'path_to_image3',
    ),
  ];
  bool isAllSelected = false;

  @override
  Widget build(BuildContext context) {
    bool anyItemSelected = pharmacies.any((pharmacy) => pharmacy.isSelected);

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
                    'Sélectionnez la distance : ',
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
                            ? 'Moins de 500 mètres'
                            : '${distance / 1000} km',
                        style: GoogleFonts.poppins(
                          color: Colors.teal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  icon: Icon(
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
              itemCount: pharmacies.length,
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
                      pharmacies[index].name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.teal,
                      ),
                    ),
                    subtitle: Text(
                      '${pharmacies[index].distance.toStringAsFixed(1)} m',
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.teal,
                      ),
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
                      activeColor: Colors.teal,
                      checkColor: Colors.white,
                    ),
                    onTap: () {
                      // Set the selected image path when a pharmacy is tapped
                      ImageService.selectedImagePath =
                          pharmacies[index].imagePath;
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
              isAllSelected ? 'Désélectionner tout' : 'Sélectionner tout',
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
                      _handleSendImage(context, ImageService.selectedImagePath!);
                    } else {
                      print("Veuillez sélectionner une image");
                    }
                  },
                  child: const Icon(Icons.send),
                )
              : const SizedBox(),
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
