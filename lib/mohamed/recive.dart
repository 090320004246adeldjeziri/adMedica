import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Message {
  final String text;
  final Timestamp timestamp;
  final String pharmacyName;

  Message({
    required this.text,
    required this.timestamp,
    required this.pharmacyName,
  });
}

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({Key? key}) : super(key: key);

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
        .where('maladeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .asyncMap(
          (snapshot) async {
            return Future.wait(
              snapshot.docs.map(
                (doc) async {
                  final pharmacyId = doc['pharmacyId'];
                  try {
                    final pharmacyDoc =
                        await _firestore.collection('users').doc(pharmacyId).get();
                    final pharmacyName = pharmacyDoc.data()?['name'] ?? 'Nom indisponible';

                    return Message(
                      text: doc['text'],
                      timestamp: doc['timestamp'],
                      pharmacyName: pharmacyName,
                    );
                  } catch (e) {
                    print("Error fetching pharmacy: $e");
                    return Message(
                      text: doc['text'],
                      timestamp: doc['timestamp'],
                      pharmacyName: 'Erreur de récupération',
                    );
                  }
                },
              ).toList(),
            );
          },
        );

    _messagesStream.listen(
      (messages) {
        print("Received ${messages.length} messages from Firestore.");
      },
      onError: (error) {
        print("Error fetching messages: $error");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.green,
            ),
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: const Color.fromRGBO(226, 239, 247, 1),
        title: Text(
          'Messages',
          style: GoogleFonts.lexend(color: Colors.green),
        ),
      ),
      body: StreamBuilder<List<Message>>(
        stream: _messagesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun message trouvé.'));
          }

          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final message = snapshot.data![index];
              final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
              final formattedDate = dateFormat.format(message.timestamp.toDate());

              return ListTile(
                title: Text(
                  message.pharmacyName,
                  style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(message.text),
                trailing: Text(
                  formattedDate,
                  style: const TextStyle(color: Colors.grey),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        },
      ),
    );
  }
}