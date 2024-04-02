import 'package:flutter/material.dart';
import 'package:medical/News.dart';
import 'package:medical/product.dart';

class CartPage extends StatelessWidget {
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
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10),
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back, color: Colors.green, size: 28),
              ),
            ),
          ),
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
        body: ListView.builder(
          itemCount: CartManager.cartItems.length,
          itemBuilder: (context, index) {
            final newsItem = CartManager.cartItems[index];
            return Column(
              children: [
                ListTile(
                  iconColor: Colors.green,

                  title: Text("newsItem.title"),
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                     newsItem.imgUrl.first,
                      ),
                    ),
                  ),
                  // Add more details of the item here as needed
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      CartManager.removeFromCart(newsItem);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Removed from cart'),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                  child: Container(
                    width: double.infinity,
                    height: 0.01,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
