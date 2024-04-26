
// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';

import 'package:medical/mohamed/img_controller.dart';

import 'ordonance_detail.dart';
import 'ordonnace_model.dart';

class ListOrdonnace extends StatefulWidget {
  
  const ListOrdonnace({Key? key}) : super(key: key);

  @override
  State<ListOrdonnace> createState() => _ListOrdonnaceState();
}

class _ListOrdonnaceState extends State<ListOrdonnace> {
    // final ImageController _imageController = Get.find<ImageController>();
        final ImageController _imageController = Get.put(ImageController());

  List<Ordonoces> ordonoces = [];

  Future<void> getFirestoreCollection() async {
    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('photo');

      QuerySnapshot querySnapshot = await collectionRef.get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        var imageUrl = data!['image_url'];
        Timestamp time = data['timestamp'];
        ordonoces.add(Ordonoces(
          name: time.toDate().toString(),
          ordonoce_Image: imageUrl,
          phoneNumber: '',
        ));
      });
      setState(() {}); // Refresh the UI after data retrieval
    } catch (e) {
      print('Error fetching Firestore collection: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getFirestoreCollection();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ordanance list"),
     
      ),
      body: ListView.builder(
        itemCount: ordonoces.length,
        itemBuilder: (context, index) {
          var ordonoce = ordonoces[index];
          return GestureDetector(
            onTap: () {
             _imageController.navigateToAgrandirImage(context, ordonoce.ordonoce_Image);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ImageNetwork(
                        image: ordonoce.ordonoce_Image,
                         height: 100, width: 100,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Vous avez reçu une notification aujourd\'hui',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:8.0),
                            child: Text(
                              ordonoce.name,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
}

 