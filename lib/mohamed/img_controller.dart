// ignore_for_file: avoid_print, unused_import

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

import '../partie_pharmacy/ordonance_detail.dart';



class ImageController extends GetxController {
  Future<String?> selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      // L'image a été sélectionnée depuis la galerie ou capturée depuis la caméra
      // Retourner le chemin de l'image sélectionnée
      return pickedImage.path;
    } else {
      // Aucune image n'a été sélectionnée ou capturée
      // Gérer cet état en conséquence
      return null;
    }
  }

  Future<String?> afficheImage(ImageSource imageSource) async {
    String? imagePath;

    imagePath = await selectImage(imageSource);

    return (imagePath);
  }

 
  Future<String?> uploadImageToFirebaseStorage(String imagePath) async {
  File image = File(imagePath);
  String imageName = path.basename(image.path);
  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref().child(imageName);

  try {
    // Téléverser l'image
    await ref.putFile(image);
    
    // Obtenir l'URL de téléchargement
    String downloadURL = await ref.getDownloadURL();
    
    return downloadURL; // Retourner l'URL de téléchargement
  } catch (e) {
    // Gérer les erreurs de téléversement
    print('Error uploading image: $e');
    return null;
  }
}

Future<void> uploadImageAndAddToFirestore(String imagePath,List<String> pharmacyIds) async {
  // Téléverser l'image vers Firebase Storage et obtenir l'URL de téléchargement
  String? imageUrl = await uploadImageToFirebaseStorage(imagePath);
   String? senderId = FirebaseAuth.instance.currentUser?.uid;

  if (imageUrl != null && senderId != null) {
    // Ajouter l'URL de l'image à Firestore
    try {
      await FirebaseFirestore.instance.collection('photo').add({
        'image_url': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'isRead':false,
        'senderId': senderId,
        'pharmacy': pharmacyIds,
      });
      print('Image URL added to Firestore');
    } catch (e) {
      print('Error adding image URL to Firestore: $e');
    }
  } else {
    print('L\'URL de l\'image est null, veuillez vérifier les erreurs.');
  }
}
 void navigateToAgrandirImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgrandirImagePage(imageUrl: imageUrl),
      ),
    );
  }


  
}

