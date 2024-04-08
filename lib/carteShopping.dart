import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical/FavoriteManager.dart';
import 'package:medical/News.dart';
import 'package:medical/product.dart';
import 'package:google_fonts/google_fonts.dart';
import 'carteManager.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(226, 239, 247, 1),
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.09,
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(226, 239, 247, 1),
          elevation: 0.2,
          leading: Text(''),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert_sharp,
                      color: Colors.green, size: 28),
                ),
              ),
            ),
          ],
          title: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('My Cart', style: TextStyle(color: Colors.green)),
          ),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
          itemCount: CartManager.cartItems.length,
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
                          CartManager.cartItems[index].imgUrl[0],
                          width: double.infinity,
                          height: 140, // Fixed height for images
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
                              CartManager.cartItems.removeAt(index);
                            });
                          },
                          icon: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(boxShadow: const [
                               BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  color: Colors.red)
                            ], color: Colors.white.withOpacity(1), shape: BoxShape.circle),
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
                          "${CartManager.cartItems[index].prix}DA",
                          style: GoogleFonts.lexend(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            icon: const Icon(
                              CupertinoIcons.heart,
                              color: Colors.green,
                            ),
                            onPressed: (() => setState(() {
                                  if (!FavoritesManager.isFavorite(
                                      CartManager.cartItems[index])) {
                                    FavoritesManager.addToFavorites(
                                        CartManager.cartItems[index]);
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
      ),
    );
  }
}
