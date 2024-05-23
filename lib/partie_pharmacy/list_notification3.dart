import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical/models/photo_model.dart';

class ListNot extends StatelessWidget {
  final PhotoModel photoModel;

  const ListNot({super.key, required this.photoModel});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('photo').doc(photoModel.id).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        String userId = photoModel.maladeId;

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
          builder: (context, userSnapshot) {
            if (!userSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            var userData = userSnapshot.data!.data() as Map<String, dynamic>;
            String userName = userData['name'] ?? 'Unknown';

            return Card(
              child: ListTile(
                onTap: () {},
                leading: const CircleAvatar(),
                title: Text(userName),
                subtitle: const Text("data"),
              ),
            );
          },
        );
      },
    );
  }
}