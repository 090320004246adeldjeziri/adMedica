import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/auth/Users.dart';
import 'package:medical/client/promo_slider.dart';
import 'package:medical/controller/SignUpController.dart';
import 'package:medical/searchScreen.dart';
import 'package:medical/widgets/title.dart';
import 'News.dart';
import 'package:get/get.dart';
import 'category.dart';
import 'controller/settingController.dart';
import 'listViewProduct.dart';
import 'mohamed/iconNotif.dart';

// Constantes pour les couleurs
const kPrimaryColor = Color.fromRGBO(226, 239, 247, 1);
const kAccentColor = Color.fromRGBO(16, 130, 96, 1);
const kTextColor = Color.fromARGB(150, 76, 75, 1);

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<UserData?> fetchUserByEmail(String email) async {
    UserData? user = await UserData.getUserByEmail(email);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    final SettingController controller = Get.put(SettingController());

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          elevation: 4,
          backgroundColor: Colors.greenAccent.withOpacity(0.9),
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 40,
                      child: FutureBuilder<UserData?>(
                        future: fetchUserByEmail(user!.email.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Client");
                          } else if (snapshot.hasError) {
                            return const Text("Client");
                          } else if (snapshot.hasData) {
                            UserData? user = snapshot.data;
                            return user != null
                                ? Text(user.name,
                                    style: GoogleFonts.pontanoSans(
                                        color: Colors.white, fontSize: 19,fontWeight: FontWeight.w700))
                                : const Text("Client");
                          }
                          return const Text("");
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    FutureBuilder<UserData?>(
                      future: fetchUserByEmail(user!.email.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            "Chargement...",
                            style: TextStyle(color: Colors.white),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            "Erreur : ${snapshot.error}",
                            style: GoogleFonts.lexend(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          UserData? userData = snapshot.data;
                          return userData != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userData.email,
                                      style: GoogleFonts.lexend(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                )
                              : Text(
                                  "Aucune donnée utilisateur",
                                  style: GoogleFonts.lexend(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                );
                        }
                        return Text(
                          "Erreur",
                          style: GoogleFonts.lexend(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.language, color: Colors.white),
                title: Text(
                  'Language',
                  style: GoogleFonts.lexend(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: Text(
                  'Personal Information',
                  style: GoogleFonts.lexend(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  // Ajoutez ici la fonctionnalité pour "Personal Information"
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    controller.logout();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    primary: Colors.green.withOpacity(0.7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline_outlined, color: Colors.white),
                      SizedBox(width: 8.0),
                      Text(
                        'Sign Out',
                        style: GoogleFonts.lexend(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0.2,
          backgroundColor: kPrimaryColor,
          leadingWidth: 56,
          toolbarHeight: 70,
          title: FutureBuilder<UserData?>(
            future: fetchUserByEmail(user!.email.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("");
              } else if (snapshot.hasError) {
                return Text("");
              } else if (snapshot.hasData) {
                UserData? user = snapshot.data;
                return user != null
                    ? Text(
                        "Hi ${user.name}",
                        style: GoogleFonts.lexend(color: Colors.green),
                      )
                    : Text("");
              }
              return Text("");
            },
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.green),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const PromoSlider(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: title("Categories", ""),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  child: Category(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: title("New Products", "See All"),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListProduct(
                  newsList:
                      products, // Assurez-vous que products est défini et contient des données
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
