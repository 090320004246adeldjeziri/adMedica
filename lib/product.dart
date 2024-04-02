// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:medical/News.dart';
import 'package:medical/itemList.dart';
import 'package:medical/main.dart';
import 'package:medical/title.dart';

import 'FavoriteManager.dart';
import 'carteManager.dart';
import 'navigationMenu.dart';

class InfoProduct extends StatefulWidget {
  final CabItem newsItem;

  InfoProduct({
    Key? key,
    required this.newsItem,
  }) : super(key: key);

  @override
  _InfoProductState createState() => _InfoProductState();
}

class _InfoProductState extends State<InfoProduct> {
  late CabItem _newsitem;

  @override
  void initState() {
    super.initState();
    _newsitem = widget.newsItem;
  }

  int currentImageIndex = 0;

  int quantity = 1;

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

// Inside _InfoProductState class

  void _addToCart() {
    CartManager.addToCart(widget.newsItem);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to cart'),
      ),
    );
  }

  void _changeImage(bool forward) {
    setState(() {
      if (forward) {
        currentImageIndex = (currentImageIndex + 1) % _newsitem.imgUrl.length;
      } else {
        currentImageIndex = (currentImageIndex - 1 + _newsitem.imgUrl.length) %
            _newsitem.imgUrl.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(226, 239, 247, 1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            collapsedHeight: MediaQuery.of(context).size.height * 0.07,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.43,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned(
                    child: Image.network(
                      _newsitem.imgUrl[currentImageIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 150,
                    right: 10,
                    child: IconButton(
                        onPressed: () => _changeImage(true),
                        icon: const Icon(
                            size: 40,
                            Icons.navigate_next,
                            color: Colors.white)),
                  ),
                  Positioned(
                    bottom: 150,
                    left: 10,
                    child: IconButton(
                        onPressed: () => _changeImage(true),
                        icon: const Icon(
                            size: 40,
                            Icons.navigate_before,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
            backgroundColor: const Color.fromRGBO(226, 239, 247, 1),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationMenu()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Color.fromRGBO(16, 130, 96, 1),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  width: 45,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        FavoritesManager.addToFavorites(widget.newsItem);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added to favorites'),
                          ),
                        );
                      });
                    },
                    icon: const Icon(Icons.favorite_border),
                    iconSize: 30,
                    color: Color.fromRGBO(16, 130, 96, 1),
                  ),
                ),
              ),
            ],
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: SizedBox(
                height: 30,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(226, 239, 247, 1),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(36.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 3, left: 5, right: 5, bottom: 3),
                    child: Text(
                      _newsitem.productName,
                      style: GoogleFonts.lexend(
                        fontSize: 23,
                        color: const Color.fromRGBO(16, 130, 96, 1),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => _decrementQuantity(),
                                icon: const Icon(Icons.remove, size: 26),
                              ),
                              const SizedBox(width: 3),
                              Container(
                                width: 37,
                                alignment: AlignmentDirectional.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  quantity.toString(),
                                  style: GoogleFonts.lexend(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 2),
                              IconButton(
                                onPressed: () => _incrementQuantity(),
                                icon: const Icon(Icons.add, size: 26),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            (double.parse(_newsitem.prix)*quantity).toString()+"DA" ,
                            style: GoogleFonts.lexend(
                              fontSize: 23,
                              color: const Color.fromRGBO(16, 130, 96, 1),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                Text(
                  "Description",
                  style: GoogleFonts.lexend(
                    fontSize: 23,
                    color: const Color.fromRGBO(16, 130, 96, 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      _newsitem.description,
                      style: GoogleFonts.lexend(
                        fontSize: 15,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: ElevatedButton(
                    onPressed: () {}, //=> _addToCart(),
                    child: Text(
                      "Add To Carte ",
                      style: GoogleFonts.lexend(
                        fontSize: 23,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
