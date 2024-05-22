import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String prenom;
  final String role;
  final String uid;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.prenom,
    required this.role,
    required this.uid,
  });

  // Méthode pour convertir un document Firestore en instance de User
  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      prenom: data['prenom'] ?? '',
      role: data['role'] ?? '',
      uid: data['uid'] ?? '',
    );
  }

  // Méthode pour convertir une instance de User en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'prenom': prenom,
      'role': role,
      'uid': uid,
    };
  }
}