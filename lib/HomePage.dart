import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/promo_slider.dart';
import 'package:medical/searchScreen.dart';
import 'package:medical/title.dart';
import 'News.dart';
import 'category.dart';
import 'listViewProduct.dart';
import 'mohamed/iconNotif.dart';

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
          elevation: 0.2,
          backgroundColor: const Color.fromRGBO(226, 239, 247, 1),
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
                            Colors.greenAccent,
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(
                    height: 18,
                  ),
                  Text("Hi, Sir !",
                      style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(16, 130, 96, 1))),
                  Text("Good Morning",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(150, 76, 75, 1),
                      )),
                ])
              ]),
          actions: [
            NotificationIcon(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(products: products),
                    ),
                  );
                },
                child: const Icon(
                  CupertinoIcons.search,
                  color: Colors.green,
                  size: 25,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//
            const PromoSlider(),
            const Padding(
              padding: EdgeInsets.only(left: 30, right: 10),
              child: title("Categories", ""),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Category(),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: title("New Products", "See All"),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: ListProduct(
                newsList: products,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
