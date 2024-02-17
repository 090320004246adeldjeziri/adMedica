import 'package:flutter/material.dart';

class ItemProduct {
  String titleProduct;
  String urlImg;
  String price;
  String description;

  ItemProduct({
    required this.titleProduct,
    required this.urlImg,
    required this.price,
    required this.description,
  });
}

// class InfoProduct extends StatelessWidget {
//   const InfoProduct({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     final item product = ModalRoute.of(context)!.settings.arguments as ItemProduct;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.titleProduct),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(product.urlImg),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.titleProduct,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Price: ${product.price}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Description:',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     product.description,
//                     style: const TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
