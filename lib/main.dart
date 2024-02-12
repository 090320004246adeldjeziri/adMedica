import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical/appBar.dart';
import 'package:medical/itemList.dart';
import 'package:medical/searchBar.dart';
import 'package:medical/slider.dart';
import 'package:medical/title.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'listViewProduct.dart';
import 'barapping.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        
        title: 'Medicament',
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> productList = [
    Product(
      name: 'Paracetamol',
      description: 'Pain reliever and fever reducer',
      imageURL: 'https://example.com/paracetamol.jpg',
    ),
    Product(
      name: 'Aspirin',
      description: 'Pain reliever, anti-inflammatory drug',
      imageURL: 'https://example.com/aspirin.jpg',
    ),
    Product(
      name: 'Ibuprofen',
      description: 'Pain reliever, anti-inflammatory drug',
      imageURL: 'https://example.com/ibuprofen.jpg',
    ),
    Product(
      name: 'Ibuprofen',
      description: 'Pain reliever, anti-inflammatory drug',
      imageURL: 'https://example.com/ibuprofen.jpg',
    ),
    Product(
      name: 'Ibuprofen',
      description: 'Pain reliever, anti-inflammatory drug',
      imageURL: 'https://example.com/ibuprofen.jpg',
    ),
    Product(
      name: 'Ibuprofen',
      description: 'Pain reliever, anti-inflammatory drug',
      imageURL: 'https://example.com/ibuprofen.jpg',
    ),
    Product(
      name: 'Ibuprofen',
      description: 'Pain reliever, anti-inflammatory drug',
      imageURL: 'https://example.com/ibuprofen.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar( 
            elevation: 0.5,
            backgroundColor: const Color.fromRGBO(
          226, 239, 247, 1),
          leadingWidth: 0.8,
      leading:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: CircleAvatar(
                      backgroundColor:
                          Colors.blueAccent.shade400.withOpacity(0.8),
                      child: const Icon(
                        size: 25,
                        Icons.person_outline_outlined,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.center, 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 10,),
                Text("Hi, Adel !",
                    style: GoogleFonts.lexend(
                        fontSize: 13,
                        color: const Color.fromRGBO(16, 130, 96, 1))),
                Text("Good Morning!",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color.fromARGB(150, 76, 75, 1),
                    )),
              ])
            ])
      ]),
          ),
      backgroundColor: const Color.fromRGBO(
          226, 239, 247, 1), // That's primary color in my app
      body: Padding(
        padding:
            const EdgeInsets.only(top: 35, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            
            const appBar(),
            const SizedBox(
              height: 20,
            ),
            const SearchBar(),
            const SizedBox(
              height: 20,
            ),
            ChangePictureDemo(),
            const title("Categories", "See All"),
            const SizedBox(height: 20),
            item(),
            const SizedBox(
              height: 8,
            ),
            const title("New Products", "See All"),
            //TOdo TIME to create new widgets !!
          ],
        ),
      ),
    ));
  }
}
