import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/promo_slider.dart';
import 'News.dart';
import 'package:medical/searchBar.dart';
import 'package:medical/title.dart';
import 'category.dart';
import 'firebase_options.dart';
import 'listViewProduct.dart';
import 'package:get/get.dart';

import 'navigationMenu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
  fetchDataFromFirestore();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicament',
      home:  NavigationMenu(),// MyDashBoard(),
      // MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    fetchDataFromFirestore();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          shadowColor: Colors.green,
          backgroundColor:
            const Color.fromRGBO(226, 239, 247, 1),
          leadingWidth: 0.9,
          toolbarHeight: 70,
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
                      width: 38,
                      height: 38,
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
                
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      Text("Hi, Adel !",
                          style: GoogleFonts.lexend(
                              fontSize: 14,
                              color: const Color.fromRGBO(16, 130, 96, 1))),
                      Text("Good Morning!",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
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
                        height: 18,
                      ),
                      Row(
                        children: [
                          Text(
                            "Your Location",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
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
                                fontSize: 11,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500),
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
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          children: const [
                            Icon(Icons.location_pin, color: Colors.green)
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(
                              Icons.notifications,
                              color: Colors.green,
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
        // backgroundColor: const Color.fromRGBO(
        //     226, 239, 247, 1), // That's primary color in my app
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 20),
            child: Column(children: [
              const SearchBar(),
              const SizedBox(
                height: 20,
              ),
              PromoSlider(),//ChangePictureDemo(),
              const title("Categories", "See All"),
              const SizedBox(height: 20),
             
            Category(),
              const SizedBox(
                height: 4,
              ),
              const title("New Products", "See All"),
              const SizedBox(
                height: 10,
              ),
              ListProduct(
                newsList: products,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
