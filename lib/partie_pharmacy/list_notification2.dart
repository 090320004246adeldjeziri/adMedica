// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Notif extends StatefulWidget {
//   const Notif({Key? key}) : super(key: key);

//   @override
//   State<Notif> createState() => _NotifState();
// }

// class _NotifState extends State<Notif> {
//   String? userName;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUserName();
//   }

//   Future<void> _getCurrentUserName() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();

//         if (userDoc.exists) {
//           setState(() {
//             userName = userDoc['name'] as String;
//           });
//         } else {
//           print('User document does not exist');
//         }
//       } else {
//         print('No user is currently signed in');
//       }
//     } catch (e) {
//       print('Error fetching current user name: $e');
//     }
//   }

//   Future<String> _getSenderName(String senderId) async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(senderId)
//           .get();

//       if (userDoc.exists) {
//         return userDoc['name'] as String;
//       } else {
//         return 'Unknown user';
//       }
//     } catch (e) {
//       print('Error fetching sender name: $e');
//       return 'Error';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(userName != null ? 'Notifications - $userName' : 'Notifications'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('photo')
//             .where('isRead', isEqualTo: false)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return const Center(child: Text('Erreur de chargement des notifications'));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('Aucune image reçue'));
//           }

//           List<Future<String>> senderNameFutures = snapshot.data!.docs
//               .map((doc) => _getSenderName(doc['senderId'] as String))
//               .toList();

//           return FutureBuilder<List<String>>(
//             future: Future.wait(senderNameFutures),
//             builder: (context, senderNamesSnapshot) {
//               if (senderNamesSnapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (senderNamesSnapshot.hasError) {
//                 return const Center(child: Text('Erreur de chargement des noms des expéditeurs'));
//               }

//               List<String> senderNames = senderNamesSnapshot.data ?? [];

//               return ListView.builder(
//                 itemCount: senderNames.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                       title: Text('Image reçue de ${senderNames[index]}'),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }