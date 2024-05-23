// // import 'package:flutter/material.dart';
// // ignore_for_file: depend_on_referenced_packages

// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:medical/modelPharm.dart';
// import 'package:medical/services/imagesService.dart';
// import 'package:medical/view/location.dart';
// import 'package:get/get.dart';
// import 'img_controller.dart';

// class LIstPharma2 extends StatefulWidget {
//   const LIstPharma2({
//     super.key,
//   });

//   @override
//   State<LIstPharma2> createState() => _LIstPharma2State();
// }

// class _LIstPharma2State extends State<LIstPharma2> {
//   static ImageController controller = ImageController();
//   LocationController locControl = Get.put(LocationController());
//   // Map pour garder la trace des états de chaque case à cocher
//   Map<String, bool> _selectedUsers = {};

//   @override
//   Widget build(BuildContext context) {
// double calculateDistance(
//   double startLatitude,
//   double startLongitude,
//   double endLatitude,
//   double endLongitude,
// ) {
//   double distanceInMeters = Geolocator.distanceBetween(
//     startLatitude,
//     startLongitude,
//     endLatitude,
//     endLongitude,
//   );
//   return distanceInMeters;
// }
// String formatDistance(int distance) {
//   return distance <= 1000 ? '$distance meters' : '${(distance / 10000).toStringAsFixed(1)} km';
// }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pharmacy Users'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('pharmacies')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 // if (snapshot.hasError) {
//                 //   return Center(
//                 //     child:
//                 //         Text('Une erreur s\'est produite : ${snapshot.error}'),
//                 //   );
//                 // }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(child: Text('Aucun utilisateur trouvé.'));
//                 }

//                 var users = snapshot.data!.docs;
                

//                 return ListView.builder(
//                   itemCount: users.length,
//                   itemBuilder: (context, index) {
//                     var user = users[index];
//                     var userData = user.data() as Map<String, dynamic>;
//                     var userId = user.id;

//                     // Initialiser l'état de la case à cocher si nécessaire
//                     if (_selectedUsers[userId] == null) {
//                       _selectedUsers[userId] = false;
//                     }

//                     return Card(
//                       child: ListTile(
//                         leading: Checkbox(
//                           value: _selectedUsers[userId],
//                           onChanged: (bool? value) {
//                             setState(() {
//                               _selectedUsers[userId] = value!;
//                             });
//                           },
//                         ),
//                         title: Text(userData['name']),
//                       subtitle:  Text(
// formatDistance(
//                           calculateDistance(
//   locControl.latitude.value,
//   locControl.longitude.value,
//   userData['latitude'],
//   userData['longitude'],
// ).toInt())

//                           ),
//                         // Ajouter d'autres champs si nécessaire
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (ImageService.selectedImagePath != "") {
//                 _handleSendImage(context, ImageService.selectedImagePath!);
//               } else {
//                 print("Veuillez sélectionner une image");
//               }
//             },
//             child: const Text('Envoyer un message'),
//           ),
//         ],
//       ),
//     );
//   }

//   // void _sendMessageToSelectedPharmacies() {
//   //   // Récupérer les IDs des pharmacies sélectionnées
//   //   List<String> selectedPharmacyIds = _selectedUsers.entries
//   //       .where((entry) => entry.value == true)
//   //       .map((entry) => entry.key)
//   //       .toList();

//   //   if (selectedPharmacyIds.isNotEmpty) {
//   //     // Afficher une boîte de dialogue pour saisir le message
//   //     showDialog(
//   //       context: context,
//   //       builder: (context) => AlertDialog(
//   //         title: const Text('Envoyer un message'),
//   //         content: TextField(
//   //           maxLines: null,
//   //           decoration: const InputDecoration(
//   //             hintText: 'Saisissez votre message ici',
//   //           ),
//   //           onChanged: (value) {
//   //             // Enregistrer le message saisi
//   //           },
//   //         ),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () => Navigator.of(context).pop(),
//   //             child: const Text('Annuler'),
//   //           ),
//   //           ElevatedButton(
//   //             onPressed: () {
//   //               // Envoyer le message aux pharmacies sélectionnées
//   //               _sendMessage(selectedPharmacyIds, 'Votre message ici');
//   //               Navigator.of(context).pop();
//   //             },
//   //             child: const Text('Envoyer'),
//   //           ),
//   //         ],
//   //       ),
//   //     );
//   //   } else {
//   //     // Afficher un message d'erreur si aucune pharmacie n'est sélectionnée
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(
//   //         content: Text('Veuillez sélectionner au moins une pharmacie.'),
//   //       ),
//   //     );
//   //   }
//   // }

// // void _sendMessage(List<String> pharmacyIds, String message) {
// //   // Créer un objet avec le message à envoyer
// //   Map<String, dynamic> messageData = {
// //     'message': message,
// //     'timestamp': FieldValue.serverTimestamp(),
// //   };

// //   // Envoyer le message à chaque pharmacie sélectionnée
// //   for (String pharmacyId in pharmacyIds) {
// //     FirebaseFirestore.instance
// //         .collection('users')
// //         .doc(pharmacyId)
// //         .collection('messages')
// //         .add(messageData)
// //         .then((value) {
// //       // Le message a été envoyé avec succès
// //       print('Message envoyé à la pharmacie $pharmacyId');
// //     }).catchError((error) {
// //       // Une erreur s'est produite lors de l'envoi du message
// //       print('Erreur lors de lenvoi du message à la pharmacie $pharmacyId : $error');
// //     });
// //   }
// // }

//   void _handleSendImage(BuildContext context, String selectedImagePath) {
//     // Récupérer les IDs des pharmacies sélectionnées
//     List<String> selectedPharmacyIds = _selectedUsers.entries
//         .where((entry) => entry.value == true)
//         .map((entry) => entry.key)
//         .toList();

//     if (selectedPharmacyIds.isNotEmpty) {
//       controller.uploadImageToFirebaseStorage(selectedImagePath);

//       for (String pharmacyId in selectedPharmacyIds) {
//         controller.uploadImageAndAddToFirestore(
//             selectedImagePath, selectedPharmacyIds);
//       }

//       OverlayEntry? overlayEntry;
//       overlayEntry = OverlayEntry(
//         builder: (context) => Positioned(
//           top: MediaQuery.of(context).size.height * 0.4,
//           left: 0,
//           right: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: const [
//               Center(
//                 child: SpinKitFadingCircle(
//                   color: Colors.green,
//                   size: 100.0,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );

//       Overlay.of(context)?.insert(overlayEntry);

//       Timer(
//         const Duration(seconds: 5),
//         () {
//           overlayEntry?.remove();
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: const Text('Image envoyée'),
//                 content: const Text('Votre image a été envoyée avec succès.'),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       Navigator.of(context).pop();
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text('OK'),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//       );
//     } else {
//       // Afficher un message d'erreur si aucune pharmacie n'est sélectionnée
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Veuillez sélectionner au moins une pharmacie.'),
//         ),
//       );
//     }
//   }
// }
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

  // void _sendMessageToSelectedPharmacies() {
  //   // Récupérer les IDs des pharmacies sélectionnées
  //   List<String> selectedPharmacyIds = _selectedUsers.entries
  //       .where((entry) => entry.value == true)
  //       .map((entry) => entry.key)
  //       .toList();

  //   if (selectedPharmacyIds.isNotEmpty) {
  //     // Afficher une boîte de dialogue pour saisir le message
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Envoyer un message'),
  //         content: TextField(
  //           maxLines: null,
  //           decoration: const InputDecoration(
  //             hintText: 'Saisissez votre message ici',
  //           ),
  //           onChanged: (value) {
  //             // Enregistrer le message saisi
  //           },
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('Annuler'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               // Envoyer le message aux pharmacies sélectionnées
  //               _sendMessage(selectedPharmacyIds, 'Votre message ici');
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Envoyer'),
  //           ),
  //         ],
  //       ),
  //     );
  //   } else {
  //     // Afficher un message d'erreur si aucune pharmacie n'est sélectionnée
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Veuillez sélectionner au moins une pharmacie.'),
  //       ),
  //     );
  //   }
  // }

// void _sendMessage(List<String> pharmacyIds, String message) {
//   // Créer un objet avec le message à envoyer
//   Map<String, dynamic> messageData = {
//     'message': message,
//     'timestamp': FieldValue.serverTimestamp(),
//   };

//   // Envoyer le message à chaque pharmacie sélectionnée
//   for (String pharmacyId in pharmacyIds) {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(pharmacyId)
//         .collection('messages')
//         .add(messageData)
//         .then((value) {
//       // Le message a été envoyé avec succès
//       print('Message envoyé à la pharmacie $pharmacyId');
//     }).catchError((error) {
//       // Une erreur s'est produite lors de l'envoi du message
//       print('Erreur lors de lenvoi du message à la pharmacie $pharmacyId : $error');
//     });
//   }
// }

  void _handleSendImage(BuildContext context, String selectedImagePath) async {
    List<String> selectedPharmacyIds = _selectedUsers.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

  if (selectedPharmacyIds.isNotEmpty) {
    // Show the loading overlay
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

    try {
      // Wait for the image upload to complete
      await controller.uploadImageToFirebaseStorage(selectedImagePath);

      // Add the image reference to Firestore
      for (String pharmacyId in selectedPharmacyIds) {
        await controller.uploadImageAndAddToFirestore(selectedImagePath, selectedPharmacyIds);
      }

      // Remove the loading overlay
      overlayEntry.remove();

      // Show success dialog
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
    } catch (e) {
      // Remove the loading overlay
      overlayEntry.remove();

      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: const Text('Échec de l\'envoi de l\'image. Veuillez réessayer.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } else {
    // Afficher un message d'erreur si aucune pharmacie n'est sélectionnée
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Veuillez sélectionner au moins une pharmacie.'),
      ),
    );
  }
}

}