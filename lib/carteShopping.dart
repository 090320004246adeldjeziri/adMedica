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
          leading: const Text(''),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert_sharp,
                      color: Colors.green, size: 28),
                ),
              ),
            ),
          ],
          title: const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('My Cart', style: TextStyle(color: Colors.green)),
          ),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600
                ? 4
                : 2, // Adjust cross axis count based on screen width
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: CartManager.cartItems.length,
          itemBuilder: (context, index) {
            return Container(
              // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.blue.withOpacity(0.09),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 120, // Fixed height for the image container
                      child: Image.network(
                        CartManager.cartItems[index].imgUrl[0],
                        fit: BoxFit
                            .cover, // Adjust the image inside the container
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${CartManager.cartItems[index].prix}DA",
                          style: GoogleFonts.lexend(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            CupertinoIcons.heart,
                            color: Colors.green,
                          ),
                          onPressed: () => setState(() {
                            if (!FavoritesManager.isFavorite(
                                CartManager.cartItems[index])) {
                              FavoritesManager.addToFavorites(
                                  CartManager.cartItems[index]);
                            }
                          }),
                        ),
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
