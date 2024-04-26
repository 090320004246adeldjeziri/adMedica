import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'list_notification.dart';

class NotificationIconPharma extends StatefulWidget {
  @override
  _NotificationIconPharmaState createState() => _NotificationIconPharmaState();
}

class _NotificationIconPharmaState extends State<NotificationIconPharma> {
  int _newDocumentsCount = 0;
  bool _isInitialCountLoaded = false;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _listenToDocumentChanges();
  }

  Future<void> _fetchNewDocuments() async {
    setState(() {
      _isInitialCountLoaded = true;
    });

    final querySnapshot = await _firestore
        .collection('photo')
        .where('isRead', isEqualTo: false)
        .get();

    setState(() {
      _newDocumentsCount = querySnapshot.size;
    });
  }

  Future<void> _markDocumentsAsRead() async {
    final querySnapshot = await _firestore
        .collection('photo')
        .where('isRead', isEqualTo: false)
        .get();

    for (final doc in querySnapshot.docs) {
      await doc.reference.update({'isRead': true});
    }
  }

  void _listenToDocumentChanges() {
    _firestore
        .collection('photo')
        .where('isRead', isEqualTo: false)
        .snapshots()
        .listen((querySnapshot) {
      setState(() {
        _newDocumentsCount = querySnapshot.size;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      position: BadgePosition.topEnd(top: 20, end: 5),
      badgeContent: _newDocumentsCount > 0
          ? Text(
              '$_newDocumentsCount',
              style: const TextStyle(color: Color.fromARGB(255, 223, 214, 214)),
            )
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
          onPressed: () async {
            await _markDocumentsAsRead();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListOrdonnace()),
            );
          },
        ),
      ),
    );
  }
}