import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/promo_slider.dart';
import 'News.dart';
import 'package:medical/searchBar.dart';
import 'package:medical/title.dart';
import 'category.dart';
import 'firebase_options.dart';
import 'leadingHomePage.dart';
import 'listViewProduct.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'navigationMenu.dart';
import 'searchScreen.dart';
import 'package:medical/mohamed/iconNotif.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  fetchDataFromFirestore();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicament',
      home: NavigationMenu(), // MyDashBoard(),
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
          elevation: 0.2,
          backgroundColor: const Color.fromRGBO(226, 239, 247, 1),
          leadingWidth: 0.9,
          toolbarHeight: 70,
          leading:const leadingHomePage(),
          actions: [
            Icon(Icons.notifications_off_rounded,color: Colors.green,size: 30,),
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
                  size: 30,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//             Padding(
//   padding: const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 0),
//   child: Center(
//     child: GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SearchScreen(products: products),
//           ),
//         );
//       },
//       child: const SearchBar(),
//     ),
//   ),
// ),
//             const SizedBox(
//               height: 20,
//             ),
            PromoSlider(),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: title("Categories", "See All"),
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
              padding: const EdgeInsets.all(8.0),
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
