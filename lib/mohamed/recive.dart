import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class Message {
  final String text;
  final Timestamp timestamp;

  Message({
    required this.text,
    required this.timestamp,
  });
}

class MessageListScreen extends StatefulWidget {
  @override
  _MessageListScreenState createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<List<Message>> _messagesStream;
  @override
  void initState() {
    super.initState();
    _messagesStream = _firestore
        .collection('messages')
        .orderBy('timestamp', descending: true) // Tri par timestamp décroissant
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Message(
                  text: doc['text'],
                  timestamp: doc['timestamp'],
                ))
            .toList());

    // Ajout des print statements pour le débogage
    print("Fetching messages from Firestore...");
    _messagesStream.listen((messages) {
      print("Received ${messages.length} messages from Firestore.");
    }, onError: (error) {
      print("Error fetching messages: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.transparent),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.green,
              ),
            ),
            onPressed: (() {
              Get.back();
            })),
        backgroundColor: Color.fromRGBO(226, 239, 247, 1),
        title: Text('Messages', style: GoogleFonts.lexend(color: Colors.green)),
      ),
      body: StreamBuilder<List<Message>>(
        stream: _messagesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Aucun message trouvé.'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Message message = snapshot.data![index];
              return ListTile(
                title: Text(message.text),
                trailing: Text(
                  message.timestamp.toDate().toString(),
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
