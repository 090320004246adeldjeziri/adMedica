import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgrandirImagePage extends StatefulWidget {
  final String imageUrl;

  AgrandirImagePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<AgrandirImagePage> createState() => _AgrandirImagePageState();
}

class _AgrandirImagePageState extends State<AgrandirImagePage> {
  final TextEditingController _textController = TextEditingController();
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agrandir Image',
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        backgroundColor: Colors.teal, // Couleur de la barre d'application
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImageWidget(),
              
              const SizedBox(height: 20),
              _buildTextField(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(20),
        minScale: 0.1,
        maxScale: 4,
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          placeholder: (context, url) => SpinKitFadingCircle(
            color: Colors.grey,
            size: 50.0,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          height: 400,
          width: 300,
        ),
      ),
    );
  }


  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Entrez votre remarque ici...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.comment), // Icône pour le champ de texte
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              String text = _textEditingController.text.trim();
              if (text.isNotEmpty) {
                _sendTextToFirebase(text);
                _textEditingController.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Veuillez entrer une remarque'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: Text(
              'Envoyer',
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal, // Couleur du bouton "Envoyer"
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendTextToFirebase(String text) async {
    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'text': text,
        'timestamp': DateTime.now(),
        'isRead': false,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Message envoyé avec succès'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Échec de l\'envoi du message'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      print(e);
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}