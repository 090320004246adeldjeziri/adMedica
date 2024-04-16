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
  bool _iconPressed = false;
  bool _initialCountLoaded = false;

  @override
  void initState() {
    super.initState();
    listenToDocumentChanges();
  }

  void listenToDocumentChanges() {
    
    FirebaseFirestore.instance
        .collection('messages')
        .snapshots()
        .listen((snapshot) {
          List<dynamic> messages = snapshot.docs.where((element) => !element['isRead']).toList();
      if (_iconPressed) {
        setState(() {
          _newDocumentCount = 0;

            DocumentReference documentReference = FirebaseFirestore.instance
      .collection('messages').where('isRead',isEqualTo: false) as DocumentReference<Object?>;
        });
      } else if (!_initialCountLoaded) {
        // Comptez le nombre initial de documents si l'icône n'a jamais été cliquée
        setState(() {
          _newDocumentCount =  messages.length;
          _initialCountLoaded = true;
        });
      } else {
        snapshot.docChanges.forEach((change) {
          if (change.type == DocumentChangeType.added) {
            setState(() {
              _newDocumentCount++;
            });
          }
        });
      }
    });
  }

  void fetchNewDocuments() {
    setState(() {
      _iconPressed = true;
    });
    // Ajoutez ici la logique pour récupérer les nouveaux documents
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
              MaterialPageRoute(builder: (context) => MessageListScreen()),
            );
            fetchNewDocuments();
          },
        ),
      ),
    );
  }
}