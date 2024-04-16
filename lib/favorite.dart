import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical/FavoriteManager.dart';
import 'package:get/get.dart';
import 'package:medical/carteManager.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(226, 239, 247, 1),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(226, 239, 247, 1),
        elevation: 0.2,
        leading: Text(""),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: Container(
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: IconButton(
                onPressed: () {},
                icon:
                    Icon(Icons.more_vert_sharp, color: Colors.green, size: 28),
              ),
            ),
          ),
        ],
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text('My Favorites', style: TextStyle(color: Colors.green)),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
        itemCount: FavoritesManager.favorits.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(left: 8, right: 8, top: 8),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.blue.withOpacity(0.09),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      child: Image.network(
                        FavoritesManager.favorits[index].imgUrl[0],
                        width: double.infinity,
                        height: 120, // Fixed height for images
                        fit: BoxFit
                            .cover, // Adjust the image inside the container
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            FavoritesManager.favorits.removeAt(index);
                          });
                        },
                        icon: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    color: Colors.red)
                              ],
                              color: Colors.white.withOpacity(1),
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.clear_rounded,
                            size: 26,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${FavoritesManager.favorits[index].prix} DA",
                        style: GoogleFonts.lexend(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          icon: const Icon(
                            CupertinoIcons.bag_badge_plus,
                            color: Colors.green,
                          ),
                          onPressed: (() => setState(() {
                                if (!CartManager.isInCart(
                                    FavoritesManager.favorits[index])) {
                                  CartManager.addToCart(
                                      FavoritesManager.favorits[index]);
                                }
                              })))
                      // Add other buttons or text here
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
