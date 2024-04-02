import 'package:flutter/material.dart';
import 'package:medical/product.dart'; // Import the InfoProduct class
import 'package:medical/News.dart';

class ListProduct extends StatefulWidget {
  final List<CabItem> newsList; // Your list of NewsItem objects

  const ListProduct(
      {Key? key, required this.newsList})
      : super(key: key);

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  late CabItem item;
  void _addToCart(CabItem item) {
    CartManager.addToCart(item);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to cart'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.newsList.length,
        itemBuilder: (context, index) {
          final newsItem = widget.newsList[index];
          return GestureDetector(
            onTap: () {
              // fetchDataFromFirestore();
              // products[index].sendToFirestore();
              // productList.sendToFirestore();
              // Navigate to InfoProduct screen and pass the selected NewsItem
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoProduct(
                    newsItem: newsItem,
                    
                  ),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        image: DecorationImage(
                          image: NetworkImage(products[index].imgUrl[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
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
                          onPressed:
                          ()=> _addToCart(newsItem),
                          icon: const Icon(Icons.shopping_cart_outlined),
                          // icon: Icon(Icons.shopping_cart),
                          color: Colors.green,
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
                            child: const Text(
                              '100da', // Set your price here
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
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
