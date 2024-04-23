import 'package:cloud_firestore/cloud_firestore.dart';


class Users {
  final String seller;
  final String prix;
  final String productName;
  final List<String> imgUrl;
  final String description;
  final String place;
  final String category;
  final String number;
  final String quantity;

  Users({
    required this.prix,
    required this.productName,
    required this.imgUrl,
    required this.description,
    required this.number,
    required this.place,
    required this.category,
    required this.quantity,
    required this.seller,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      seller: json['seller'] ?? '',
      description: json['description'] ?? '',
      place: json['place'] ?? '',
      prix: json['prix'] ?? '',
      quantity: json['quantity'] ?? '',
      category: json['category'] ?? '',
      productName: json['productName'] ?? '',
      number: json['number'] ?? '',
      imgUrl: List<String>.from(json['imgUrl'] ?? ['']), // Handle null value for imgUrl
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prix': prix,
      'productName': productName,
      'imgUrl': imgUrl,
      'description': description,
      'place': place,
      'number': number,
      'category': category,
      'quantity': quantity,
      'seller': seller,
    };
  }

  // Method to send the CabItem to Firestore
  Future<void> sendToFirestore() async {
    try {
      final productsRef = FirebaseFirestore.instance.collection('items');
      await productsRef.add(toJson()); // Use add() instead of doc().set()
      print('CabItem sent to Firestore successfully!');
    } catch (e) {
      print('Error sending CabItem to Firestore: $e');
    }
  }
}

List<Users> users = [];

Future<void> fetchDataFromFirestore() async {
  try {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').get();

    users.clear();

    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      users.add(
        Users.fromJson(data),
      );
    }
  } on FirebaseException catch (e) {
    print('Error fetching data from Firestore: $e');
  }
}
