// import 'package:flutter/material.dart';
// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medical/services/imagesService.dart';

import 'img_controller.dart';

class LIstPharma2 extends StatefulWidget {
  final String name;
  const LIstPharma2({super.key, required this.name});

  @override
  State<LIstPharma2> createState() => _LIstPharma2State();
}

class _LIstPharma2State extends State<LIstPharma2> {
   static ImageController controller = ImageController();
  // Map pour garder la trace des états de chaque case à cocher
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
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('role', isEqualTo: 'Pharmacy')
                  .snapshots(),
              builder: (context, snapshot) {
                  if (snapshot.hasError) {
                  return Center(
                    child: Text('Une erreur s\'est produite : ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Aucun utilisateur trouvé.'));
                }

                var users = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var user = users[index];
                    var userData = user.data() as Map<String, dynamic>;
                    var userId = user.id;

                    // Initialiser l'état de la case à cocher si nécessaire
                    if (_selectedUsers[userId] == null) {
                      _selectedUsers[userId] = false;
                    }

                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: _selectedUsers[userId],
                          onChanged: (bool? value) {
                            setState(() {
                              _selectedUsers[userId] = value!;
                            });
                          },
                        ),
                        title: Text(userData['name'] ?? 'Nom inconnu'),
                        subtitle: const Text('Distance' ),
                        // Ajouter d'autres champs si nécessaire
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

void _handleSendImage(BuildContext context, String selectedImagePath) {
  // Récupérer les IDs des pharmacies sélectionnées
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
    // Afficher un message d'erreur si aucune pharmacie n'est sélectionnée
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Veuillez sélectionner au moins une pharmacie.'),
      ),
    );
  }
}
}