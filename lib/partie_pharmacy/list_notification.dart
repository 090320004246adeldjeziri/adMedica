import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical/mohamed/img_controller.dart';
import 'ordonance_detail.dart';
import 'ordonnace_model.dart';

class ListOrdonnace extends StatefulWidget {
  const ListOrdonnace({Key? key}) : super(key: key);

  @override
  State<ListOrdonnace> createState() => _ListOrdonnaceState();
}

class _ListOrdonnaceState extends State<ListOrdonnace> {
  final ImageController _imageController = Get.put(ImageController());
  List<Ordonoces> ordonoces = [];

  Future<void> getFirestoreCollection({bool orderByLatest = true}) async {
    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('photo');

      QuerySnapshot querySnapshot;
      if (orderByLatest) {
        querySnapshot = await collectionRef
            .orderBy('timestamp', descending: true)
            .get();
      } else {
        querySnapshot = await collectionRef.get();
      }

      ordonoces.clear();
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        var imageUrl = data!['image_url'];
        Timestamp time = data['timestamp'];
        ordonoces.add(Ordonoces(
          docId: doc.id, // Ajout de l'ID du document
          name: time.toDate().toString(),
          ordonoce_Image: imageUrl,
          phoneNumber: '',
        ));
      });
      setState(() {});
    } catch (e) {
      print('Error fetching Firestore collection: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getFirestoreCollection();
  }

  Future<void> deleteOrdonnance(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('photo').doc(docId).delete();
      getFirestoreCollection(); // Rafraîchir la liste après la suppression
    } catch (e) {
      print('Error deleting ordonnance: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Ordonnances"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: ordonoces.length,
        itemBuilder: (context, index) {
          var ordonoce = ordonoces[index];
          return GestureDetector(
            onTap: () {
              _imageController.navigateToAgrandirImage(
                  context, ordonoce.ordonoce_Image);
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade200, Colors.green.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: ordonoce.ordonoce_Image,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nouvelle ordonnance reçue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              ordonoce.name,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => deleteOrdonnance(ordonoce.docId),
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}