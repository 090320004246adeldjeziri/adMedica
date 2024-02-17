import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:medical/druglist.dart';
import 'package:medical/itemList.dart';
import 'package:medical/product.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ItemProduct> productList = [
      ItemProduct(
        titleProduct: 'Cleaning',
        urlImg: 'assets/images/clean.jpg',
        price: "150da",
        description:
            "This description explains how to use this product. Please make sure you want to buy something before sending a request!",
      ),
      ItemProduct(
        titleProduct: 'Makeup',
        urlImg: 'assets/images/makeup.jpg',
        price: "250da",
        description:
            "Now let's talk seriously about selling products. Now we want to make sure you love our product so you should buy, or I'm gonna kill you!",
      ),
      ItemProduct(
        titleProduct: 'Mother & Babe',
        urlImg: 'assets/images/mam&babe.jpg',
        price: "350da",
        description:
            "So you want to learn English? Okay, that's good, but you need to put in the necessary effort to get it!",
      ),
      ItemProduct(
        titleProduct: 'Vitamin',
        urlImg: 'assets/images/vitamine.jpg',
        price: "100da",
        description:
            "Here we offer quality products at the best prices. So are you going to buy or what?",
      ),
    ];

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Returning data to the previous screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => item()),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage(product.urlImg),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              alignment: Alignment.center,
                              height: 30,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                product.titleProduct,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Colors.black87,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              // Add to wishlist logic here
                            },
                            icon: const Icon(Icons.shopping_cart),
                            color: Colors.red,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 20,
                              alignment: Alignment.center,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                product.price,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
