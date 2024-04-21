import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../News.dart';

class ProductController extends GetxController {
  final RxList<CabItem> products = <CabItem>[].obs;

  // Method to fetch products from Firestore based on category
  Future<void> fetchProductsByCategory(String category) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('category', isEqualTo: category)
          .get();

      products.clear();

      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        products.add(
          CabItem.fromJson(data),
        );
      }
    } catch (e) {
      print('Error fetching products from Firestore: $e');
    }
  }

  Future<void> fetchAllProducts() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("items").get();
      products.clear();
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        products.add(CabItem.fromJson(data));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //     for (var doc in snapshot.docs) {
  //       var data = doc.data() as Map<String, dynamic>;
  //       products.add(
  //         CabItem.fromJson(data),
  //       );
  //     }
  //   } catch (e) {
  //     print('Error fetching all products from Firestore: $e');
  //   }
  // }
}
