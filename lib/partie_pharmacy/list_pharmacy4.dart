import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'list_ordanace_detail.dart';

class Notif extends StatefulWidget {
  const Notif({Key? key}) : super(key: key);

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  String? userName;
  // String? pharmacyId;

  @override
  void initState() {
    super.initState();
    _getCurrentUserNameAndPharmacyId();
  }

  Future<void> _getCurrentUserNameAndPharmacyId() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc['name'] as String;
            // pharmacyId = userDoc['pharmacyId'] as String;
            // print('Pharmacy ID: $pharmacyId');
          });
        } else {
          print('User document does not exist');
        }
      } else {
        print('No user is currently signed in');
      }
    } catch (e) {
      print('Error fetching current user name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName != null ? 'Notifications - $userName' : 'Notifications'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('photo')
            .where('isRead', isEqualTo: false)
            .where('pharmacy', arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print('Error fetching photos: ${snapshot.error}');
            return const Center(child: Text('Erreur de chargement des notifications'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print('No photos found');
            return const Center(child: Text('Aucune image reçue'));
          }

          // Debugging: Print the fetched documents
          print('Photos found: ${snapshot.data!.docs.length}');
          snapshot.data!.docs.forEach((doc) {
            print('Photo: ${doc.data()}');
          });

          return GestureDetector(
            onTap: () {
              
            },
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                return NotifCard(
                  doc: doc,
                  imageUrl: doc['image_url'] as String,
                  timestamp: (doc['timestamp'] as Timestamp).toDate(),
                );
              },
            ),
          );
        },
      )  // Show loading until pharmacyId is available
    );
  }
}

class NotifCard extends StatelessWidget {
  final DocumentSnapshot doc;
  final String imageUrl;
  final DateTime timestamp;

  const NotifCard({
    Key? key,
    required this.doc,
    required this.imageUrl,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String senderId = doc['maladeId'] as String;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String senderName = snapshot.data!['name'] as String;

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              ),
              title: Text(senderName),
              subtitle: Text(timestamp.toString()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  AgrandirImagePage(imageUrl: imageUrl, senderId: FirebaseAuth.instance.currentUser!.uid,recepteurId:senderId)
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          print('Error fetching sender info: ${snapshot.error}');
          return const ListTile(
            title: Text('Erreur lors du chargement des informations de l\'expéditeur'),
          );
        } else {
          return const ListTile(
            title: Text('Chargement...'),
          );
        }
      },
    );
  }
}