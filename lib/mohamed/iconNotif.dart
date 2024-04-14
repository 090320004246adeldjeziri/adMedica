import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  int _newDocumentCount = 0;

  void updateNewDocumentCount(int count) {
    setState(() {
      _newDocumentCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Widget'),
      ),
      body: NotificationIcon(
        updateNewDocumentCount: updateNewDocumentCount,
      ),
    );
  }
}

class NotificationIcon extends StatefulWidget {
  final void Function(int) updateNewDocumentCount;

  const NotificationIcon({required this.updateNewDocumentCount});

  @override
  _NotificationIconState createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  int _newDocumentCount = 0;
  bool _iconPressed = false;

  @override
  void initState() {
    super.initState();
    listenToDocumentChanges();
  }

  void listenToDocumentChanges() {
    FirebaseFirestore.instance.collection('messages').snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added && !_iconPressed) {
          setState(() {
            _newDocumentCount++;
          });
        }
      });
    });
  }

  void fetchNewDocuments() {
    setState(() {
      _newDocumentCount = 0;
      _iconPressed = true;
    });
    widget.updateNewDocumentCount(_newDocumentCount);
    // Ajoutez ici la logique pour récupérer les nouveaux documents
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      position: BadgePosition.topEnd(top: 2, end: 9),
      badgeContent: _newDocumentCount > 0 && !_iconPressed
          ? Text('$_newDocumentCount', style: const TextStyle(color: Color.fromARGB(255, 223, 214, 214)))
          : null,
      child: IconButton(
        icon: const Icon(Icons.notifications, color: Colors.green,),
        onPressed: () {
          fetchNewDocuments();
        },
      ),
    );
  }
}
