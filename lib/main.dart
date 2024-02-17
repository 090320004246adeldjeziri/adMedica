import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical/appBar.dart';
import 'package:medical/itemList.dart';
import 'package:medical/product.dart';
import 'package:medical/searchBar.dart';
import 'package:medical/slider.dart';
import 'package:medical/title.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dashbord.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicament',
      home: MyDashBoard(),
      // MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color.fromRGBO(226, 239, 247, 1),
          leadingWidth: 0.8,
          leading: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
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
              ]),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Your Location",
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.green,
                                fontStyle: FontStyle.normal),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Ain Témouchent",
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.green,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Column(
                          children: const [
                            Icon(Icons.map_sharp, color: Colors.green)
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(
                              Icons.notifications,
                              color: Colors.green,
                              semanticLabel: "news!",
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 11,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(
            226, 239, 247, 1), // That's primary color in my app
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
            child: Column(children: [
              // const appBar(),
              // const SizedBox(
              //   height: 20,
              // ),
              const SearchBar(),
              const SizedBox(
                height: 20,
              ),
              ChangePictureDemo(),
              const title("Categories", "See All"),
              const SizedBox(height: 20),
              item(),
              const SizedBox(
                height: 4,
              ),
              const title("New Products", "See All"),
       
              const SizedBox(
                height: 10,
              ),
              const ListProduct()
            ]),
          ),
        ),
      ),
    );
  }
}
