// import 'package:cloud_firestore/cloud_firestore.dart';

// class Pharmacy {
//   final id;
//   final String name;
//   double distance;
//   final double latitude;
//   final String email;
//   final double longitude;
//   final List<String> imagePath;
//   bool isSelected;

//   Pharmacy({
//     required this.name,
//     required this.id,
//     this.distance = 300,
//     required this.latitude,
//     required this.longitude,
//     required this.email,
//     required this.imagePath,
//     this.isSelected = false,
//   });

//   // Factory method to create a Pharmacy from a Firestore document
//   factory Pharmacy.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return Pharmacy(
//       id:data['id'],
//       name: data['name'],
//       distance: data['distance']?.toDouble() ?? 300,
//       latitude: data['latitude'].toDouble(),
//       longitude: data['longitude'].toDouble(),
//       email: data['email'],
//       imagePath: List<String>.from(data['imagePath']),
//     );
//   }
// }
// Future<List<Pharmacy>> fetchPharmacies() async {
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('pharmacies').get();
//   return querySnapshot.docs.map((doc) => Pharmacy.fromFirestore(doc)).toList();
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class Pharmacy {
  final id;
  final String name;
  double distance;
  final double latitude;
  final String email;
  final double longitude;
  final List<String> imagePath;
  bool isSelected;

  Pharmacy({
    required this.name,
    required this.id,
    this.distance = 300,
    required this.latitude,
    required this.longitude,
    required this.email,
    required this.imagePath,
    this.isSelected = false,
  });

  factory Pharmacy.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Pharmacy(
      id:data['id'],
      name: data['name'],
      distance: data['distance']?.toDouble() ?? 300,
      latitude: data['latitude'].toDouble(),
      longitude: data['longitude'].toDouble(),
      email: data['email'],
      imagePath: List<String>.from(data['imagePath']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name': name,
      'distance': distance,
      'latitude': latitude,
      'longitude': longitude,
      'email': email,
      'imagePath': imagePath,
    };
  }

  // Method to send the Pharmacy to Firestore
  Future<void> sendToFirestorePharmacy() async {
    try {
      final pharmaciesRef = FirebaseFirestore.instance.collection('pharmacies');
      await pharmaciesRef.add(toJson());
      print('Pharmacy sent to Firestore successfully!');
    } catch (e) {
      print('Error sending Pharmacy to Firestore: $e');
    }
  }
}

List<Pharmacy> pharmacies = [];

Future<void> fetchDatapharmacyFromFirestore() async {
  try {
    final snapshot = await FirebaseFirestore.instance.collection('pharmacies').get();

    pharmacies.clear();

    for (var doc in snapshot.docs) {
      pharmacies.add(Pharmacy.fromFirestore(doc));
    }
  } on FirebaseException catch (e) {
    print('Error fetching data from Firestore: $e');
  }
}
