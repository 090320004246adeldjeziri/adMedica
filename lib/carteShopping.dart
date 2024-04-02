import 'package:flutter/material.dart';
import 'package:medical/News.dart';
import 'package:medical/product.dart';

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
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: CartManager.cartItems.length,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                    alignment: Alignment.center,
                    CartManager.cartItems[index].imgUrl[0]),
                TextButton(
                    onPressed: () {
                      setState(() {
                        CartManager.cartItems.removeAt(index);
                      });
                    },
                    child: Text('Remove'))
              ],
            ),
          );
        },
      ),
      ),
    );
  }
}
