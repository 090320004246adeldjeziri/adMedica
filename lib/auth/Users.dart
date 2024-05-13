import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  late String uid; // Ajoutez un champ pour stocker l'identifiant unique de l'utilisateur
  late String name;
  late String email;
  late String phone;
  late String prenom;
  late String role;

  UserData({
    required this.uid, // Passez l'identifiant unique lors de la création d'un objet UserData
    required this.name,
    required this.email,
    required this.phone,
    required this.prenom,
    required this.role,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uid: json['uid'], // Récupérez l'identifiant unique à partir des données JSON
      email: json['email'],
      role: json['role'],
      name: json['name'],
      phone: json['phone'],
      prenom: json['prenom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid, // Inclure l'identifiant unique dans les données JSON
      'email': email,
      'role': role,
      'name': name,
      'phone': phone,
      'prenom': prenom,
    };
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveToFirestore() async {
    try {
      await firestore.collection('users').doc(uid).set(toJson());
    } catch (e) {
      print('Error saving user data to Firestore: $e');
    }
  }

  static Future<UserData?> getUserByEmail(String email) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      final QuerySnapshot snapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data() as Map<String, dynamic>;
        if (userData != null) {
          return UserData.fromJson(userData);
        }
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
    return null;
  }
}