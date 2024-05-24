import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'recive.dart';

class NotificationIcon extends StatefulWidget {
  @override
  _NotificationIconState createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  int _newDocumentCount = 0;

  @override
  void initState() {
    super.initState();
    listenToDocumentChanges();
    fetchNewDocuments();
  }

  void fetchNewDocuments() {
    FirebaseFirestore.instance
        .collection('messages')
        .where('isRead', isEqualTo: false).orderBy('timestamp',descending: true).where('maladeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((querySnapshot) {
      setState(() {
        _newDocumentCount = querySnapshot.size;
      });
    });
  }

  void markDocumentsAsRead() {
    FirebaseFirestore.instance
        .collection('messages')
        .where('isRead', isEqualTo: false).where('maladeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({'isRead': true});
      });
    });
  }

  void listenToDocumentChanges() {
    FirebaseFirestore.instance
        .collection('messages')
        .where('isRead', isEqualTo: false).where('maladeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((querySnapshot) {
      setState(() {
        _newDocumentCount = querySnapshot.size;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      position: BadgePosition.topEnd(top: 20, end: 5),
      badgeContent: _newDocumentCount > 0
          ? Text('$_newDocumentCount',
              style: const TextStyle(color: Color.fromARGB(255, 223, 214, 214)))
          : null,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: IconButton(
          alignment: Alignment.center,
          icon: const Icon(
            Icons.notifications,
            size: 30,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MessageListScreen()),
            );
            markDocumentsAsRead(); // Mark documents as read when notification icon is pressed
          },
        ),
      ),
    );
  }
}
