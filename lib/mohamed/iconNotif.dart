import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    FirebaseFirestore.instance.collection('messages').snapshots().listen((snapshot) {
      if (_iconPressed) {
        setState(() {
          _newDocumentCount = 0;
        });
      } else if (!_initialCountLoaded) {
        // Comptez le nombre initial de documents si l'icône n'a jamais été cliquée
        setState(() {
          _newDocumentCount = snapshot.docChanges.length;
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
      position: BadgePosition.topEnd(top: 2, end: 9),
      badgeContent: _newDocumentCount > 0 && !_iconPressed ? Text('$_newDocumentCount', style: const TextStyle(color: Color.fromARGB(255, 223, 214, 214))) : null,
      child: IconButton(
        icon: const Icon(Icons.notifications, color: Colors.green,),
        onPressed: () {
          fetchNewDocuments();
        },
      ),
    );
  }
}
