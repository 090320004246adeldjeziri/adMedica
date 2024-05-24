import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoModel {
  final String id;
  final String imageUrl;
  final bool isRead;
  final List pharmacy;
  final String maladeId;
  final DateTime timestamp;

  PhotoModel({
    required this.id,
    required this.imageUrl,
    required this.isRead,
    required this.pharmacy,
    required this.maladeId,
    required this.timestamp,
  });

  // Méthode pour convertir un document Firestore en instance de Photo
  factory PhotoModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return PhotoModel(
      id: doc.id,
      imageUrl: data['image_url'] ?? '',
      isRead: data['isRead'] ?? false,
      pharmacy: data['pharmacy'] ?? '',
      maladeId: data['maladeId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Méthode pour convertir une instance de Photo en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'image_url': imageUrl,
      'isRead': isRead,
      'pharmacy': pharmacy,
      'maladeId': maladeId,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}