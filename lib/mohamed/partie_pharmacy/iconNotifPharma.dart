// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'list_notification.dart';



class NotificationIconPharma extends StatefulWidget {
  const NotificationIconPharma({super.key});

  @override
  _NotificationIconPharmaState createState() => _NotificationIconPharmaState();
}

class _NotificationIconPharmaState extends State<NotificationIconPharma> {
  int _newDocumentCount = 0;
  bool _iconPressed = false;
  bool _initialCountLoaded = false;

  @override
  void initState() {
    super.initState();
   listenToDocumentChanges();
    fetchNewDocuments();
  }


void fetchNewDocuments() {
  setState(() {
    _initialCountLoaded = true;
  });

  // Marquer les documents comme lus dans Firebase Firestore
  FirebaseFirestore.instance
      .collection('photo')
      .where('isRead', isEqualTo: false) // Sélectionnez uniquement les documents non lus
      .get()
      .then((querySnapshot) {
    setState(() {
      _initialCountLoaded = true;
      _newDocumentCount = querySnapshot.size;
    });
  });
}

void fetchNewDocuments2() {
  setState(() {
    _iconPressed = true;
  });
  
  // Marquer les documents comme lus dans Firebase Firestore
  FirebaseFirestore.instance
      .collection('photo')
      .where('isRead', isEqualTo: false) // Sélectionnez uniquement les documents non lus
      .get()
      .then((querySnapshot) {
    print(querySnapshot.size);
    querySnapshot.docs.forEach((doc) {
      doc.reference.update({'isRead': true});
      // Mettre à jour le champ isRead à true
    });
  });



  // Add a snapshot listener to listen for real-time updates in the 'messages' collection
  FirebaseFirestore.instance
      .collection('photo')
      .where('isRead', isEqualTo: false)
      .snapshots()
      .listen((querySnapshot) {
    setState(() {
      _newDocumentCount = querySnapshot.size;
    });
  });
}
   void listenToDocumentChanges() {
    FirebaseFirestore.instance
        .collection('photo')
        .where('isRead', isEqualTo: false)
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
      badgeContent: _newDocumentCount > 0 && !_iconPressed
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
              MaterialPageRoute(builder: (context) => ListOrdonnace()),
            );
            fetchNewDocuments2();
          },
        ),
      ),
    );
  }
}
