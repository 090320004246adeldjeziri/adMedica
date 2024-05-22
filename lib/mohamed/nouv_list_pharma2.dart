// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class LIstPharma2 extends StatefulWidget {
//   final String name;
//   const LIstPharma2({super.key, required this.name});

//   @override
//   State<LIstPharma2> createState() => _LIstPharma2State();
// }

// class _LIstPharma2State extends State<LIstPharma2> {
//   // Map pour garder la trace des états de chaque case à cocher
//   Map<String, bool> _selectedUsers = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pharmacy Users'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('users')
//                   .where('role', isEqualTo: 'Pharmacy')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text('Une erreur s\'est produite : ${snapshot.error}'),
//                   );
//                 }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(child: Text('Aucun utilisateur trouvé.'));
//                 }

//                 var users = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: users.length,
//                   itemBuilder: (context, index) {
//                     var user = users[index];
//                     var userData = user.data() as Map<String, dynamic>;
//                     var userId = user.id;

//                     // Initialiser l'état de la case à cocher si nécessaire
//                     if (_selectedUsers[userId] == null) {
//                       _selectedUsers[userId] = false;
//                     }

//                     return Card(
//                       child: ListTile(
//                         leading: Checkbox(
//                           value: _selectedUsers[userId],
//                           onChanged: (bool? value) {
//                             setState(() {
//                               _selectedUsers[userId] = value!;
//                             });
//                           },
//                         ),
//                         title: Text(userData['name'] ?? 'Nom inconnu'),
//                         subtitle: Text('Distance' ),
//                         // Ajouter d'autres champs si nécessaire
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
